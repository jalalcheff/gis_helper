part of 'delete_transformer_cubit.dart';

@immutable
sealed class DeleteTransformerState {}

final class DeleteTransformerInitial extends DeleteTransformerState {}
final class DeleteTransformerLoading extends DeleteTransformerState {}
final class DeleteTransformerSuccess extends DeleteTransformerState {
  final String message;

  DeleteTransformerSuccess({required this.message});
}
final class DeleteTransformerError extends DeleteTransformerState {
  final String error;

  DeleteTransformerError({required this.error});
}
