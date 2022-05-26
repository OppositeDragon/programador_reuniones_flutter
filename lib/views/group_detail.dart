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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: const Color.fromARGB(255, 185, 194, 215),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: const Image(
                                  image: NetworkImage(
                                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                                  height: 70,
                                ),
                              ),
                            ),
                            const Text("DAS - GRUPO1 GROUPMEET"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: const Color.fromARGB(255, 185, 194, 215),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    const Card(
                      color: Color.fromARGB(255, 200, 198, 198),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("integrantes"),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: const <Widget>[
                              Text("Jean Jativa"),
                              Text("Lenin Acosta")
                            ],
                          ),
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
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              child: Text("aqui va el horario calculado"),
            ),
          )
        ]));
  }
}
