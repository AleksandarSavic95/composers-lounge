import 'package:composers_lounge/core/route_names.dart';
import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:composers_lounge/states/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'User profile screen',
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              context.read<AuthCubit>().logOut();
              Navigator.of(context).popUntil(ModalRoute.withName(RouteNames.login));
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
