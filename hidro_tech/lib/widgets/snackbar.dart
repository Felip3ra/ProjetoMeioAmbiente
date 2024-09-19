import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String texto,
    bool isErro = true}) {
  SnackBar snackbar = SnackBar(
    content: Text(texto),
    backgroundColor: (isErro)? Colors.red:Colors.green,
    duration: Duration(seconds: 4),
    action: SnackBarAction(label: "OK", textColor: Colors.white ,onPressed: (){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
