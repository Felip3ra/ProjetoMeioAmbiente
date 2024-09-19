import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String texto,
    bool isErro = true}) {
  SnackBar snackbar = SnackBar(
    content: Text(texto),
    backgroundColor: (isErro)? Colors.red:Colors.green,
    
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
