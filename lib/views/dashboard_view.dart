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
      body: size.width > 1000
          ? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.height - 156),
                child: Row(
                  children: const [
                    SizedBox(width: 6),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Card(
                          child: AspectRatio(aspectRatio: 0.5, child: HorarioPersonalWidget()),
                        )),
                    SizedBox(width: 12),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Card(
                          child: AspectRatio(
                        aspectRatio: 0.5,
                        child: HorasTrabajoWidget(),
                      )),
                    ),
                    SizedBox(width: 12),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Card(
                          child: AspectRatio(
                        aspectRatio: 0.5,
                        child: GruposPersonal(),
                      )),
                    ),
                    SizedBox(width: 6),
                  ],
                ),
              ),
            )
          :size.width > 600? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.height - 156),
                child: Row(
                  children:  [
                    const SizedBox(width: 6),
                    const Flexible(
                        fit: FlexFit.tight,
                        child: Card(
                          child: AspectRatio(aspectRatio: 0.1, child: HorarioPersonalWidget()),
                        )),
                    const SizedBox(width: 12),
										Column(children: const [
											Flexible(
                      fit: FlexFit.tight,
                      child: Card(
                          child: AspectRatio(
                        aspectRatio:1,
                        child: HorasTrabajoWidget(),
                      )),
                    ),
                    SizedBox(height: 12),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Card(
                          child: AspectRatio(
                        aspectRatio: 1,
                        child: GruposPersonal(),
                      )),
                    ),
										],),
                    
                    const SizedBox(width: 6),
                  ],
                ),
              ),
            ) :PageView(
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
            ),
      bottomNavigationBar: size.width > 600
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
