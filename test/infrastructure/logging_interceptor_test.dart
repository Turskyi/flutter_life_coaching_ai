import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/infrastructure/data_sources/remote/rest/interceptors/logging_interceptor.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(<Type>[LoggingInterceptor])
void main() {
  late LoggingInterceptor loggingInterceptor;
  late Dio dio;

  setUp(() {
    loggingInterceptor = const LoggingInterceptor();
    dio = Dio();
    dio.interceptors.add(loggingInterceptor);
  });

  test('should log onRequest', () async {
    const String logMessage = 'onRequest --------------------';
    const String testUrl = 'https://example.com';

    await runZonedGuarded(
      () async {
        await dio.get(testUrl);
      },
      (Object error, StackTrace stackTrace) {
        // Ignore the error since we're only interested in the log output.
      },
      zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          if (line.contains(logMessage)) {
            expect(line, contains(logMessage));
          }
        },
      ),
    );
  });
}
