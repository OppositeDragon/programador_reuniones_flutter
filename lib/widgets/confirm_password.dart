import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/constants/strings.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';
import 'package:programador_reuniones_flutter/controllers/user_controller.dart';

class ConfirmPasswordWidget extends ConsumerWidget {
  const ConfirmPasswordWidget({super.key});
 
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    bool showPassword = ref.watch(loginProvider).showPassword;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) => TextField(
              key: const ValueKey('password'),
              decoration: const InputDecoration(labelText: Strings.labelClave, border: OutlineInputBorder()),
              obscureText: !showPassword,
              onChanged: (value) => ref.read(userProvider).password = value.trim(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: showPassword,
                onChanged: (bool? value) => ref.read(loginProvider).showPassword = value!,
              ),
              const Text(Strings.labelMostrarClave),
            ],
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text(Strings.labelAceptar))
        ],
      ),
    );
  }
}
