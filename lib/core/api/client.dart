import 'package:dio/dio.dart';

class Client {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= Dio();
    return _instance!;
  }

  // static void setInterceptor() {
  //   print(123);
  //   instance.interceptors
  //       .add(InterceptorsWrapper(onError: (error, handler) async {
  //     if (error.response?.statusCode == 403 ||
  //         error.response?.statusCode == 401) {
  //       // await refreshToken();
  //       // _retry(error.request);
  //       print('loi roi');
  //     }
  //   }));
  // }

  static void setToken(String access) {
    instance.options.headers['authorization'] = 'Bearer $access';
  }
}
