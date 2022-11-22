import 'package:flutter/material.dart';
import '../controllers/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function drawer;
  const CustomAppBar(this.drawer, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.11,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: AppColors.appBarFillColor,
        ),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.055,
          bottom: MediaQuery.of(context).size.height * 0.015,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Row(
          children: [
            Builder(builder: ((context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: (() => drawer()),
                  icon: Icon(
                    Icons.menu_rounded,
                    color: themeController.isDarkMode.value
                        ? AppColors.iconColor1Dark
                        : AppColors.iconColor1Light,
                  ),
                ),
              );
            })),
            Expanded(
              child: Text(
                'Personal Expenses',
                style: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark
                      : AppColors.titleTextColorLight,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
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
                          color: AppColors.iconColor1Dark,
                        )
                      : Icon(
                          CupertinoIcons.moon_stars_fill,
                          key: const ValueKey('icon2'),
                          color: AppColors.iconColor1Light,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
