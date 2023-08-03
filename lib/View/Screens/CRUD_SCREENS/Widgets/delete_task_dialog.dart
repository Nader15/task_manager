import 'package:flutter/material.dart';

void showDeleteConfirmationDialog(Function()? onPressed,BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text("Delete"),
          ),
        ],
      );
    },
  );
}