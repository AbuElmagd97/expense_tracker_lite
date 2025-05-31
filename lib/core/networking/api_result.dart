sealed class ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;

  const factory ApiResult.failure(String error) = Failure<T>;
}

class Success<T> implements ApiResult<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> implements ApiResult<T> {
  final String error;

  const Failure(this.error);
}
