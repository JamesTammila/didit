import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_user.dart';

class MatchDialog extends StatelessWidget {
  const MatchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Shoe Selfie"),
          Text("22:10"),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              UserView(
                userModel: UserModel(
                  objectId: '',
                  createdAt: '',
                  username: 'You',
                  proPicUri:
                      'https://i.pinimg.com/736x/78/4f/e8/784fe85e83e44328112af4298efdd9d6.jpg',
                  friendState: 'ME',
                  requestId: '',
                ),
              ),
              Icon(Icons.access_time_filled_rounded, color: Colors.yellow),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              UserView(
                userModel: UserModel(
                  objectId: '',
                  createdAt: '',
                  username: 'Anna',
                  proPicUri:
                  'https://data.whicdn.com/images/298487925/original.jpg?t=1534274746',
                  friendState: 'ME',
                  requestId: '',
                ),
              ),
              Icon(Icons.access_time_filled_rounded, color: Colors.yellow),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              UserView(
                userModel: UserModel(
                  objectId: '',
                  createdAt: '',
                  username: 'Johanna',
                  proPicUri:
                  'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
                  friendState: 'ME',
                  requestId: '',
                ),
              ),
              Icon(Icons.check, color: Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              UserView(
                userModel: UserModel(
                  objectId: '',
                  createdAt: '',
                  username: 'Adam',
                  proPicUri:
                  'https://i.pinimg.com/736x/e0/21/8f/e0218f2b6a1d7c71f080749045233c63.jpg',
                  friendState: 'ME',
                  requestId: '',
                ),
              ),
              Icon(Icons.check, color: Colors.green),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Leave", style: TextStyle(color: Colors.red)),
          onPressed: () => Navigator.pop(context),
        ),
        FilledButton(
          child: const Text("Post"),
          onPressed: () async {
            final XFile? photo = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1350);
            int? value = await photo?.length();
            debugPrint('Image Picker: ' + value.toString());

            /*File imageFile = File(image.path);

            Directory temporaryDirectory = await getTemporaryDirectory();
            String temporaryPath = temporaryDirectory.path;

            debugPrint('0: ' + await image.length().toString());
            debugPrint('1: ' + await imageFile.length().toString());

            final result = await FlutterImageCompress.compressAndGetFile(
              image.path,
              '$temporaryPath/image.jpg',
              quality: 50,
            );

            debugPrint('2: ' + await result!.length().toString());

            await imageFile.delete();
            ParseFile imageParseFile = ParseFile(result);
            await result.delete();
            await imageParseFile.save();*/
          },
        ),
      ],
    );
  }
}