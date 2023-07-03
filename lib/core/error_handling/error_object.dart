import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/resources/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'error_object.freezed.dart';

typedef Result<L, R> = Either<L, R>;

// @freezed
// class ErrorModel with _$ErrorModel {
//   const factory ErrorModel({
//     required String message,
//     ResultErrorType? resultErrorType,
//   }) = _ErrorModel;

//   const ErrorModel._();
// }

// extension NetworkErrorTypeExtension on NetworkErrorType {
//   ResultErrorType toResultErrorType() {
//     switch (this) {
//       case .cancel:
//         return ResultErrorType.cancel;
//       case NetworkErrorType.parsing:
//         return ResultErrorType.parsing;
//       case NetworkErrorType.unauthorised:
//         return ResultErrorType.unauthorised;
//       case NetworkErrorType.forbidden:
//         return ResultErrorType.forbidden;
//       case NetworkErrorType.noData:
//         return ResultErrorType.noData;
//       case NetworkErrorType.badConnection:
//         return ResultErrorType.badConnection;
//       case NetworkErrorType.server:
//         return ResultErrorType.server;
//       case NetworkErrorType.unprocessable:
//         return ResultErrorType.unProcessable;
//       case NetworkErrorType.badRequest:
//       case NetworkErrorType.other:
//         return ResultErrorType.other;
//     }
//   }
// }

