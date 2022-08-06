import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rest_api/service/product_model.dart';

class ServiceGETLearnView extends StatefulWidget {
  const ServiceGETLearnView({super.key});

  @override
  State<ServiceGETLearnView> createState() => _ServiceGETLearnViewState();
}

class _ServiceGETLearnViewState extends State<ServiceGETLearnView> {
  List<ProductModel>? _items; //servisten gelecek dataların listesine _items üzerinden erişebileceğim.
  bool isLoading = false;
  late final Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: "http://localhost:3000/"));
    fetchProductItems();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading; // bu metot her çağırıldığında isLoadingin değeri değişecek.
    });
  }

  Future<void> fetchProductItems() async {
    changeLoading();
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datas'),
        actions: [isLoading ? const CircularProgressIndicator.adaptive() : const SizedBox.shrink()],
      ),
      body: ListView.builder(
        itemCount: _items?.length ?? 0, // _items null gelebilir. gelirse length = 0 olarak ata.
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _ProductCard(productModel: _items?[index]),
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    Key? key,
    required ProductModel? productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel? _productModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_productModel?.name ?? 'name'),
        subtitle: Text(_productModel?.description ?? 'desc'),
      ),
    );
  }
}
