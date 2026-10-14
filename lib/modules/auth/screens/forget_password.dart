 import 'package:evently/modules/auth/manger/auth_Provieder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../cor/widgets/custom_Buttom.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => AuthProvieder(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ForgetPassword"),
          leading: Navigator.canPop(context)? FittedBox(
            fit: BoxFit.scaleDown,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },

              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: theme.primaryColor)
                ),

                child: Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
          ) : null ,
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AuthProvieder>(
            builder: (context, Provider, child) {
              return Column(
                children: [
                  Image.asset("assets/image/resetpasssword.png"),
                  SizedBox(height: 20.h,),
                  TextFormField(
                    controller: Provider.emailController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                  ),
                  SizedBox(height: 20,),
                  CustomButtom(
                    isLoding: Provider.isLoding,
                    title: 'Reset password ', onPressed: () {
                    Provider.resetPassword();
                  },)
                ],
              );
            },

          ),
        ),
      ),
    );
  }
}
