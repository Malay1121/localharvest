import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:local_harvest/app/helper/all_imports.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
        init: OrdersController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('OrdersView'),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    for (Map product in controller.orders)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.h(context),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w(context),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    product["productDetails"]["image"],
                                    width: 42.w(context),
                                    height: 42.h(context),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w(context),
                                ),
                                Column(
                                  children: [
                                    AppText(
                                      text: product["productDetails"]["title"],
                                      style: Styles.bold(
                                        color: AppColors.fontDark,
                                        fontSize: 16.t(context),
                                      ),
                                      width: 155.w(context),
                                    ),
                                    SizedBox(
                                      height: 4.h(context),
                                    ),
                                    AppText(
                                      text:
                                          "${product["productDetails"]["quantity"]}kg, ${product["productDetails"]["price"]}\$",
                                      style: Styles.bold(
                                        color: AppColors.secondary,
                                        fontSize: 16.t(context),
                                      ),
                                      width: 155.w(context),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                AppText(
                                  text:
                                      "Qty: " + product["quantity"].toString(),
                                  style: Styles.bold(
                                    color: AppColors.fontDark,
                                    fontSize: 18.t(context),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w(context),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 24.w(context),
                              top: 5.h(context),
                            ),
                            child: AppText(
                                text: "Customer's name: " +
                                    (product["consumerDetails"]["fName"] ??
                                        "") +
                                    " " +
                                    (product["consumerDetails"]["lName"] ??
                                        "")),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 24.w(context),
                              top: 5.h(context),
                            ),
                            child: AppText(
                                text: "Customer's phone: " +
                                    (product["consumerDetails"]["phone"] ??
                                        "")),
                          ),
                          SizedBox(
                            height: 16.h(context),
                          ),
                          Container(
                            width: 390.w(context),
                            height: 1,
                            color: AppColors.stroke,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
