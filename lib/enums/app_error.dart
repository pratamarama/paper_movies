/// Created by Pratama Ramadhan on 18/09/26.

enum AppErrorStatus {
  initial,
  other,
  connectionError,
}

class AppError<T> implements Exception {
  final AppErrorStatus status;
  final T? data;
  final String message;
  final Object? error;

  const AppError.initial(this.message, {this.error, this.data}) : status = AppErrorStatus.initial;

  const AppError.other(this.message, {this.error, this.data}) : status = AppErrorStatus.other;

  const AppError.connectionError(this.message, {this.data, this.error}) : status = AppErrorStatus.connectionError;

  @override
  String toString() {
    return 'AppError{status: $status, data: $data, message: $message, error: $error}';
  }
}
