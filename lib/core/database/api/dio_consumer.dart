import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/core/database/cache/cache_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late Dio dio;

  static init() async {
    dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 60), // 60 seconds
        receiveTimeout: Duration(seconds: 60),

        baseUrl: link ?? ApiUrls.BASE_URL,
        receiveDataWhenStatusError: true,
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    error: true,
  );

  static Future<Response?> get(
      {required String endpoint,
      dynamic headers = const {},
      Map<String, dynamic> queryParameters = const {}}) async {
    print("headers $headers");
    try {
      dio.options.headers = {
        "Accept": "application/json",
        "X-API-KEY": "fL9kPz1@#bN3^XeT1J5%HgKmz8QoLpRaWyZv7C!Mx+d#34Gj",
        "Authorization": "Bearer $uid",
        // 'Content-type': 'application/json',
      };
      return await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<Response?> getData(
      {required String endpoint,
      dynamic headers = const {},
      Map<String, dynamic> queryParameters = const {}}) async {
    print("headers $headers");
    try {
      dio.options.headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $uid",
        "X-API-KEY": "fL9kPz1@#bN3^XeT1J5%HgKmz8QoLpRaWyZv7C!Mx+d#34Gj",
        'Content-type': 'application/json',
      };
      return await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<Response> postData({
    required String path,
    String? token,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer $uid",
      "X-API-KEY": "fL9kPz1@#bN3^XeT1J5%HgKmz8QoLpRaWyZv7C!Mx+d#34Gj",
      // 'Content-type': 'multipart/form-data'
    };
    return await dio.post(
      path,
      data: data,
      queryParameters: query,
      options: Options(validateStatus: (int? status) {
        if (status! >= 200 && status <= 600) {
          return true;
        }
        return false;
      }),
    );
  }

  static Future<Response> postDataa({
    required String path,
    String? token,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "Accept": "application/json",
      "X-API-KEY": "fL9kPz1@#bN3^XeT1J5%HgKmz8QoLpRaWyZv7C!Mx+d#34Gj"
      // "Content-Type": "application/json",
      // "Authorization": "Bearer $uid",
      // 'Content-type': 'multipart/form-data'
    };
    return await dio.post(path, data: data, queryParameters: query);
  }

  // Future<Response> postFormData(
  //     {required String endPoint,
  //     dynamic headers = const {},
  //     Map<String, dynamic> formBody = const {}}) async {
  //   try {
  //     dio.options.headers = {
  //       "Accept": "application/json",
  //       "Authorization": "Bearer $uid",
  //       // 'Content-type': 'multipart/form-data'
  //     };
  //     return await dio.post(endPoint,
  //         options: Options(
  //             headers: {"Authorization": "Bearer $uid"},
  //             validateStatus: (int? status) {
  //               if (status! >= 200 && status <= 600) {
  //                 return true;
  //               }
  //               return false;
  //             }),
  //         data: FormData.fromMap(
  //           formBody,
  //         ));
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  Future<Response?> putFormData(
      {required String endPoint,
      Map<String, dynamic> formBody = const {}}) async {
    try {
      dio.options.headers = {
        "Accept": "application/json",

        "Authorization": "Bearer $uid",
        "X-API-KEY": "fL9kPz1@#bN3^XeT1J5%HgKmz8QoLpRaWyZv7C!Mx+d#34Gj",
        // "secretKey": "tgCiGblcr1daxYxx3Lw8uw==",
        'Content-type': 'multipart/form-data'
      };
      return await dio.put(
        endPoint,
        data: FormData.fromMap(formBody),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<Response?> delete({
    required String endPoint,
    dynamic body,
    dynamic queryParameters,
    // Map<String, dynamic> headers = const {}
  }) async {
    // String? accessToken =
    //     MyApp.navKey.currentState!.context.read<AuthCubit>().accessToken;
    // if (kDebugMode) {
    //   print("Access token: $accessToken");
    // }

    try {
      dio.options.headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $uid",
        "X-API-KEY": "fL9kPz1@#bN3^XeT1J5%HgKmz8QoLpRaWyZv7C!Mx+d#34Gj",
        // 'Content-type': 'multipart/form-data'
      };
      return await dio.delete(
        endPoint,
        data: body,
        queryParameters: queryParameters,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<Response?> put(
      {required String endPoint,
      dynamic body = const {},
      Map<String, dynamic>? query,
      Map<String, dynamic> headers = const {}}) async {
    // String? accessToken =
    //     MyApp.navKey.currentState!.context.read<AuthCubit>().accessToken;
    // if (kDebugMode) {
    //   print("Access token: $accessToken");
    // }
    if (kDebugMode) {
      print("headers $headers");
    }

    try {
      dio.options.headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $uid",
        "X-API-KEY": "fL9kPz1@#bN3^XeT1J5%HgKmz8QoLpRaWyZv7C!Mx+d#34Gj",
        // 'Content-type': 'multipart/form-data'
      };
      return await dio.put(endPoint, data: body, queryParameters: query);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
