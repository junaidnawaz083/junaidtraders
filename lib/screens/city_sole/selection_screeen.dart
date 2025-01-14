import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/databaseController.dart';
import 'package:junaidtraders/screens/main_screen/main_screen.dart';
import 'package:junaidtraders/utils/utils.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: getLable(
            text: 'Select your Area',
            fontSize: 40,
          ),
        ),
        SizedBox(
          height: context.height * 0.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getBigButton(
                width: context.width * 0.2,
                height: context.width * 0.1,
                onPress: () async {
                  await DBC.instance.initDatabse('CityTest1');
                  Get.to(MainScreen());
                },
                text: 'City',
                fontSize: 30),
            getBigButton(
              width: context.width * 0.2,
              height: context.width * 0.1,
              onPress: () async {
                await DBC.instance.initDatabse('SoleTest1');
                Get.to(MainScreen());
              },
              text: 'Sole',
              fontSize: 30,
            ),
          ],
        )
      ],
    ));
  }
}
