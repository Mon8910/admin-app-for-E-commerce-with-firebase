import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId;
  final String productPrice;
  final String productTitle;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final String productQuantity;
  final Timestamp? createdAt;
  

  ProductModel({
    required this.productId,
    required this.productPrice,
    required this.productTitle,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
    this.createdAt
  });
   factory ProductModel.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data() as Map<String, dynamic>;
    return ProductModel(
        productId: data['userId'],
        productPrice: data['priceProduct'],
        productTitle: data['titleProduct'],
        productCategory: data['category'],
        productDescription: data['descriptionProduct'],
        productImage: data['userImage'],
        productQuantity: data['qtyProduct'],
        createdAt: data['createdAt']);
  }
}
