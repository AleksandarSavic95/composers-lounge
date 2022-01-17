import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'User profile screen',
      child: Column(
        children: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Back to list of chats'),
          ),
        ],
      ),
    );
  }
}
