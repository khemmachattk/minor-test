import 'package:minor_register/src/network/app_client.dart';
import 'package:minor_register/src/network/minor_api/data/otp_data.dart';
import 'package:minor_register/src/network/minor_api/data/valid_data.dart';

class MinorApi {
  late AppClient client;

  MinorApi({
    required this.client,
  });

  Future<OtpData> otpRequest({
    required String firstName,
    required String lastName,
    required String mobileTel,
  }) async {
    final response = await client.post(
      '/otp/request',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'mobile_tel': mobileTel,
      },
    );
    return OtpData.fromJson(response.data);
  }

  Future<bool> customerRegister({
    required String firstName,
    required String lastName,
    required String mobileTel,
    required String refCode,
    required String otp,
  }) async {
    final response = await client.post(
      '/customer/register',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'mobile_tel': mobileTel,
        'ref_code': refCode,
        'otp': otp,
      },
    );
    return ValidData.fromJson(response.data).isValid ?? false;
  }
}
