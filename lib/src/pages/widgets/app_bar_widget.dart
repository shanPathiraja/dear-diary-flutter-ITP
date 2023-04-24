import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
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
  User? _user;
  late final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();

    _authService.getCurrentUser().then((value) => {
          setState(() {
            _user = value;
          })
        });
  }

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
                    Text(
                      _user?.email ?? "",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                )),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      _authService.signOut(context);
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
