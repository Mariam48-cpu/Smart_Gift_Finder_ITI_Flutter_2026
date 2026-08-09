import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';


class ProductDetailsService {
  final Dio _dio;

  ProductDetailsService(this._dio);

  Future<Map<String, dynamic>> getProductDetails(int productId) async {
    final response =
        await _dio.get('https://dummyjson.com/products/$productId');
    return response.data;
  }
}


abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final Map<String, dynamic> product;
  ProductDetailsSuccess(this.product);
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}


class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsService service;

  ProductDetailsCubit(this.service) : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = await service.getProductDetails(productId);
      emit(ProductDetailsSuccess(product));
    } catch (e) {
      emit(ProductDetailsError('error'));
    }
  }
}
