import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/initial_page/auth_bloc/auth_bloc.dart';
import '../view/initial_page/auth_bloc/auth_event.dart';
import '../view/initial_page/auth_bloc/auth_state.dart';
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
  late AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
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
                      final user = state.user;
                      if (user != null) {
                        return Text((user.email!));
                      }
                      return const Text('Loading...');
                    }),
                      ],
                    )),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      _authBloc.add(LogOutRequested());
                    },
                    child: const Text('Logout',
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
              ];
            })
      ],
    );
  }
}
