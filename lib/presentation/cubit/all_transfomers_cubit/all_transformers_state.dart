part of 'all_transformers_cubit.dart';

@immutable
sealed class AllTransformersState {}

final class AllTransformersInitial extends AllTransformersState {}
final class AllTransformersLoaded extends AllTransformersState {
  final List<TransformerResource> transformers;

  AllTransformersLoaded({required this.transformers});
}
