import 'package:composers_lounge/services/auth_service.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:composers_lounge/states/auth/auth_cubit.dart';
import 'package:composers_lounge/core/routes_config.dart';
import 'package:composers_lounge/states/cubit/channels_cubit.dart';
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
      ],
      child: MaterialApp(
        routes: routesConfig,
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: Typography.blackCupertino,
        ),
      ),
    );
  }
}
