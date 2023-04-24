import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget{
  const NotificationButton({super.key, required this.notificationCount});
  final int notificationCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 30,
        height: double.infinity,
        child: Align(
          alignment: Alignment.centerRight,
          child: Stack(
            children: [
              const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30,
              ),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xffc32c37),
                      border: Border.all(color: Colors.white, width: 1)),
                  child:  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(
                        notificationCount.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

}