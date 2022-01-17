import 'package:composers_lounge/core/route_names.dart';
import 'package:composers_lounge/features/channels/channel_list_screen.dart';
import 'package:composers_lounge/features/channels/channel_screen.dart';
import 'package:composers_lounge/features/user/login_screen.dart';
import 'package:composers_lounge/features/user/user_profile_screen.dart';

final routesConfig = {
  // RouteNames.splash: (_) => const SplashScreen(),
  RouteNames.login: (_) => const LoginScreen(),
  RouteNames.channelList: (_) => const ChannelListScreen(),
  RouteNames.channel: (_) => const ChannelScreen(),
  RouteNames.userProfile: (_) => const UserProfileScreen(),
};
