import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/order/model/my_product_model.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/product_controller.dart';
import 'package:foodbari_deliver_app/router_name.dart';
import 'package:foodbari_deliver_app/utils/k_images.dart';
import 'package:foodbari_deliver_app/widgets/custom_image.dart';
import 'package:foodbari_deliver_app/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dummy_data/all_dymmy_data.dart';
import '../../utils/constants.dart';
import '../../widgets/toggle_button_component.dart';
import 'component/order_app_bar.dart';
import 'component/ordered_list_component.dart';
import 'model/product_order_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var authController = Get.put(CustomerController());
  ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    Get.put(ProductController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double appBarHeight = 174;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: appBarHeight,
            expandedHeight: appBarHeight,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: redColor),
            flexibleSpace: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  // SizedBox(height: widget.height, width: media.size.width),
                  const Positioned(
                    left: -21,
                    top: -74,
                    child: CircleAvatar(
                      radius: 105,
                      backgroundColor: redColor,
                    ),
                  ),
                  Positioned(
                    left: -31,
                    top: -113,
                    child: CircleAvatar(
                      radius: 105,
                      backgroundColor: Colors.white.withOpacity(0.06),
                    ),
                  ),
                  Positioned(
                    left: -33,
                    top: -156,
                    child: CircleAvatar(
                      radius: 105,
                      backgroundColor: Colors.white.withOpacity(0.06),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // SizedBox(height: 60 - statusbarPadding),
                          _buildappBarButton(context),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xff333333)
                                              .withOpacity(.18),
                                          blurRadius: 70),
                                    ],
                                  ),
                                  child: TextFormField(
                                    //  controller:authController. ,
                                    onChanged: (val) {
                                      productController.searchProduct.value =
                                          val;
                                      setState(() {});
                                      //return null;
                                    },
                                    decoration: inputDecorationTheme.copyWith(
                                      prefixIcon: const Icon(
                                          Icons.search_rounded,
                                          color: grayColor,
                                          size: 26),
                                      hintText: 'Search your products',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                    color: redColor,
                                    borderRadius: BorderRadius.circular(4)),
                                margin: const EdgeInsets.only(right: 8),
                                height: 52,
                                width: 44,
                                child: const Center(
                                  child: CustomImage(
                                    path: Kimages.menuIcon,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: GetX(
            init: Get.put<ProductController>(ProductController()),
            builder: ((ProductController controller) {
              if (controller != null && controller.product != null) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.product!.length,
                    itemBuilder: ((context, index) {
                      MyProductModel products = controller.product![index];
                      return controller.product![index].productName!
                              .toUpperCase()
                              .contains(controller.searchProduct.toUpperCase())
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: size.width * 0.95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: SizedBox(
                                        height: size.height * 0.2,
                                        width: size.width,
                                        child: Image.network(
                                          products.productImage!,
                                          fit: BoxFit.cover,
                                          height: size.height * 0.2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width,
                                            child: Text(
                                              products.productName!,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            products.productPrice.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: PrimaryButton(
                                                  minimumSize: const Size(
                                                      double.infinity, 40),
                                                  fontSize: 16,
                                                  grediantColor: const [
                                                    blackColor,
                                                    blackColor
                                                  ],
                                                  text: 'Details',
                                                  onPressed: () {},
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Flexible(
                                                child: PrimaryButton(
                                                  minimumSize: const Size(
                                                      double.infinity, 40),
                                                  fontSize: 16,
                                                  grediantColor: const [
                                                    redColor,
                                                    redColor
                                                  ],
                                                  text: 'Buy',
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox();
                    }));
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
          )),
        ],
      ),
    );
  }

  Widget _buildappBarButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLocation(),
                const Spacer(),
                FlutterSwitch(
                  width: 100.0,
                  height: 37.0,
                  valueFontSize: 18.0,
                  toggleSize: 27.0,
                  value: false,
                  borderRadius: 30.0,
                  padding: 4.0,
                  activeColor: redColor,
                  inactiveColor: redColor,
                  activeTextColor: Colors.white,
                  inactiveTextColor: Colors.white,
                  activeText: 'Online',
                  inactiveText: 'Offline',
                  showOnOff: true,
                  onToggle: (val) {},
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.notificationScreen);
                  },
                  child: Badge(
                    position: const BadgePosition(top: -5, end: -3),
                    badgeContent: const Text(
                      '3',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                    child: const Icon(Icons.notifications,
                        size: 28, color: paragraphColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return GestureDetector(
      onTap: () async {
        await authController.getCurrentLocation().then((value) async {
          await authController.updateLocation();
        });
      },
      child: Row(
        children: [
          const Icon(
            Icons.my_location_outlined,
            color: Colors.white,
          ),
          const SizedBox(width: 5),
          authController.customerModel.value == null
              ? Obx(
                  () => authController.customerModel.value!.address == null &&
                          authController.customerModel.value!.address == ""
                      ? Text(
                          'Get Location',
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )
                      : Container(
                          width: 150,
                          child: Text(
                            authController.customerModel.value!.address!,
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                )
              : SizedBox(),
          // const Icon(
          //   Icons.keyboard_arrow_down_outlined,
          //   color: Colors.white,
          // )
        ],
      ),
    );
  }
}
