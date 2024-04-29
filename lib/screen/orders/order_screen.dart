import 'package:admin_app/models/order_model.dart';
import 'package:admin_app/providers/order_provider.dart';
import 'package:admin_app/screen/orders/order_widgets.dart';
import 'package:admin_app/widgets/title_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  final bool isempty = false;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return FutureBuilder<List<OrderModel>>(
        future: orderProvider.fetchOrder(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapShot.hasError) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapShot.hasData || orderProvider.getOrders.isEmpty) {
            const Scaffold(
                body:Center(child: TitleText(label: 'No Data find'),));
          }
          return Scaffold(
            body: ListView.separated(
              itemCount: snapShot.data!.length,
              itemBuilder: (ctx, index) {
                return  Padding(
                  padding:const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 6,
                  ),
                  child: OrdersWidgetFree(orderModel: orderProvider.getOrders[index],),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          );
        });
  }
}
// isempty
//         ? const Scaffold(
//             body: CartEmpty(
//             image: 'assets/images/order.png',
//             title: 'Whoops',
//             subTitle: 'Your order is empty',
//             details: "No orders has been placed yet",
//             textButton: 'Shop now',
//           ))
//         : Scaffold(
//             body: ListView.separated(
//               itemCount: 15,
//               itemBuilder: (ctx, index) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
//                   child: OrdersWidgetFree(),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider();
//               },
//             ),
//           );
