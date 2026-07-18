import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/change_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/forget_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/change_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/forget_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/verify_reset_code_response.dart';

part 'auth_api_client.g.dart';

@RestApi()
@injectable
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(AuthEndPoint.signup)
  Future<RegisterResponseDto> register(@Body() RegisterRequestDto request);

  @POST(AuthEndPoint.forgetPassword)
  Future<ForgetPasswordResponseDto> forgotPassword(
    @Body() ForgetPasswordRequestDto request,
  );

  @POST(AuthEndPoint.verifyCode)
  Future<VerifyResetCodeResponseDto> verifyResetCode(
    @Body() VerifyResetCodeRequestDto request,
  );

  @PUT(AuthEndPoint.resetPassword)
  Future<ResetPasswordResponseDto> resetPassword(
    @Body() ResetPasswordRequestDto request,
  );

  @PATCH(AuthEndPoint.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
    @Body() ChangePasswordRequestDto request,
  );
}
