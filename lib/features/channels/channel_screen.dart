import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:flutter/material.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Chat screen',
      child: Column(
        children: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            // () => Navigator.of(context).pushNamed(RouteNames.channelList),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}
