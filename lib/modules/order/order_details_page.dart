import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/order/model/my_product_model.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/add_to_cart_controller.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/product_controller.dart';
import 'package:foodbari_deliver_app/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../router_name.dart';
import '../../utils/constants.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/cart_item_header.dart';
import 'component/cart_product_list.dart';
import 'component/panel_widget.dart';
import 'model/product_model.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({
    Key? key,
    // required this.productList,
  }) : super(key: key);
  // final List<ProductModel> productList;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final panelController = PanelController();
  final double height = 145;
  final headerStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  @override
  void initState() {
    Get.put(AddToCartController());
    super.initState();
  }

  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      appBar: RoundedAppBar(
        isLeading: false,
        titleText: 'Order Details',
        actionButtons: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.orderTrackingScreen);
            },
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.delivery_dining_outlined,
                size: 20,
                color: blackColor,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SlidingUpPanel(
        controller: panelController,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        // panel: const PanelComponent(),
        panelBuilder: (sc) => PanelComponent(
          controller: sc,
        ),
        minHeight: height,
        maxHeight: 350,
        backdropEnabled: true,
        backdropTapClosesPanel: true,
        parallaxEnabled: false,
        backdropOpacity: 0.0,
        collapsed: PannelCollapsComponent(height: height),
        body: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: GetX<AddToCartController>(
                  init: Get.put<AddToCartController>(AddToCartController()),
                  builder: (AddToCartController controller) {
                    if (controller.product == null) {
                      return const Center(child: Text('Cart is empty'));
                    } else {
                      return ListView.builder(
                        itemCount: controller.product!.length,
                        itemBuilder: (context, index) {
                          //   productModelData = controller.product![index];

                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 8,
                              bottom: 8,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            right:
                                                BorderSide(color: borderColor)),
                                      ),
                                      height: height - 2,
                                      width: width / 2.7,
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                left: Radius.circular(4)),
                                        child: Image.network(controller
                                            .product![index].productImage!),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .product![index].productName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          controller
                                              .product![index].productPrice!
                                              .toString(),
                                          style: const TextStyle(
                                              color: redColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        productController.removeFromCart(
                                          controller.product![index].productId!,
                                          controller.product![index],
                                        );
                                      },
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        // body: _buildBody(),
      ),
    );
  }

  // Widget _buildBody() {
  //   final bottstats = MediaQuery.of(context).padding.bottom;
  //   return CustomScrollView(
  //     slivers: [
  //       const SliverToBoxAdapter(child: CartPageHeader(length: 4)),
  //       // SliverPadding(
  //       //   padding: const EdgeInsets.symmetric(horizontal: 20),
  //       //   sliver: CartProductList(
  //       //       populerProductList: widget.productList.take(2).toList()),
  //       // ),
  //       // Container(
  //       //   margin: const EdgeInsets.symmetric(vertical: 10),
  //       //   decoration: BoxDecoration(
  //       //     borderRadius: BorderRadius.circular(4),
  //       //     border: Border.all(color: borderColor),
  //       //     color: Colors.white,
  //       //   ),
  //       //   child: Row(
  //       //     children: [
  //       //       Expanded(
  //       //         child: ListView.builder(
  //       //           itemCount: 5,
  //       //           itemBuilder: (context, index) {
  //       //             return Padding(
  //       //               padding: const EdgeInsets.all(8.0),
  //       //               child: Row(
  //       //                 children: [
  //       //                   Container(
  //       //                     decoration: const BoxDecoration(
  //       //                       border:
  //       //                           Border(right: BorderSide(color: borderColor)),
  //       //                     ),
  //       //                     height: height - 2,
  //       //                     width: width / 2.7,
  //       //                     child: ClipRRect(
  //       //                       borderRadius: const BorderRadius.horizontal(
  //       //                           left: Radius.circular(4)),
  //       //                       child: Image.network('https://picsum.photos/320'),
  //       //                     ),
  //       //                   ),
  //       //                   const SizedBox(width: 12),
  //       //                   Column(
  //       //                     crossAxisAlignment: CrossAxisAlignment.start,
  //       //                     children: const [
  //       //                       Text(
  //       //                         'title',
  //       //                         maxLines: 1,
  //       //                         overflow: TextOverflow.ellipsis,
  //       //                         style: TextStyle(
  //       //                             fontSize: 14, fontWeight: FontWeight.w600),
  //       //                       ),
  //       //                       Text(
  //       //                         'price',
  //       //                         style: TextStyle(
  //       //                             color: redColor,
  //       //                             fontSize: 16,
  //       //                             fontWeight: FontWeight.w600),
  //       //                       ),
  //       //                     ],
  //       //                   ),
  //       //                   const SizedBox(height: 4),
  //       //                 ],
  //       //               ),
  //       //             );
  //       //           },
  //       //         ),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }
}
