// bu classta service get learn view , service post learn view ve delete ve put işlemlerinin hepsini bir araya toplayacağım.
// artık başka bir classta kullanmak istersem o classta bu sınıfın nesnesini üretip kullanabilirim.
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'product_model.dart';

abstract class IProductService {
  Future<bool> addItemToService(ProductModel productModel);
  Future<bool> putItemToService(ProductModel productModel, int id);
  Future<bool> deleteItemToService(int id);
  Future<List<ProductModel>?> fetchProductsItemsFromService();
}

class ProductService {
  final Dio _dio;
  ProductService() : _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));

  Future<List<ProductModel>?> fetchProductsItemsFromService() async {
    try {
      final response =
          await _dio.get("products"); //servisten veriyi okumak zaman alacağından asenkron yapı kullanılır. (async)

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;

        if (_datas is List) {
          return _datas.map((e) => ProductModel.fromJson(e)).toList();
        }
      }
    } on DioError catch (error) {
      print(error.message);
      _ShowDebug.showDioError(error, this);
    }
    return null;
  }

  Future<bool> addItemToService(ProductModel productModel) async {
    try {
      final response = await _dio.post("products", data: productModel);

      return response.statusCode == HttpStatus.created;
    } on DioError catch (error) {
      _ShowDebug.showDioError(error, this);
    }
    return false;
  }

  Future<bool> putItemToService(ProductModel productModel, int id) async {
    try {
      final response = await _dio.put('${_ProductServicePaths.products.name}/$id', data: productModel);

      return response.statusCode == HttpStatus.ok;
    } on DioError catch (error) {
      _ShowDebug.showDioError(error, this);
    }
    return false;
  }

  Future<bool> deleteItemToService(int id) async {
    try {
      final response = await _dio.delete('${_ProductServicePaths.products.name}/$id');

      return response.statusCode == HttpStatus.ok;
    } on DioError catch (error) {
      _ShowDebug.showDioError(error, this);
    }
    return false;
  }
}

class _ShowDebug {
  static void showDioError<T>(DioError error, T type) {
    if (kDebugMode) {
      print(error.message);
      print(type);
      print('-----');
    }
  }
}

enum _ProductServicePaths { products, profiles }
