import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';
import 'package:programador_reuniones_flutter/widgets/grupos_personal_widget.dart';
import 'package:programador_reuniones_flutter/widgets/horas_trabajo_widget.dart';

import '../widgets/horario_personal_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  PageController? controller;
  int paginaSeleccionada = 0;

  void onTapped(int index) {
    setState(() {
      paginaSeleccionada = index;
    });
    controller?.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: PageView(
        controller: controller,
        children: const [
          HorarioPersonalWidget(),
          HorasTrabajoWidget(),
          GruposPersonal(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.tab_unselected_sharp),
            label: "Mis horarios",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: "Horas de trabajo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Mis grupos",
          ),
        ],
        currentIndex: paginaSeleccionada,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedIconTheme:
            IconThemeData(color: Theme.of(context).secondaryHeaderColor),
        onTap: onTapped,
      ),
    );
  }
}
