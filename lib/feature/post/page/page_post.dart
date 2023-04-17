import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/post/bloc/cubit_post.dart';
import 'package:didit/feature/post/widget/view_posted.dart';
import 'package:didit/feature/post/widget/view_unposted.dart';
import 'package:didit/feature/post/widget/dialog_permission_post.dart';
import 'package:didit/feature/post/widget/dialog_upload.dart';
import 'package:didit/feature/post/widget/dialog_error_upload.dart';
import 'package:didit/common/cubit_appsettings.dart';
import 'package:didit/common/dialog_error.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: BlocConsumer<PostCubit, PostState>(
        listenWhen: (previousState, state) {
          if (state is PostPermission ||
              state is PostFailure ||
              state is PostUploadFailure ||
              state is PostUploading ||
              state is PostUploaded) {
            return true;
          } else {
            return false;
          }
        },
        listener: (BuildContext context, state) {
          if (state is PostPermission) {
            showDialog(
              context: context,
              builder: (context) => BlocProvider<AppSettingsCubit>(
                create: (context) => AppSettingsCubit(),
                child: const CameraPostDialog(),
              ),
            );
          }
          if (state is PostFailure) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(error: state.error),
            );
          }
          if (state is PostUploadFailure) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => UploadErrorDialog(error: state.error),
            );
          }
          if (state is PostUploading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return const UploadDialog();
              },
            );
          }
          if (state is PostUploaded) {
            context.pop();
            context.pop();
          }
        },
        buildWhen: (previousState, state) {
          if (state is PostLoading ||
              state is PostLoaded ||
              state is PostEmpty ||
              state is PostError) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 1));
          } else if (state is PostLoaded) {
            return PostedView(data: state.data);
          } else if (state is PostEmpty) {
            return UnpostedView(postModel: state.match);
          } else if (state is PostError) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  right: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Error',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(state.error),
                    ],
                  ),
                ),
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