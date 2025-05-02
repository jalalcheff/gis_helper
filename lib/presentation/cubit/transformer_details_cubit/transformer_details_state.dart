part of 'transformer_details_cubit.dart';

@immutable
sealed class TransformerDetailsState {}

final class TransformerDetailsInitial extends TransformerDetailsState {}
final class TransformerDetailsLoading extends TransformerDetailsState {}
final class TransformerDetailsLoaded extends TransformerDetailsState {
  final TransformerResource transformer;

  TransformerDetailsLoaded({required this.transformer});
}
final class TransformerDetailsError extends TransformerDetailsState {
  final String error;

  TransformerDetailsError({required this.error});
}
