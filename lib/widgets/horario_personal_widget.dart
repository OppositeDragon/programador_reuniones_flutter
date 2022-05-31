import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HorarioPersonalWidget extends ConsumerStatefulWidget {
  const HorarioPersonalWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HorarioPersonalWidgetState();
}

class _HorarioPersonalWidgetState extends ConsumerState<HorarioPersonalWidget> {
  final List<String> dias = ["L", "M", "X", "J", "V", "S", "D"];
  final List<String> horas = [
    "7-8",
    "8-9",
    "9-10",
    "11-12",
    "12-13",
    "13-14",
    "14-15",
    "15-16",
    "16-17",
    "17-18",
    "18-19",
    "19-20"
  ];
  final List<Map<String, bool>> data =
      List.generate(84, (index) => {UniqueKey().toString(): false});

  List<Widget> generarHorario() {
    return <Widget>[
      for (int i = 0; i < dias.length + 1; i++)
        (i == 0)
            ? Container(
                padding: const EdgeInsets.all(8),
                color: Colors.amber[100],
                height: 20,
              )
            : Container(
                padding: const EdgeInsets.all(8),
                color: Colors.amber[100],
                height: 20,
                child: Text(dias.elementAt(i - 1),
                    textDirection: TextDirection.rtl),
              ),
      for (int i = 0; i < horas.length; i++)
        for (int j = 0; j < dias.length + 1; j++)
          (j == 0)
              ? Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.amber[100],
                  height: 20,
                  child: Text(horas.elementAt(i)),
                )
              : Container(
                  //key: data[j].[],
                  padding: const EdgeInsets.all(8),
                  color: Colors.blue[200],
                  height: 20,
                  child: GestureDetector(
                    onTap: changeColor,
                  ),
                ),
    ];
  }

  void changeColor() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 8,
      children: generarHorario(),
    );
  }
}
