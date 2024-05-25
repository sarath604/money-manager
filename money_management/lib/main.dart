import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_models.dart';
import 'package:money_management/models/transactions/transaction_model.dart';
import 'package:money_management/sreens/splash_screen.dart';

import 'package:money_management/transactions/add_transactions.dart';

const appcolor = Color.fromARGB(199, 6, 14, 159);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelsAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelsAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appcolor),
        primaryColor: appcolor,
        
      ),
      home: const ScreenSplash(),
      routes: {
        ScreenaddTransaction.routename: (context) =>
            const ScreenaddTransaction(),
      },
    );
  }
}
