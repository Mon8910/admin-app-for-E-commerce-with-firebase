import 'package:admin_app/models/order_model.dart';
import 'package:admin_app/widgets/subtitle_test.dart';
import 'package:admin_app/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class OrdersWidgetFree extends StatelessWidget {
  const OrdersWidgetFree({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FancyShimmerImage(
            imageUrl: orderModel.image,
            width: size.width * .2,
            height: size.height * .15,
            boxFit: BoxFit.fill,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: TitleText(
                        label: orderModel.productTitle,
                        maxLines: 2,
                      )),
                      const Icon(Icons.clear)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SubtitleText(label: 'price: ${orderModel.price}\$'),
                  const SizedBox(
                    height: 10,
                  ),
                  SubtitleText(label: 'qty :${orderModel.quantity}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
