import 'package:findcribs/components/constants.dart';
import 'package:findcribs/controller/payment_controller.dart';
import 'package:findcribs/screens/listing_process/listing/components/rent/rent4_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

Padding paymentPlan(
    {required int id,
    required bool selected,
    required String name,
    required String price,
    required List benefits,
    required String subscriptionId,
    required StatefulWidget returnUrl}) {
  var formatter = NumberFormat("#,###");
  PaymentController paymentController = Get.put(PaymentController());
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Row(
      children: [
        Container(
          width: 180,
          height: 370,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selected ? kPrimary : null,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: selected ? Colors.white : null,
                    ),
                  ),
                  Text(
                    "monthly",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: selected ? Colors.white : secondaryColor,
                    ),
                  ),
                  Text(
                    "N${formatter.format(int.parse(price))}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white : null,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      for (int x = 0; x < benefits.length; x++)
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: selected ? Colors.white : kPrimary,
                              size: 14,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 130,
                              child: Text(
                                benefits[x],
                                style: TextStyle(
                                  fontSize: 10,
                                  color:
                                      selected ? Colors.white : secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              int.parse(subscriptionId) > id
                  ? SizedBox.shrink()
                  : Obx(() {
                      var isclicked = paymentController.isClicked.value;
                      return Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? Colors.white : null,
                          border: Border.all(
                            color: kPrimary,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          selected ? "Current Plan" : "Upgrade Plan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selected ? kPrimary : null,
                          ),
                        ),
                      ).onTap(() {
                        if (isclicked || selected) {
                          return;
                        } else {
                          paymentController.handlePay(id, returnUrl);
                        }
                      });
                    }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
