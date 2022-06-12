import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';

class GroupDetailView extends StatelessWidget {
  const GroupDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppBarWidget('Detalles del grupo'),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth > 900 ? constraints.maxWidth : 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation:12,
                          color: Theme.of(context).colorScheme.primaryVariant,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: const Image(
                                    image: NetworkImage("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    "D A S - G R U P O 1 G R O U P M E E T",
                                    style: textTheme.headline5,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        direction: constraints.maxWidth > 900 ? Axis.horizontal : Axis.vertical,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth > 900 ? constraints.maxWidth / 2 - 30 : constraints.maxWidth - 20,
                            height: MediaQuery.of(context).size.height - 110,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Horario grupal calculado:',
                                  style: textTheme.headline5,
                                  textAlign: TextAlign.start,
                                ),
                                Expanded(
                                  child: Card(elevation: 6,
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                    child: const SizedBox(
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth > 900 ? constraints.maxWidth / 2 - 30 : constraints.maxWidth - 20,
                            height: MediaQuery.of(context).size.height - 110,
                            child: Column(
                              children: [
                                Text(
                                  'Integrantes:',
                                  style: textTheme.headline5,
                                  textAlign: TextAlign.start,
                                ),
                                Expanded(
                                  child: Card( color: Theme.of(context).colorScheme.inversePrimary,elevation: 6,
                                    child: ListView.separated(
                                      // shrinkWrap: true,
                                      itemCount: 20,
                                      itemBuilder: (context, index) => const ListTile(
                                        title: Text('nombre'),
                                        subtitle: Text('correo@electronico.com'),
                                      ),
                                      separatorBuilder: (context, index) => const Divider(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
