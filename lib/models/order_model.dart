import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String productTitle;
  final String userNmae;
  final String price;
  final String image;
  final String quantity;
  final Timestamp orderDates;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.productTitle,
    required this.userNmae,
    required this.price,
    required this.image,
    required this.quantity,
    required this.orderDates,
  });
}
