import 'package:flutter/material.dart';
import 'package:rest_api/service/product_model.dart';
import 'package:rest_api/service/product_service.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({super.key});

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {
  List<ProductModel>? _items;
  late final IProductService _productService;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _productService = ProductService() as IProductService;
    fetchPostItemsAdvance();
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> fetchPostItemsAdvance() async {
    _changeLoading();
    _items = await _productService.fetchProductsItemsFromService();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tüm Ürünleriniz'),
          actions: [isLoading ? const CircularProgressIndicator.adaptive() : const SizedBox.shrink()],
        ),
        body: ListView.builder(
          itemCount: _items?.length ?? 0,
          itemBuilder: (context, index) {
            return const Text('data');
          },
        ));
  }
}
