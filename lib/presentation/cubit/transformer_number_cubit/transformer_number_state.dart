part of 'transformer_number_cubit.dart';

@immutable
sealed class TransformerNumberState {}

final class TransformerNumberInitial extends TransformerNumberState {}
final class TransformerNumberLoading extends TransformerNumberState {}
final class TransformerNumberLoaded extends TransformerNumberState {
  final int transformerNumber;
  TransformerNumberLoaded({required this.transformerNumber});
}
final class TransformerNumberError extends TransformerNumberState {
  final String error;

  TransformerNumberError({required this.error});
}
