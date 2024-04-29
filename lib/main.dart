import 'package:admin_app/constants/theme.dart';
import 'package:admin_app/providers/product_provider.dart';
import 'package:admin_app/providers/theme_provider.dart';
import 'package:admin_app/screen/dashboard_screen.dart';
import 'package:admin_app/screen/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:admin_app/providers/order_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, val, child) {
        return MaterialApp(
          theme: Styles.themeData(
              isDarkTheme: val.getIsDarkThmeme, context: context),
          home: const DashboardScreen(),
          routes: {'searchname': (context) => const SearchScreen()},
        );
      }),
    );
  }
}
