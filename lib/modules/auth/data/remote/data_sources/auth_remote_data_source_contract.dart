import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/login_response.dart';

import '../../models/request/login_request_body.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<BaseResponse<LoginResponse>> login(LoginRequestBody request);
}
