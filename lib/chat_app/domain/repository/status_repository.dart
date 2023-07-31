import 'package:whatsapp/chat_app/data/models/status_model.dart';
import 'package:whatsapp/chat_app/domain/entities/status_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/status/upload_status_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

abstract class StatusRepository {
  Future<Result<Failure, void>> uploadStatus(UploadStatusParams params);
  Future<Result<Failure, List<StatusEntity>>> getStatuses();
}
