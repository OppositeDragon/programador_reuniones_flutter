import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int paginaSeleccionada = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: paginaSeleccionada,
    );
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
      body: Column(
        children: [
          TabBar(
            controller: controller,
            tabs: const [
              Tab(
                child: Text("Mi horario"),
              ),
              Tab(
                child: Text("Mi horario"),
              ),
              Tab(
                child: Text("Mi horario"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
