import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';
import 'package:programador_reuniones_flutter/main.dart';
import 'package:programador_reuniones_flutter/theme/theme_controller.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title),
      actions: [PopUpMenu()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PopUpMenu extends ConsumerStatefulWidget {
  const PopUpMenu({
    super.key,
  });

  @override
  ConsumerState<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends ConsumerState<PopUpMenu> {
  //bool isDark = false;
  @override
  Widget build(BuildContext context) {
		bool isDark = ref.watch(themeProvider).isDark;
    return PopupMenuButton(
      // Callback that sets the selected popup menu item.

      itemBuilder: (BuildContext context) {
        return [upMenuItem(
            child: ListTile(
                title: const Text('Tema'),
                trailing: isDark? const Icon(Icons.interests) :const Icon(Icons.sunny),
                onTap: () {
                  isDark = !isDark;
                  ref.read(themeProvider).setTheme(isDark);
                }),
          ),
          PopupMenuItem(
            child: ListTile(
              title: const Text('Cerrar sesion'),
              trailing: const Icon(Icons.logout),
              onTap: () => ref.read(loginProvider).logout(),
            ),
          ),
        ];
      },
    );
  }
}
