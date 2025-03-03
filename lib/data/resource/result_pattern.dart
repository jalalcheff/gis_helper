sealed class Result<T>{
  const Result();
factory Result.ok(T value) => Ok(value);
factory Result.error(Object e) => ErrorValue(e);
}
final class Ok<T> extends Result<T>{
final T value;

  Ok(this.value);
}

final class ErrorValue<T> extends Result<T>{
final Object e;

  ErrorValue(this.e);
}