import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../../../controllers/theme_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  // ignore: prefer_const_constructors_in_immutables
  CustomAppBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.put(ThemeController());
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: (() {
            Scaffold.of(context).openDrawer();
          }),
          icon: const Icon(Icons.menu_rounded),
        );
      }),
      title: Obx(
        (() => Text(
              title,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
            )),
      ),
      actions: [
        Obx((() => IconButton(
              onPressed: (() {
                themeController.isDarkMode.value =
                    !themeController.isDarkMode.value;
                themeController.changeTheme();
              }),
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, anim) => RotationTransition(
                  turns: child.key == const ValueKey('icon1')
                      ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                      : Tween<double>(begin: 0.75, end: 1).animate(anim),
                  child: ScaleTransition(scale: anim, child: child),
                ),
                child: themeController.isDarkMode.value
                    ? Icon(
                        Icons.sunny,
                        key: const ValueKey('icon1'),
                        color: AppColors.appBarIconColorDark,
                      )
                    : Icon(
                        CupertinoIcons.moon_stars_fill,
                        key: const ValueKey('icon2'),
                        color: AppColors.appBarIconColorLight,
                      ),
              ),
            ))),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
