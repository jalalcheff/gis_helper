part of 'search_for_transformer_cubit.dart';

@immutable
sealed class SearchForTransformerState {}

final class SearchForTransformerInitial extends SearchForTransformerState {}
final class SearchForTransformerLoading extends SearchForTransformerState {}
final class SearchForTransformerLoaded extends SearchForTransformerState {
  final List<TransformerResource> transformers;

  SearchForTransformerLoaded({required this.transformers});
}
final class SearchForTransformerError extends SearchForTransformerState {
  final String error;

  SearchForTransformerError({required this.error});
}
