import 'package:assignment/utills/constants.dart';
import 'package:flutter/material.dart';

void openSnackbar({
  required BuildContext context,
  required String snackMessage,
  String? buttonText,
  void Function()? onPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xff323238),
      action: SnackBarAction(
        label: buttonText ?? "OK",
        textColor: primaryColor,
        onPressed: onPressed ?? (){},
      ),
      content: Text(
        snackMessage,
        style: const TextStyle(fontSize: 14),
      )));
}

class Failure {
  String message;

  Failure(this.message);

  @override
  String toString() => message;
}
