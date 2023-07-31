import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:whatsapp/chat_app/domain/repository/status_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';


class UploadStatusUseCase extends BaseUseCase<void, UploadStatusParams> {
  final StatusRepository _repository;

  UploadStatusUseCase(this._repository);
  @override
  Future<Result<Failure, void>> call(UploadStatusParams params) async {
    return await _repository.uploadStatus(params);
  }
}

class UploadStatusParams extends Equatable {
  final String username;
  final String profilePic;
  final String phoneNumber;
  final File statusImage;
  final String? caption;
  const UploadStatusParams({
    required this.username,
    required this.profilePic,
    required this.phoneNumber,
    required this.statusImage,
     this.caption,
  });

  @override
  List<Object?> get props => [
        username,
        profilePic,
        phoneNumber,
        statusImage,
        caption,
      ];
}
