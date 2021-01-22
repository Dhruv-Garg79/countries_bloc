import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:countries_bloc/utils/app_logger.dart';
import 'package:countries_bloc/utils/global.dart';

class ApiClient {
  static ApiClient _instanse;
  static Dio _dio;

  ApiClient() {
    final options = BaseOptions(
      baseUrl: Global.baseurl,
      connectTimeout: 90000,
      receiveTimeout: 90000,
      sendTimeout: 90000,
    );

    _dio = new Dio(options);

    addErrorHandler();
  }

  static Dio getInstance() {
    if (_instanse == null) {
      _instanse = ApiClient();
    }

    return _dio;
  }

  void addErrorHandler() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response response) async {
          AppLogger.print(response.toString());
          return response;
        },
        onError: _errorHandler,
      ),
    );
  }

  Future<Response<dynamic>> _errorHandler(DioError dioError) async {
    String message;
    if (dioError.type == DioErrorType.RESPONSE) {
      final data = dioError.response.data;

      if (dioError.response.statusCode == 400) {
        message = "Some error occured";
      } else if (dioError.response.statusCode == 403) {
        message =
            data['error'] != null ? data['error'].toString() : "Forbidden";
        message = "Not found";
      } else if (dioError.response.statusCode == 405) {
        message = "Route does not exist";
      } else if (dioError.response.statusCode == 500) {
        message = data['error'].toString();
      } else {
        message = "Something went wrong";
      }
    } else if (dioError.type == DioErrorType.CONNECT_TIMEOUT) {
      message = "connection timedout";
    } else if (dioError.type == DioErrorType.DEFAULT) {
      if (dioError.message.contains('SocketException')) {
        message = "Please check your internet connection";
      }
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );

    return dioError.response;
  }
}
