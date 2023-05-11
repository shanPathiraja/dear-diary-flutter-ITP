import 'package:dear_diary/src/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                      if (state is Authenticated) {
                        return Text(
                          state.user.email ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        );
                      }
                      return const Text(
                        'Unknown',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    })
                  ],
                )),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
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
