import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/constants/strings.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';
import 'package:programador_reuniones_flutter/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/theme_controller.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: const [PopUpMenu()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PopUpMenu extends ConsumerWidget {
  const PopUpMenu({super.key});

  //bool isDark = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = ref.watch(themeProvider).isDark;

    return PopupMenuButton(
      // Callback that sets the selected popup menu item.

      itemBuilder: (BuildContext context) {
        return [
          if (router.location != '/perfil')
            PopupMenuItem(
              child: ListTile(
                title: const Text(Strings.buttonPerfil),
                trailing: const Icon(Icons.account_circle),
                onTap: () {
                  context.pushNamed('perfil');
                },
              ),
            ),
          PopupMenuItem(
              child: ListTile(
            title: const Text(Strings.buttonTema),
            trailing: const Icon(Icons.brightness_4_sharp),
            onTap: () {
              //isDark = !isDark;
              ref.read(themeProvider).setTheme(isDark);
            },
          )),
          PopupMenuItem(
            child: ListTile(
              title: const Text(Strings.buttonCerrarSesion),
              trailing: const Icon(Icons.logout),
              onTap: () => ref.read(loginProvider).logout(),
            ),
          ),
        ];
      },
    );
  }
}
