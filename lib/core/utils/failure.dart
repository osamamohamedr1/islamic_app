import 'package:dio/dio.dart';

class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: 'Connection timed out.\nCheck your internet.',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Request took too long to send.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Server took too long to respond.');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'Invalid security certificate.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request was canceled.');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'No internet connection.');
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return ServerFailure(errorMessage: 'No internet connection.');
        }
        return ServerFailure(errorMessage: 'Unexpected error.\nTry again.');
      // ignore: unreachable_switch_default
      default:
        return ServerFailure(errorMessage: 'Something went wrong.\nTry again.');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: 'Something went wrong.');
    } else if (statusCode == 404) {
      return ServerFailure(errorMessage: 'Request not found.');
    } else if (statusCode == 500) {
      return ServerFailure(errorMessage: 'Server error. Try again later.');
    } else {
      return ServerFailure(errorMessage: 'Something went wrong.');
    }
  }
}
