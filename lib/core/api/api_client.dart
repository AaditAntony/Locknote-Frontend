import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../storage/token_storage.dart';


class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final isAuthEndpoint =
        options.path.startsWith('/api/auth');

        if (!isAuthEndpoint) {
          final token = await TokenStorage.getToken();
          print('🔐 Token attached: $token');

          if (token != null) {
            options.headers['Authorization'] =
            'Bearer $token';
          }
        } else {
          print('🚫 Auth endpoint — skipping token');
        }

        return handler.next(options);
      },
    ),
  );
}
