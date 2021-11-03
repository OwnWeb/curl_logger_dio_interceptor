import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  late final Dio _dio;

  MyApp({Key? key}) : super(key: key) {
    _dio = Dio();

    // avoid using it in production or do it at your own risks!
    if (!kReleaseMode) {
      _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
          onPressed: () {
            _dio.post('https://flutter.dev/some404',
                options: Options(headers: {'Auth': 'SOME-TOKEN'}));
          },
          child: const Text('Run POST errored request'),
        ),
        const SizedBox(height: 20),
        const Text(
          'After pressing the button, go in your terminal and copy the curl code. Paste it in your terminal. Tada ✨',
          textAlign: TextAlign.center,
        )
      ]),
    ));
  }
}
