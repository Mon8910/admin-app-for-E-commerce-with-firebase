import 'package:admin_app/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];
  List<OrderModel> get getOrders => _orders;
  Future<List<OrderModel>> fetchOrder() async {
    // final auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;
    // var uid = user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('order')
          .get()
          .then((orderSnapShot) {
        _orders.clear();
        for (var elements in orderSnapShot.docs) {
          _orders.insert(
              0,
              OrderModel(
                orderId: elements.get('orderId'),
                userId: elements.get('userId'),
                productId: elements.get('productId'),
                productTitle: elements.get('productTitle'),
                userNmae: elements.get('userNmae'),
                price: elements.get('price').toString(),
                image: elements.get('image'),
                quantity: elements.get('quantity').toString(),
                orderDates: elements.get('orderDates'),
              ));
        }
      });
      return _orders;
    } catch (e) {
      rethrow;
    }
  }
}