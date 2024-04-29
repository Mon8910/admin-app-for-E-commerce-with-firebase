import 'dart:developer';

import 'package:admin_app/models/dashboard_model.dart';
import 'package:admin_app/providers/product_provider.dart';
import 'package:admin_app/widgets/dashboard_widget.dart';
import 'package:admin_app/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  bool isLoading = true;
  Future<void> fetchDB() async {
    final product = Provider.of<ProductProvider>(context, listen: false);
    try {
    await  Future.wait({
        product.fetchDatat(),
      });
      return;
    } catch (error) {
      log(error.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoading) {
      fetchDB();
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    //final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const TitleText(label: "Dashboard Screen"),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/shopping_cart.png'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                themeProvider.setIsDarkTheme(!themeProvider.getIsDarkThmeme);
              },
              icon: Icon(themeProvider.getIsDarkThmeme
                  ? Icons.light_mode
                  : Icons.dark_mode),
            ),
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          children: List.generate(
              3,
              (index) => DashBoardWidget(
                  image: DashBoardModel.dashBoardData(context)[index].image,
                  title: DashBoardModel.dashBoardData(context)[index].title,
                  onPressed:
                      DashBoardModel.dashBoardData(context)[index].onPressed)),
        ));
  }
}
