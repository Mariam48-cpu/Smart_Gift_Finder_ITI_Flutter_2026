import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_gift_finder/core/network/api_constants.dart';

@module
abstract class InjectableModule {
  @injectable
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
}
