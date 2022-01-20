import 'package:composers_lounge/core/route_names.dart';
import 'package:composers_lounge/services/auth_service.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:composers_lounge/states/auth/auth_cubit.dart';
import 'package:composers_lounge/core/routes_config.dart';
import 'package:composers_lounge/states/channels/channels_cubit.dart';
import 'package:composers_lounge/states/messaging/messaging_cubit.dart';
import 'package:composers_lounge/states/user_photo/user_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChannelService>(
          create: (context) => ChannelServiceMock(),
        ),
        RepositoryProvider<AuthService>(
          create: (context) => AuthServiceMock(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(context.read<AuthService>()),
          ),
          BlocProvider(
            create: (context) => ChannelListCubit(
              context.read<ChannelService>(),
              context.read<AuthService>(),
            ),
          ),
          BlocProvider(
            create: (context) => MessagingCubit(context.read<ChannelService>()),
          ),
          BlocProvider(
            create: (context) => UserPhotoCubit(context.read<AuthService>()),
          ),
        ],
        child: MaterialApp(
          routes: routesConfig,
          initialRoute: RouteNames.login,
          theme: ThemeData(
            primarySwatch: Colors.green,
            textTheme: Typography.blackCupertino,
          ),
        ),
      ),
    );
  }
}
