import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                          child: CachedNetworkImage(
                            cacheManager: context.read<CustomCacheManager>(),
                            fit: BoxFit.cover,
                            imageUrl: state.userModel.getUrl,
                            cacheKey: state.userModel.getUrl.split('?')[0],
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
                        initialValue: state.userModel.username,
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
                        initialValue: state.userModel.bio,
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