import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/controllers/customer_controller.dart';
import 'package:junaidtraders/models/customer_model.dart';
import 'package:junaidtraders/screens/Customer/add_customer.dart';
import 'package:junaidtraders/utils/utils.dart';

import '../../utils/constants.dart';

class CustomerSreen extends StatefulWidget {
  const CustomerSreen({super.key});

  @override
  State<CustomerSreen> createState() => _CustomerSreenState();
}

class _CustomerSreenState extends State<CustomerSreen> {
  final _con = Get.put(CustomerController());
  @override
  void initState() {
    // TODO: implement initState
    _con.fetchCustomersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(AddOrUpdateCustomer(
                con: _con,
              ));
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
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  getLable(text: 'Add Customer', color: Colors.black)
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 40,
          )
        ],
      ),
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
                text: 'No customer found!',
                fontSize: 40,
              ),
            );
          }
          return Column(
            children: [
              Container(
                color: primary,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.1,
                      child: Center(
                        child: getLable(
                          text: 'Code',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.2,
                      child: Center(
                        child: getLable(
                          text: 'Name',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.1,
                      child: Center(
                        child: getLable(
                          text: 'Number',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.3,
                      child: Center(
                        child: getLable(
                          text: 'Address',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.1,
                      child: Center(
                        child: getLable(
                          text: 'Amount',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: con.customers.length,
                shrinkWrap: true,
                itemBuilder: (context, ind) {
                  return getCustomerTile(con.customers[ind], ind);
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget getCustomerTile(Customer model, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: index % 2 == 0 ? Colors.black : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: context.width * 0.1,
            child: Center(
              child: getLable(
                text: model.code ?? '',
                fontSize: 18,
                color: index % 2 != 0 ? Colors.white : Colors.white70,
              ),
            ),
          ),
          SizedBox(
            width: context.width * 0.2,
            child: Center(
              child: getLable(
                text: model.name ?? '',
                fontSize: 18,
                color: index % 2 != 0 ? Colors.white : Colors.white70,
              ),
            ),
          ),
          SizedBox(
            width: context.width * 0.1,
            child: Center(
              child: getLable(
                text: model.phone ?? '',
                fontSize: 18,
                color: index % 2 != 0 ? Colors.white : Colors.white70,
              ),
            ),
          ),
          SizedBox(
            width: context.width * 0.3,
            child: Center(
              child: getLable(
                text: model.address ?? '',
                fontSize: 18,
                color: index % 2 != 0 ? Colors.white : Colors.white70,
              ),
            ),
          ),
          SizedBox(
            width: context.width * 0.1,
            child: Center(
              child: getLable(
                text: '${model.credit ?? '0'}',
                fontSize: 18,
                color: index % 2 != 0 ? Colors.white : Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
