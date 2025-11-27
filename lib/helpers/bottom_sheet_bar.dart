import 'package:flutter/material.dart';

Future<bool?> showBottomChoiceSheet(
  BuildContext context,
  String msg,
  Color yesColor,
  Color noColor,
) {
  return showModalBottomSheet<bool>(
    context: context,
    barrierColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 56, 110, 238),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${msg}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("Yes", style: TextStyle(color: yesColor)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No", style: TextStyle(color: noColor)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showBlockingSheet(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Color.fromARGB(255, 56, 110, 238),
    builder: (ctx) {
      return SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Please wait...",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 30),
                CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      );
    },
  );

  await Future.delayed(const Duration(seconds: 1), () {
    Navigator.of(context).pop();
  });
}

void showSnackBar(
  BuildContext context,
  String message, {
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        duration: Duration(seconds: 2),
      ),
    );
}
