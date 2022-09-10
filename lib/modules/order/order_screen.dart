import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../dummy_data/all_dymmy_data.dart';
import '../../utils/constants.dart';
import '../../widgets/toggle_button_component.dart';
import 'component/order_app_bar.dart';
import 'component/ordered_list_component.dart';
import 'model/product_order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<OrderedProductModel> _productList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _filtering(0);
  // }

  // void _filtering(int index) {
  //   String filter = 'cancelled';
  //   _productList.clear();

  //   if (index == 0) {
  //     filter = 'delivered';
  //   } else if (index == 1) {
  //     filter = 'processing';
  //   }

  //   for (var element in orderProductList) {
  //     if (element.status.toLowerCase() == filter) {
  //       _productList.add(element);
  //     }
  //   }
  //   setState(() {});
  // }

  // final list = ['Active(12)', 'New order(03)', 'Cooking(07)'];

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 174;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: appBarHeight,
            expandedHeight: appBarHeight,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: redColor),
            flexibleSpace: OrderAppBar(height: appBarHeight),
          ),
          // SliverToBoxAdapter(
          //   child: ToggleButtonComponent(
          //     textList: list,
          //     initialLabelIndex: 0,
          //     onChange: _filtering,
          //   ),
          // ),
          // const SliverToBoxAdapter(child: SizedBox(height: 10)),
          OrderedListComponent(orderedList: _productList),
          // const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
