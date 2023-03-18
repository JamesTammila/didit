import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/account/bloc/cubit_edit.dart';
import 'package:didit/feature/account/widget/dialog_picture.dart';
import 'package:didit/feature/account/widget/dialog_permission_picture.dart';
import 'package:didit/common/cubit_appsettings.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(context) {
    final bloc = context.read<EditCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.transparent],
            ),
          ),
        ),
      ),
      body: BlocConsumer<EditCubit, EditState>(
        listener: (context, state) {
          if (state is EditPermission) {
            showDialog(
              context: context,
              builder: (context) => BlocProvider<AppSettingsCubit>(
                create: (context) => AppSettingsCubit(),
                child: const CameraPictureDialog(),
              ),
            );
          }
          if (state is EditSaving) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Saving...')
                    ],
                  ),
                );
              },
            );
          }
          if (state is EditFinished) {
            context.pop();
            context.pop();
          }
        },
        buildWhen: (previousState, state) {
          if (state is EditLoading || state is EditLoaded) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is EditLoading) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 1));
          } else if (state is EditLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              stops: [0, 0.1],
                              colors: <Color>[Colors.black, Colors.white],
                            ).createShader(bounds);
                          },
                          child: BlocBuilder<EditCubit, EditState>(
                              buildWhen: (previousState, state) {
                                if (state is EditPreview) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              builder: (context, state) {
                              if (state is EditLoaded) {
                                return CachedNetworkImage(
                                  cacheManager: context.read<CustomCacheManager>(),
                                  fit: BoxFit.cover,
                                  imageUrl: state.data['url'] ?? '',
                                  cacheKey: state.data['url'].split('?')[0],
                                  errorWidget: (context, url, error) {
                                    if (url.isEmpty) {
                                      return Container(
                                        color: Color(state.data['color']),
                                        alignment: Alignment.center,
                                        child: Text(
                                          state.data['username'].substring(0, 1).toUpperCase(),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    } else {
                                      return const Center(child: Text('Something went wrong...'));
                                    }
                                  },
                                );
                              } else if (state is EditPreview) {
                              return Image.file(
                                File(state.path ?? ''),
                                fit: BoxFit.cover,
                              );
                            } else {
                                return const SizedBox();
                              }
                            }
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                          padding:
                              MaterialStateProperty.all(const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 15,
                            right: 15,
                          )),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: const PictureDialog(),
                          ),
                        ),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Change Profile Picture'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        initialValue: state.data['name'] ?? '',
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        decoration: const InputDecoration(hintText: 'Name'),
                        onChanged: (s) => context.read<EditCubit>().setName(s),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: TextFormField(
                        initialValue: state.data['bio'] ?? '',
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        maxLength: 500,
                        decoration: const InputDecoration(hintText: 'Bio'),
                        onChanged: (s) => context.read<EditCubit>().setBio(s),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FilledButton(
                      onPressed: () => context.read<EditCubit>().saveProfile(),
                      child: const Text('Save'),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}