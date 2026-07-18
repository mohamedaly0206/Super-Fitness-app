import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/change_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/forget_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/change_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/forget_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/verify_reset_code_response.dart';

part '../data_sources/forget_password_api_client.g.dart';

@RestApi()
abstract interface class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio, {String baseUrl}) =
      _ForgetPasswordApiClient;

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
