import 'package:composers_lounge/core/route_names.dart';
import 'package:composers_lounge/services/auth_service.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:composers_lounge/states/auth/auth_cubit.dart';
import 'package:composers_lounge/core/routes_config.dart';
import 'package:composers_lounge/states/channels/channels_cubit.dart';
import 'package:composers_lounge/states/messages/messages_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthServiceMock()),
        ),
        BlocProvider(
          create: (context) => ChannelsCubit(ChannelServiceMock()),
        ),
        BlocProvider(
          create: (context) => MessagesCubit(ChannelServiceMock()),
        ),
        BlocProvider(
          create: (context) => UserPhotoCubit(AuthServiceMock()),
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
    );
  }
}
