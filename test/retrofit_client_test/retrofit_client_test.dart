import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_in_response/sign_in_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/sign_out_response/sign_out_response.dart';
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'retrofit_client_test.mocks.dart';

@GenerateMocks(<Type>[Dio])
void main() {
  late MockDio mockDio;
  late RetrofitClient client;

  setUp(() {
    mockDio = MockDio();
    client = RetrofitClient(mockDio);

    // Stub for options
    when(mockDio.options).thenReturn(BaseOptions());

    // Stub for fetch
    when(mockDio.fetch<Map<String, dynamic>>(any)).thenAnswer(
      (_) async => Response<Map<String, dynamic>>(
        data: <String, dynamic>{},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
  });

  test('signIn returns SignInResponse', () async {
    final Map<String, Map<String, String>> responsePayload =
        <String, Map<String, String>>{
      'data': <String, String>{'token': 'dummy_token'},
    };
    when(
      mockDio.post(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (_) async => Response<Map<String, dynamic>>(
        data: responsePayload,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    // Act
    final SignInResponse response =
        await client.signIn('test@example.com', 'password123', 'password');

    // Assert
    expect(response, isA<SignInResponse>());
  });

  test('signOut returns SignOutResponse', () async {
    // Arrange
    final Map<String, bool> responsePayload = <String, bool>{
      'success': true,
    };
    when(
      mockDio.get(
        any,
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (_) async => Response<Map<String, dynamic>>(
        data: responsePayload,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    // Act
    final SignOutResponse response = await client.signOut();

    // Assert
    expect(response, isA<SignOutResponse>());
  });
}
