import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';


abstract class AuthRemoteDataSource {
  Future<RegisterResponseDto> register(RegisterRequestDto request);
}
