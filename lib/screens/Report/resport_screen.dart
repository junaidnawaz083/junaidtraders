import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/services/printing.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../../controllers/customer_controller.dart';
import '../../models/customer_model.dart';
import '../../utils/constants.dart';

class RepostScreen extends StatefulWidget {
  const RepostScreen({super.key});

  @override
  State<RepostScreen> createState() => _RepostScreenState();
}

class _RepostScreenState extends State<RepostScreen> {
  final _con = Get.put(CustomerController());

  final ScrollController _controller = ScrollController();
  String? selectedRoute;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
      title: 'Daily Report',
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (_con.customers.isNotEmpty) {
            await PrintingService.instance.printReportSheet(_con.customers);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              child: getLable(text: 'Print Report', color: Colors.black)),
        ),
      ),
      leadingWidgets: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: context.width * 0.1,
              child: getLable(text: 'Route: '),
            ),
            dropDownField(
              width: context.width * 0.2,
              value: selectedRoute,
              data: routes,
              onChange: (val) async {
                if (val == null) {
                  return;
                }
                selectedRoute = val;
                _con.getCustomerByRoute(selectedRoute!);
              },
            ),
            SizedBox(
              width: context.width * 0.02,
            )
          ],
        ),
      ],
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: GetBuilder<CustomerController>(builder: (con) {
          if (con.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (con.customers.isEmpty) {
            return Center(
              child: getLable(
                text: selectedRoute == null
                    ? 'Please Select Route'
                    : 'No Report found!',
                fontSize: 40,
              ),
            );
          }
          return Column(
            children: [
              Container(
                color: primary,
                padding: EdgeInsets.symmetric(
                    vertical: 20, horizontal: context.width * 0.025),
                child: Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.1,
                      child: getLable(
                        text: 'Code',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.2,
                      child: getLable(
                        text: 'Name',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    SizedBox(
                      width: context.width * 0.1,
                      child: getLable(
                        text: 'Number',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    SizedBox(
                      width: context.width * 0.3,
                      child: getLable(
                        text: 'Address',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    SizedBox(
                      width: context.width * 0.1,
                      child: getLable(
                        text: 'Amount',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Scrollbar(
                  controller: _controller,
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: con.customers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, ind) {
                      return getCustomerTile(con.customers[ind], ind);
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget getCustomerTile(Customer model, int index) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: context.width * 0.025, vertical: 5),
      color: index % 2 == 0 ? Colors.black : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: context.width * 0.1,
                child: getLable(
                  text: model.code ?? '',
                  fontSize: 18,
                  color: index % 2 != 0 ? Colors.white : Colors.white70,
                ),
              ),
              SizedBox(
                width: context.width * 0.2,
                child: getLable(
                  text: model.name ?? '',
                  fontSize: 18,
                  color: index % 2 != 0 ? Colors.white : Colors.white70,
                ),
              ),
              SizedBox(
                width: context.width * 0.02,
              ),
              SizedBox(
                width: context.width * 0.1,
                child: getLable(
                  text: model.phone ?? '',
                  fontSize: 18,
                  color: index % 2 != 0 ? Colors.white : Colors.white70,
                ),
              ),
              SizedBox(
                width: context.width * 0.02,
              ),
              SizedBox(
                width: context.width * 0.3,
                child: getLable(
                  text: model.address ?? '',
                  fontSize: 18,
                  color: index % 2 != 0 ? Colors.white : Colors.white70,
                ),
              ),
              SizedBox(
                width: context.width * 0.02,
              ),
              SizedBox(
                width: context.width * 0.1,
                child: getLable(
                  text: (model.credit ?? 0).toStringAsFixed(0),
                  fontSize: 18,
                  color: index % 2 != 0 ? Colors.white : Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
