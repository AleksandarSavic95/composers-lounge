import 'package:composers_lounge/core/route_names.dart';
import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:composers_lounge/states/auth/auth_cubit.dart';
import 'package:composers_lounge/states/channels/channels_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Login screen',
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Composer's Lounge 🎶",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              autofocus: true,
              onSubmitted: context.read<AuthCubit>().login,
            ),
            const SizedBox(height: 4),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoaded && state.user != null) {
                  context.read<ChannelsCubit>().loadChannels(state.user!);
                  Navigator.of(context).pushNamed(RouteNames.channelList);
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                }
                return TextButton(
                  onPressed: () => context.read<AuthCubit>().login(usernameController.text),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
