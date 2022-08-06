import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rest_api/service/product_model.dart';

class ServicePOSTLearnView extends StatefulWidget {
  const ServicePOSTLearnView({super.key});

  @override
  State<ServicePOSTLearnView> createState() => _ServicePOSTLearnViewState();
}

class _ServicePOSTLearnViewState extends State<ServicePOSTLearnView> {
  bool isLoading = false;
  late final Dio _dio;
  String? name;
  final TextEditingController _prodctNameController = TextEditingController();
  final TextEditingController _prodctDescriptionController = TextEditingController();
  final TextEditingController _prodctPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: "http://localhost:3000/"));
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading; // bu metot her çağırıldığında isLoadingin değeri değişecek.
    });
  }

  Future<void> addItemToService(ProductModel productModel) async {
    changeLoading();

    final response = await _dio.post("products", data: productModel);

    if (response.statusCode == HttpStatus.created) {
      name = 'ekleme basarili';
    }

    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? 'null döndü'),
        actions: [isLoading ? const CircularProgressIndicator.adaptive() : const SizedBox.shrink()],
      ),
      body: Column(
        children: [
          TextField(
            controller: _prodctNameController,
            decoration: const InputDecoration(labelText: 'Ürün Adı'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _prodctDescriptionController,
            decoration: const InputDecoration(labelText: 'Ürün Açıklaması'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _prodctPriceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Ürün Fiyatı'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_prodctNameController.text.isNotEmpty &&
                          _prodctDescriptionController.text.isNotEmpty &&
                          _prodctPriceController.text.isNotEmpty) {
                        final model = ProductModel(
                            name: _prodctNameController.text,
                            description: _prodctDescriptionController.text,
                            price: int.tryParse(_prodctPriceController.text));
                        addItemToService(model);
                      }
                    },
              child: const Text('Ekle'))
        ],
      ),
    );
  }
}
