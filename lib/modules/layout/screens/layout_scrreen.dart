import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/modules/layout/screens/fav_screen.dart';
import 'package:evently/modules/layout/screens/prof_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus_pro/icons_plus_pro.dart';
import 'package:provider/provider.dart';

import '../manager/layout_provider.dart';
import 'Home_screen.dart';

class LayoutScrreen extends StatefulWidget {
  const LayoutScrreen({super.key});

  @override
  State<LayoutScrreen> createState() => _LayoutScrreenState();
}

class _LayoutScrreenState extends State<LayoutScrreen> {
  int SelectedIndex = 0;
  List<Widget> screen = [HomeScreen(), FavScreen(), ProfScreen()];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 6,
          backgroundColor: theme.primaryColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(360),
            borderSide: BorderSide.none,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRouteName.EventScreen);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: screen[SelectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: SelectedIndex,
          onTap: (value) {
            SelectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home_1_outline),
              activeIcon: Icon(Iconsax.home_1_bold),

              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              activeIcon: Icon(Icons.favorite_rounded),

              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),

              activeIcon: Icon(Icons.person_rounded),
              label: "profile",
            ),
          ],
        ),
      ),
    );
  }
}
