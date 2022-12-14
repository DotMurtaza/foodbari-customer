import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../order/component/invoice_widget.dart';
import '../../order/model/product_order_model.dart';

class SingleOrderHistoryComponent extends StatelessWidget {
  const SingleOrderHistoryComponent({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  final OrderedProductModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(14),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductHeader(),
          const SizedBox(height: 8),
          _buildPriceAndDelivery(),
          const SizedBox(height: 14),
          PrimaryButton(
            minimumSize: const Size(double.infinity, 40),
            fontSize: 16,
            grediantColor: const [blackColor, blackColor],
            text: 'View Details',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.orderDetailsPage,
                  arguments: orderItem.productList);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Utils.formatDate(orderItem.orderDate),
              style: const TextStyle(height: 1, color: paragraphColor),
            ),
            const SizedBox(height: 8),
            InVoiceWidget(text: orderItem.invoice),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Order Time',
              style: TextStyle(height: 1, color: redColor),
            ),
            const SizedBox(height: 1),
            Text(
              orderItem.orderDeliveryTime,
              style:
                  GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }

  Widget _buildPriceAndDelivery() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderItem.paymentType,
              style: const TextStyle(height: 1, color: paragraphColor),
            ),
            Text(
              Utils.formatPrice(orderItem.price),
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1,
                  color: redColor),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Delivery Time',
              style: TextStyle(height: 1, color: redColor),
            ),
            const SizedBox(height: 1),
            Text(
              orderItem.orderDeliveryTime,
              style:
                  GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
