import 'package:composers_lounge/core/route_names.dart';
import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:flutter/material.dart';

class ChannelListScreen extends StatelessWidget {
  const ChannelListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      isBackButtonHidden: true,
      title: 'My Channels',
      child: Column(
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(RouteNames.channel),
            child: const Text('Channel'),
          ),
          // TODO - next: Read msgBus docs and create appropriate models and sevice methods
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(RouteNames.userProfile),
            child: const Text('My profile'),
          ),
        ],
      ),
    );
  }
}
