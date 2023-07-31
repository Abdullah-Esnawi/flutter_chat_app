import 'package:whatsapp/chat_app/domain/entities/status_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/status_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetStatusUseCase extends BaseUseCase<List<StatusEntity>, NoParameters> {
  final StatusRepository _repository;

  GetStatusUseCase(this._repository);
  @override
  Future<Result<Failure, List<StatusEntity>>> call(NoParameters params) async {
    return await _repository.getStatuses();
  }
}
