part of 'update_all_transformers_cubit.dart';

@immutable
sealed class UpdateAllTransformersState {}

final class UpdateAllTransformersInitial extends UpdateAllTransformersState {}
final class UpdateAllTransformersLoaded extends UpdateAllTransformersState {
  final List<TransformerModel> transformers;

  UpdateAllTransformersLoaded({required this.transformers});
}
final class UpdateAllTransformerError extends UpdateAllTransformersState {
  final String error;
  UpdateAllTransformerError({required this.error});
}