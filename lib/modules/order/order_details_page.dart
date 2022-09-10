import 'package:flutter/material.dart';
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
    required this.productList,
  }) : super(key: key);
  final List<ProductModel> productList;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final panelController = PanelController();
  final double height = 145;
  final headerStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
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
        panelBuilder: (sc) => PanelComponent(controller: sc),
        minHeight: height,
        maxHeight: 380,
        backdropEnabled: true,
        backdropTapClosesPanel: true,
        parallaxEnabled: false,
        backdropOpacity: 0.0,
        collapsed: PannelCollapsComponent(height: height),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final bottstats = MediaQuery.of(context).padding.bottom;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: CartPageHeader(length: 4)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: CartProductList(
              populerProductList: widget.productList.take(2).toList()),
        ),
        SliverToBoxAdapter(child: SizedBox(height: bottstats + 215)),
      ],
    );
  }
}
