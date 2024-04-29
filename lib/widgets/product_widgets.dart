import 'package:admin_app/providers/product_provider.dart';
import 'package:admin_app/screen/edit_or_update_screen.dart';
import 'package:admin_app/widgets/title_text.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productid,
  });
  final String productid;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final getProducts = products.getProductModel(productid);

    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) =>
                  EditOrUpdateScreen(productModel: getProducts)),
            ),
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FancyShimmerImage(
                imageUrl: getProducts!.productImage,
                height: height * .23,
                width: double.infinity,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: TitleText(
                  label: getProducts.productTitle,
                  maxLines: 2,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
