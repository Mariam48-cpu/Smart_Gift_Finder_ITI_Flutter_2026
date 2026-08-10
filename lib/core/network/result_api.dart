sealed class ResultApi<T> {}

class Success<T> extends ResultApi<T> {
  final T data;

  Success(this.data);
}

class Error<T> extends ResultApi<T> {
  final String messageError;

  Error(this.messageError);
}