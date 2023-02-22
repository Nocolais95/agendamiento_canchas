

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/providers/stepper_provider.dart';

showData(BuildContext context, String id) {
  final stepperProvider = context.read<StepperProvider>();
  return showDialog(
    barrierColor: Colors.black.withOpacity(.7),
      context: context,
      barrierDismissible: true, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        content: const SizedBox(
          height: 40,
          child: Text('Seguro quieres eliminar este turno?')
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, 
            child: const Text('Cancelar')),
          TextButton(
            onPressed: (){
              stepperProvider.setDeleteTurno(id);
              Navigator.of(context).pop();
            }, 
            child: const Text('Eliminar')),
        ],
      );
    });
}