import 'package:flutter_test/flutter_test.dart';
import 'package:minor_register/src/features/register/register.cubit.dart';
import 'package:minor_register/src/network/app_client.dart';
import 'package:minor_register/src/network/minor_api/minor_api.dart';

import 'mock/mock_minor_api.dart';

void main() {
  final client = AppClient(
    baseUrl: 'http://localhost:8080',
    apiKey: 'test_api_key',
  );
  MockMinorApi(dio: client.dio);
  MinorApi mockMinorApi = MinorApi(client: client);

  group('Register', () {
    test('Request OTP success', () async {
      final cubit = RegisterCubit(minorApi: mockMinorApi);
      cubit.updateData(
        firstName: 'john',
        lastName: 'doe',
        mobileTel: '0000000000',
      );
      await cubit.otpRequest();

      expect(cubit.state.refCode, 'abcdef');
      expect(cubit.state.otp, '000000');
    });

    test('Register with OTP success', () async {
      final cubit = RegisterCubit(minorApi: mockMinorApi);
      cubit.updateData(
        firstName: 'john',
        lastName: 'doe',
        mobileTel: '0000000000',
      );
      await cubit.otpRequest();
      cubit.updateData(otp: '000000');
      final response = await cubit.register();
      expect(response, true);
    });
  });
}
