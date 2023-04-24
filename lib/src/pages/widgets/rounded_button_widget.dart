import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget{
  final Function()? onPressed;
  final String label;

  const RoundedButton({super.key, this.onPressed, required this.label});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.indigoAccent,
      disabledColor: Colors.grey,
      textColor: Colors.white,
      minWidth: MediaQuery.of(context).size.width,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          const SizedBox(width: 10,),
          const Icon(Icons.arrow_right_alt)
        ],
      ),
    );
  }

}