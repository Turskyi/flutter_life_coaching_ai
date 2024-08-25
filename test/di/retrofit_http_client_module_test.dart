import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/di/retrofit_http_client_module.dart';
import 'package:lifecoach/infrastructure/ws/models/authentication_response/sign_in_response/sign_in_response.dart';
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart';
import 'package:mockito/mockito.dart';

import '../retrofit_client_test/retrofit_client_test.mocks.dart';

class TestRetrofitHttpClientModule extends RetrofitHttpClientModule {}

void main() {
  group('RetrofitHttpClientModule', () {
    late TestRetrofitHttpClientModule retrofitHttpClientModule;
    late MockDio mockDio;
    late RetrofitClient client;

    setUp(() {
      retrofitHttpClientModule = TestRetrofitHttpClientModule();
      mockDio = MockDio();
      when(mockDio.options).thenReturn(BaseOptions());
      when(mockDio.fetch(any)).thenAnswer(
        (_) async => Response<Map<String, String>>(
          requestOptions: RequestOptions(path: ''),
          data: <String, String>{'token': 'dummy_token'},
        ),
      );
      client = retrofitHttpClientModule.getRestClient(mockDio);
    });

    test('should call signIn with correct parameters', () async {
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response<Map<String, String>>(
          requestOptions: RequestOptions(path: ''),
          data: <String, String>{'token': 'dummy_token'},
        ),
      );

      final SignInResponse response =
          await client.signIn('identifier', 'password', 'password');

      expect(response.token, '');
      verifyNever(
        mockDio.post(
          'https://clerk.turskyi.com/v1/client/sign_ins?_clerk_js_version=5.14.0',
          data: <String, String>{
            'identifier': 'identifier',
            'password': 'password',
            'strategy': 'password',
          },
        ),
      ).called(0);
    });

    test('should call signOut and return correct response', () async {
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response<Map<String, Object>>(
          requestOptions: RequestOptions(path: ''),
          data: <String, Object>{
            'display_config': <String, String>{
              'object': 'display_config',
              'id': 'display_config_something',
              'instance_environment_type': 'production',
              'application_name': 'life-coaching-ai',
            },
            'user_settings': <String, Map<String, Map<String, bool>>>{
              'attributes': <String, Map<String, bool>>{
                'email_address': <String, bool>{
                  'enabled': true,
                  'required': true,
                  'used_for_first_factor': true,
                },
              },
            },
            'organization_settings': <String, Object>{
              'enabled': false,
              'max_allowed_memberships': 5,
            },
            'maintenance_mode': false,
          },
        ),
      );

      verifyNever(
        mockDio.get(
          'https://clerk.turskyi.com/v1/environment?_clerk_js_version=5.14.0',
        ),
      ).called(0);
    });
  });
}
