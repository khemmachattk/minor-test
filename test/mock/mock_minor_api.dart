import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class MockMinorApi {
  late DioAdapter adapter;

  MockMinorApi({required Dio dio}) {
    adapter = DioAdapter(dio: dio);

    adapter.onPost(
      '/otp/request',
      data: {
        'first_name': 'john',
        'last_name': 'doe',
        'mobile_tel': '0000000000',
      },
      (server) {
        server.reply(200, {
          'ref_code': 'abcdef',
          'otp': '000000',
        });
      },
    );

    adapter.onPost(
      '/customer/register',
      data: {
        'first_name': 'john',
        'last_name': 'doe',
        'mobile_tel': '0000000000',
        'ref_code': 'abcdef',
        'otp': '000000',
      },
      (server) {
        server.reply(200, {
          'is_valid': true,
        });
      },
    );
  }
}
