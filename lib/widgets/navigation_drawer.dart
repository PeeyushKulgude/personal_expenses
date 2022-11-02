import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/pie_chart.dart';
import 'my_home_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  Widget buildHeader(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top));

  Widget buildMenuItems(BuildContext context) => Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
        child: Wrap(
          runSpacing: MediaQuery.of(context).size.height / 50,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              onTap: (() => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => MyHomePage())))),
            ),
            ListTile(
              leading: const Icon(
                Icons.pie_chart_sharp,
                color: Colors.white,
              ),
              title: const Text(
                'Pie Chart',
                style: TextStyle(color: Colors.white),
              ),
              onTap: (() {
                Navigator.pop(context);

                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => PieChartDisplay())));
              }),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }
}
