import 'package:admin_app/screen/edit_or_update_screen.dart';
import 'package:admin_app/screen/orders/order_screen.dart';
import 'package:admin_app/screen/search_screen.dart';
import 'package:flutter/material.dart';

class DashBoardModel {
  final String image;
  final String title;
  final Function onPressed;

  DashBoardModel({
    required this.image,
    required this.title,
    required this.onPressed,
  });
  static List<DashBoardModel> dashBoardData(BuildContext context) => [
        DashBoardModel(
          image: 'assets/images/cloud.png',
          title: 'Add a new Product',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const EditOrUpdateScreen(),
              ));
          },
        ),
        DashBoardModel(
          image: 'assets/images/shopping_cart.png',
          title: 'inspect all orders',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const SearchScreen(),
              ),
            );
          },
        ),
        DashBoardModel(
          image: 'assets/images/order.png',
          title: 'view order',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const OrderScreen(),
              ),
            );
          },
        ),
      ];
}
