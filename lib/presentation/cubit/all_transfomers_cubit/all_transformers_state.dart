part of 'all_transformers_cubit.dart';

@immutable
sealed class AllTransformersState {}

final class AllTransformersInitial extends AllTransformersState {}
final class AllTransformersLoaded extends AllTransformersState {
  final List<TransformerModel> transformers;

  AllTransformersLoaded({required this.transformers});
}
final class AllTransformersError extends AllTransformersState {
  final String error;
  AllTransformersError({required this.error});
}
