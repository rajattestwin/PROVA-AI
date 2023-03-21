import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginAvatar extends StatefulWidget {
  bool isSelected;
  String avatarImage;
  LoginAvatar({super.key, required this.isSelected, required this.avatarImage});

  @override
  State<LoginAvatar> createState() => _LoginAvatarState();
}

class _LoginAvatarState extends State<LoginAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              widget.isSelected ? const Color(0xff7F01FC) : Colors.transparent),
      child: Center(
        child: Image.asset(
          widget.avatarImage,
          width: MediaQuery.of(context).size.height / 10,
          height: MediaQuery.of(context).size.height / 10,

          fit: BoxFit.fill,
          // color: Colors.amber,
        ),
      ),
    );
  }
}
