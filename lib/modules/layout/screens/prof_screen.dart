import 'package:evently/cor/provider/app_provider.dart';
import 'package:evently/cor/routes/app_route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../cor/routes/app_route.dart';

class ProfScreen extends StatelessWidget {
  const ProfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Center(
              child: Image(image: AssetImage("assets/image/route_11.png")),
            ),
            Text(user?.displayName ?? "User"),
            Text(user?.email ?? ""),
            SizedBox(height: 32.h),
            ListTile(
              title: Text("Dark mode", style: theme.textTheme.bodyMedium),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey),
              ),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: appProvider.isDark,
                  onChanged: (value) {
                    if (value) {
                      appProvider.ChangeTheme(ThemeMode.dark);
                    } else {
                      appProvider.ChangeTheme(ThemeMode.light);
                    }
                  },
                  activeThumbColor: theme.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              appProvider.ChangeLang("ar");
                            },
                            title: Text("Arb", style: theme.textTheme.bodyMedium),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            selectedTileColor: Colors.white,
                            selected: appProvider.langCode=="ar",
                           ),
                          SizedBox(height: 16.h,),

                          ListTile(
                            onTap: () {
                              appProvider.ChangeLang("en");
                            },

                            title: Text(" Eng", style: theme.textTheme.bodyMedium),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            selectedTileColor: Colors.white,
                            selected: appProvider.langCode=="en",
                           ),


                        ],

                      )),
                    );
                  },
                );
              },
              title: Text("Language", style: theme.textTheme.bodyMedium),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: theme.primaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(
                  context,
                  AppRouteName.loginScreen,
                );
              },
              title: Text("Logout", style: theme.textTheme.bodyMedium),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey),
              ),
              trailing: Icon(Icons.logout, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
