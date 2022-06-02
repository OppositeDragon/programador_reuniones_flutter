import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';
import 'package:programador_reuniones_flutter/widgets/grupos_personal_widget.dart';
import 'package:programador_reuniones_flutter/widgets/horas_trabajo_widget.dart';

import '../widgets/horario_personal_widget.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with SingleTickerProviderStateMixin {
  PageController? controller;
  int paginaSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarWidget('Dashboard'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return PageView(
              controller: controller,
              onPageChanged: (page) {
                setState(() {
                  paginaSeleccionada = page;
                });
              },
              children: const [
                HorarioPersonalWidget(),
                HorasTrabajoWidget(),
                GruposPersonal(),
              ],
            );
          }
          if (constraints.maxWidth < 1100) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Flexible(flex: 6, child: Card(child: HorarioPersonalWidget())),
                  Flexible(
                    flex: 4,
                    child: Column(
                      children: const [
                        Expanded(child: Card(child: HorasTrabajoWidget())),
                        Expanded(child: Card(child: GruposPersonal())),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Flexible(flex: 6, fit: FlexFit.tight, child: Card(child: HorarioPersonalWidget())),
                  Flexible(flex: 4, fit: FlexFit.tight, child: Card(child: HorasTrabajoWidget())),
                  Flexible(flex: 4, fit: FlexFit.tight, child: Card(child: GruposPersonal()))
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: size.width >= 600
          ? null
          : BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.tab_unselected_sharp),
                  label: "Mi horario",
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
              unselectedIconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
              onTap: _goToPage,
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  void _goToPage(int index) {
    controller?.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      paginaSeleccionada = index;
    });
  }
}
