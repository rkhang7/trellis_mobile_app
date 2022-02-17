import 'package:flutter/material.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class AuthButton extends StatelessWidget {
  Widget widget;
  Function() onClick;
  AuthButton({
    Key? key,
    required this.widget,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 8,
      color: backgroundColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: onClick,
        child: widget,
      ),
    );
  }
}
