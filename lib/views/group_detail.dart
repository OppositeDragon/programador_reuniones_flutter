import 'package:flutter/material.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detalle del grupo"),
        ),
        body: Column(children: <Widget>[
          Card(
            child: Row(
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Image(
                      image: NetworkImage(
                          "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                      height: 50,
                    ),
                    Text("Grupo de estudio 1 - desarrollod asistido")
                  ],
                ),
                Row(
                  children: const <Widget>[Text("asdasd")],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            child: Column(
              children: <Widget>[
                const Card(
                  child: Center(
                    child: Text("integrantes"),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: const <Widget>[
                        Text("Jean Jativa"),
                        Text("Lenin Acosta")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: const <Widget>[
                        Text("Steven Lopez"),
                        Text("Erick Carrasco")
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Card(
            child: Text("aqui va el horario calculado"),
          ),
        ]));
  }
}
