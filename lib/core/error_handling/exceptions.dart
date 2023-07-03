import 'package:equatable/equatable.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

class ServerException extends Equatable implements Exception {
  final String message;

  const ServerException(this.message);
  @override
  List<Object?> get props => [message];
}

class DataParsingException extends Equatable implements Exception {
  final String message;

  const DataParsingException(this.message);
  @override
  List<Object?> get props => [message];
}

class NoConnectionException extends Equatable implements Exception {
  final String message;

  const NoConnectionException(this.message);
  @override
  List<Object?> get props => [message];
}

class CachedException extends Equatable implements Exception {
  final String message;

  const CachedException(this.message);
  @override
  List<Object?> get props => [message];
}
