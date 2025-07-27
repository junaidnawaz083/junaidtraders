import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/databaseController.dart';
import 'package:junaidtraders/screens/main_screen/main_screen.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../../utils/constants.dart';

CitySole? selectedArea;

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  selectedArea = null;
                  Get.back();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: primary,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Center(
                        child: getLable(
                            text: '     Back   ', color: Colors.black))),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        ),
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
                      selectedArea = CitySole.city;
                      Get.to(const MainScreen());
                    },
                    text: 'City',
                    fontSize: 30),
                // getBigButton(
                //     width: context.width * 0.2,
                //     height: context.width * 0.1,
                //     onPress: () async {
                //       await DBC.instance.initDatabse('CityTest21');
                //       selectedArea = CitySole.city;
                //       Get.to(const MainScreen());
                //     },
                //     text: 'City 2',
                //     fontSize: 30),
                getBigButton(
                  width: context.width * 0.2,
                  height: context.width * 0.1,
                  onPress: () async {
                    await DBC.instance.initDatabse('SoleTest1');
                    selectedArea = CitySole.sole;

                    Get.to(() => const MainScreen());
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

enum CitySole { city, city1, sole }
