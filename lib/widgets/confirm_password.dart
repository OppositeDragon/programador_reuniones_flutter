import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/user_controller.dart';

class ConfirmPasswordWidget extends StatefulWidget {
   const ConfirmPasswordWidget({super. key});

  @override
  State<ConfirmPasswordWidget> createState() => _ConfirmPasswordWidgetState();
}

class _ConfirmPasswordWidgetState extends State<ConfirmPasswordWidget> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
      child: Column(
        children: [
          Consumer(builder: (context, ref, child) =>TextField(
						key: const ValueKey('password'),
						decoration: const InputDecoration(labelText: 'Clave', border: OutlineInputBorder()),
						obscureText: !_showPassword,
						onChanged: (value) {
						ref.read(userProvider).setPassword(value.trim()) ;
						},
					),),
					 
				
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: _showPassword,
                onChanged: (bool? value) {
                  setState(() {
                    _showPassword = value!;
                  });
                },
              ),
              const Text('Mostrar clave'),
            ],
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Aceptar'))
        ],
      ),
    );
  }
}
