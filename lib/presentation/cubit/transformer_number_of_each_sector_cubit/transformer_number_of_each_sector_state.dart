part of 'transformer_number_of_each_sector_cubit.dart';

@immutable
sealed class TransformerNumberOfEachSectorState {}

final class TransformerNumberOfEachSectorInitial extends TransformerNumberOfEachSectorState {}
final class TransformerNumberOfEachSectorLoading extends TransformerNumberOfEachSectorState {}
final class TransformerNumberOfEachSectorLoaded extends TransformerNumberOfEachSectorState{
  final List<Map<String,dynamic>> transformers;

  TransformerNumberOfEachSectorLoaded({required this.transformers});
}
final class TransformerNumberOfEachSectorError extends TransformerNumberOfEachSectorState{
  final String error;

  TransformerNumberOfEachSectorError({required this.error});
}
