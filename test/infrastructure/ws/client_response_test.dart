import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/client_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_in_response/session_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_in_response/sign_in_success_response/user_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_up_form_response.dart';

void main() {
  group('ClientResponse', () {
    const SessionResponse sessionResponse = SessionResponse(
      id: 'session_id',
      object: 'session',
      createdAt: 1627847284,
      updatedAt: 1627847284,
      userResponse: UserResponse(),
    );

    const ClientResponse clientResponse = ClientResponse(
      sessions: <SessionResponse>[sessionResponse],
      object: 'client',
      id: 'client_id',
      signIn: 'sign_in_data',
      signUp: SignUpFormResponse(),
      lastActiveSessionId: 'last_active_session_id',
      createdAt: 1627847284,
      updatedAt: 1627847284,
    );

    test('should copy with new values', () {
      final ClientResponse newClientResponse = clientResponse.copyWith(
        object: 'new_client',
        id: 'new_client_id',
      );

      expect(newClientResponse.object, 'new_client');
      expect(newClientResponse.id, 'new_client_id');
      expect(newClientResponse.sessions, clientResponse.sessions);
      expect(newClientResponse.signIn, clientResponse.signIn);
      expect(newClientResponse.signUp, clientResponse.signUp);
      expect(
        newClientResponse.lastActiveSessionId,
        clientResponse.lastActiveSessionId,
      );
      expect(newClientResponse.createdAt, clientResponse.createdAt);
      expect(newClientResponse.updatedAt, clientResponse.updatedAt);
    });

    test('should be equal to another instance with the same values', () {
      const ClientResponse anotherClientResponse = ClientResponse(
        sessions: <SessionResponse>[sessionResponse],
        object: 'client',
        id: 'client_id',
        signIn: 'sign_in_data',
        signUp: SignUpFormResponse(),
        lastActiveSessionId: 'last_active_session_id',
        createdAt: 1627847284,
        updatedAt: 1627847284,
      );

      expect(clientResponse, anotherClientResponse);
    });

    test('should have correct hash code', () {
      const ClientResponse anotherClientResponse = ClientResponse(
        sessions: <SessionResponse>[sessionResponse],
        object: 'client',
        id: 'client_id',
        signIn: 'sign_in_data',
        signUp: SignUpFormResponse(),
        lastActiveSessionId: 'last_active_session_id',
        createdAt: 1627847284,
        updatedAt: 1627847284,
      );

      expect(clientResponse.hashCode, anotherClientResponse.hashCode);
    });
  });
}
