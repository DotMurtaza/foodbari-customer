import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/order/model/place_oder_model.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/rider_data_controller.dart';
import 'package:foodbari_deliver_app/utils/constants.dart';
import 'package:foodbari_deliver_app/widgets/rounded_app_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Place Order Detail', isLeading: true),
      body: Column(
        children: [
          GetX<RiderDataController>(
            init: Get.put<RiderDataController>(RiderDataController()),
            builder: (RiderDataController controller) {
              if (controller != null && controller.placeOrder != null) {
                print(
                    'Length of place order is: ${controller.placeOrder!.length}');
                return ListView.builder(
                    itemCount: controller.placeOrder!.length,
                    itemBuilder: (context, index) {
                      PlaceOrderModel placeOrderData =
                          controller.placeOrder![index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(12),
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: borderColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        placeOrderData.product_name!
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            height: 1, color: paragraphColor),
                                      ),
                                      Text(
                                        placeOrderData.product_price.toString(),
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            height: 1,
                                            color: redColor),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage(
                                              "assets/images/profile.jpg")),

                                      SizedBox(height: 1),
                                      // Text(
                                      //   orderStatus.time.toString(),
                                      //   style:
                                      //   GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
                                      // )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Text(controller.placeOrder![0].product_id!);
              }
            },
          )
        ],
      ),
    );
  }
}
