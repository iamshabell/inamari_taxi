import 'package:flutter/material.dart';

class ProgreeDialog extends StatelessWidget {
  String message;
  ProgreeDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blue,
      child: Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              const SizedBox(
                width: 26,
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.black, fontSize: 10.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
