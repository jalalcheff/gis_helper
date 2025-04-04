part of 'add_transformer_cubit.dart';

@immutable
sealed class AddTransformerState {}

final class AddTransformerInitial extends AddTransformerState {}
final class AddTransformerLoaded extends AddTransformerState {
  final String message;
  AddTransformerLoaded(this.message);
}
final class AddTransformerError extends AddTransformerState {
  final String message;
  AddTransformerError(this.message);
}
final class AddTransformerLoading extends AddTransformerState {}
