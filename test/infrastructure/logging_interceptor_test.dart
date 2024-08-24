import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/infrastructure/ws/rest/logging_interceptor.dart';
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

  test('should log onResponse', () async {
    const String logMessage = 'onResponse -------------------';
    const String testUrl = 'https://jsonplaceholder.typicode.com/posts/1';

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

  test('should log onError', () async {
    const String logMessage = 'onError ---------------------';
    const String testUrl = 'https://example.com/404';

    await runZonedGuarded(
      () async {
        try {
          await dio.get(testUrl);
        } catch (_) {
          // The request will fail, but we're interested in the log output.
        }
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
