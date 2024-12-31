import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:junaidtraders/screens/city_sole/selection_screeen.dart';
import 'package:junaidtraders/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getLable(
                  text: 'Abbasi Traders',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 175, 142, 129),
                ),
                getLable(text: 'Murree Brawery')
              ],
            ),
            SizedBox(
              height: context.height * 0.3,
              child: VerticalDivider(
                thickness: 2,
                width: context.height * 0.3,
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.15,
                      child: getLable(text: 'Username: '),
                    ),
                    getTextFormField(
                      controller: TextEditingController(),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.15,
                      child: getLable(text: 'Password: '),
                    ),
                    getTextFormField(
                      obscureText: true,
                      controller: TextEditingController(),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: context.width * 0.35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: context.width * 0.09,
                        child: getButton(
                            onPress: () async {
                              await login();
                            },
                            text: 'Login'),
                      ),
                      SizedBox(
                        width: context.width * 0.02,
                      ),
                      SizedBox(
                        width: context.width * 0.09,
                        child: getButton(
                            onPress: () {
                              exit(0);
                            },
                            text: 'Exit'),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ],
    ));
  }

  Future<void> login() async {
    Get.to(SelectionScreen());
  }
}
