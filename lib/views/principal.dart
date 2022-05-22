import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/views/login_view.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            //TExto programador de reuniones
            Text('Programador de reuniones'),
            ElevatedButton(
                onPressed: () {
                  //Navigator.of(context).push(LoginView());
                },
                child: Text("login pro max 21"))
          ],
        ),
      ),
    );
  }
}
