// ignore_for_file: unused_element, deprecated_member_use

import 'dart:async';
import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart' as injectable;
import 'package:movies/core/network/api_constants.dart';

import '../error/error_message_model.dart';
import '../error/server_exception.dart';
import 'my_dio.dart';

const somethingWentWrong = 'Something went wrong';

@injectable.Order(-3)
@injectable.injectable
class ApiHelper {
  final Dio? dio = DioClient().createDioClient();
  ApiHelper() {
    dio!.options.baseUrl = ApiConstants.baseUrl;
    final apiKey = dotenv.env['MD_API_Key'];
    dio!.options.queryParameters = {'api_key': apiKey};
    var interceptor = InterceptorsWrapper(
      onRequest: (req, handler) async {
        handler.next(req);
      },
      onResponse: (res, handler) {
        handler.next(res);
      },
    );
    dio!.interceptors.add(interceptor);
  }

  Future<Either<ServerException, Response>> post(
          {required String path,
          required Map<String, dynamic> body,
          dynamic headers,
          String? contentType}) async =>
      await safeApiHelperRequest(
        () async {
          final Response res = await dio!.post(
            path,
            data: body,
            options: Options(
              headers: headers,
              contentType: contentType,
            ),
          );
          return res;
        },
      );
  Future<Either<ServerException, Response>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async =>
      await safeApiHelperRequest(
        () async {
          final Response res = await dio!.delete(
            path,
            options: Options(headers: headers),
            queryParameters: queryParameters,
          );
          return res;
        },
      );
  Future<Either<ServerException, Response>> postForm<T>(
          String path, FormData body,
          {dynamic headers}) async =>
      await (safeApiHelperRequest(
        () => dio!.post(
          path,
          data: body,
          options: Options(
            headers: {'content_type': 'multipart/form-data'},
          ),
        ),
      ));

  Future<Either<ServerException, Response>> get<T>({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async =>
      safeApiHelperRequest(
        () => dio!.get(
          path,
          options: Options(headers: headers),
          queryParameters: queryParameters,
        ),
      );

  Future<Either<ServerException, Response>> put(
    String path,
    HashMap<String, dynamic> body, {
    dynamic headers,
  }) async =>
      await safeApiHelperRequest(
        () async {
          final Response res = await dio!.put(
            path,
            data: FormData.fromMap(body),
            options: Options(headers: headers),
          );
          return res;
        },
      );

  Future<Either<ServerException, Response>> safeApiHelperRequest(
    Future<dynamic> Function() function,
  ) async {
    try {
      // stores what is returned from this function
      final Response response = await (function.call());
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return Right(response);
      } else {
        if (response.statusCode == 401 && response.data['detail'] != null) {
          return Left(ServerException(
              errorMessageModel: ErrorMessageModel(
                  statusCode: response.statusCode,
                  message: response.data['message'],
                  success: false)));
        }
      }

      return Left(ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode, message: somethingWentWrong)));
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.unknown:
          return Left(ServerException(
              errorMessageModel: ErrorMessageModel(
                  statusCode: e.response?.statusCode,
                  message: 'server cannot be accessed')));

        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 401) {
            Fluttertoast.showToast(msg: 'UnAuthorized User');

            return Left(ServerException(
                errorMessageModel: ErrorMessageModel(
                    statusCode: e.response?.statusCode, message: e.message)));
          }
          if (e.response != null &&
              e.response!.data != null &&
              e.response!.data != '') {
            return Left(ServerException(
                errorMessageModel: ErrorMessageModel(
                    statusCode: e.response?.statusCode,
                    message: e.response?.data?['message'])));
          }
          if (e.response == null || e.response?.statusCode == 404) {
            return Left(ServerException(
                errorMessageModel: ErrorMessageModel(
                    statusCode: e.response?.statusCode,
                    message: _handleError(e))));
          }

          break;

        default:
          return Left(ServerException(
              errorMessageModel: ErrorMessageModel(
                  statusCode: e.response?.statusCode,
                  message: _handleError(e))));
      }
      return Left(ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: e.response?.statusCode, message: 'Server Error')));
    }
  }

  String _handleError(DioException error) {
    String errorDescription = "";

    DioError dioError = error;
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        errorDescription =
            "Received invalid status code: ${dioError.response!.statusCode}";
        break;
      case DioErrorType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.unknown:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.badCertificate:
        errorDescription = "Bad certfiicate";
        break;
      case DioErrorType.connectionError:
        errorDescription = "Something went wrong";
        break;
    }

    return errorDescription;
  }
}
