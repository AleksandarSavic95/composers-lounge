import 'package:composers_lounge/core/route_names.dart';
import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:composers_lounge/states/channels/channels_cubit.dart';
import 'package:composers_lounge/states/user_photo/user_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChannelListScreen extends StatelessWidget {
  const ChannelListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      onWillPop: () => false,
      isBackButtonHidden: true,
      title: 'My Channels',
      child: Column(
        children: [
          BlocBuilder<ChannelListCubit, ChannelListState>(
            builder: (context, state) {
              if (state is ChannelsError) {
                return const Text('Channels not loaded..');
              }
              if (state is ChannelsLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.channels.length,
                    itemBuilder: (context, index) {
                      final channel = state.channels[index];
                      return ListTile(
                        title: Text(channel.name),
                        subtitle: Text(channel.id),
                        onTap: () => Navigator.of(context).pushNamed(
                          RouteNames.channel,
                          arguments: channel.id,
                        ),
                      );
                    },
                  ),
                );
              }
              // if (state is ChannelsLoading || state is ChannelsInitial)
              return const Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(RouteNames.userProfile)
                .then((_) => context.read<UserPhotoCubit>().reset()), // Reset state to show (mocked) uploaded photo
            child: const Text(
              'My profile',
              style: TextStyle(fontSize: 32),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
