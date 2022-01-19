import 'dart:io';

import 'package:composers_lounge/core/route_names.dart';
import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:composers_lounge/model/user.dart';
import 'package:composers_lounge/states/auth/auth_cubit.dart';
import 'package:composers_lounge/states/user_photo/user_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'User profile screen',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(child: Center(child: _UserImage())),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.read<AuthCubit>().logOut();
                Navigator.of(context).popUntil(ModalRoute.withName(RouteNames.login));
              },
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserImage extends StatefulWidget {
  const _UserImage({Key? key}) : super(key: key);

  @override
  __UserImageState createState() => __UserImageState();
}

class __UserImageState extends State<_UserImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: const _PhotoInput(),
    );
  }

  void _pickImage() async {
    final XFile? photo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo == null) {
      return;
    }
    context.read<UserPhotoCubit>().setPhoto(File(photo.path));
  }
}

class _PhotoInput extends StatelessWidget {
  const _PhotoInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserPhotoCubit, UserPhotoState>(
      listener: (context, state) {
        if (state is UserPhotoUploaded) {
          context.read<AuthCubit>().setUserPhoto(state.photoUrl);
        }
      },
      builder: (context, state) {
        if (state is UserPhotoInitial) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is! AuthUpdated && authState is! AuthSuccessful) {
                return const Text('Error while loading user profile');
              }
              User? user = authState is AuthUpdated ? authState.user : (authState as AuthSuccessful).user;
              if (user != null) {
                return user.photoUrl != null
                    ? Image.network(user.photoUrl!)
                    : Card(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Text(
                            'Take a photo',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      );
              }
              return const Text('Error while loading user profile');
            },
          );
        }
        final List<Widget> children = [];
        if (state is UserPhotoSelected || state is UserPhotoUploading || state is UserPhotoUploaded) {
          children.addAll([
            Expanded(child: Image.file(state.photo!)),
            const SizedBox(height: 16),
          ]);
        }
        if (state is UserPhotoUploading) {
          children.add(const Center(child: CircularProgressIndicator()));
        }
        if (state is UserPhotoSelected) {
          children.add(TextButton(
            onPressed: context.read<UserPhotoCubit>().uploadPhoto,
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 32),
            ),
          ));
        }
        if (state is UserPhotoUploaded) {
          children.add(const Text(
            'Done!',
            style: TextStyle(fontSize: 32),
          ));
        }
        return Column(children: children);
      },
    );
  }
}
