import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  const Principal({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
			appBar: AppBar(actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.settings))]),
      body:const Center(
        child: Text('Programador de reuniones'),
      ),
    );
  }
}
