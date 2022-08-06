import 'package:flutter/material.dart';
import 'package:rest_api/screens/list_products_screen.dart';
import 'package:rest_api/screens/service_operations_view.dart';
import 'package:rest_api/service/service_GET_learn_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const ListProductsView(),
    );
  }
}
