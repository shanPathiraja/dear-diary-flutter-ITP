import 'package:dear_diary/src/bloc/auth/auth_bloc.dart';
import 'package:dear_diary/src/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_event.dart';
import 'notification_button_widget.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final String text;

  const CustomAppBar({
    super.key,
    required this.text,
  });

  @override
  State<StatefulWidget> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.text),
      actions: [
        const NotificationButton(notificationCount: 10),
        PopupMenuButton(
            icon: const Icon(Icons.person_2_rounded),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: Row(
                  children: [
                    const Icon(
                      Icons.person_2_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      if (state is AuthAuthenticated) {
                        return Text((state.user.email) as String);
                      }
                      return const Text('Loading...');
                    }),
                  ],
                )),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LogOutRequested());
                    },
                    child: const Text('Logout'),
                  ),
                ),
              ];
            })
      ],
    );
  }
}
