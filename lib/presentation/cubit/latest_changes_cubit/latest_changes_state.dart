part of 'latest_changes_cubit.dart';

@immutable
sealed class LatestChangesState {}

final class LatestChangesInitial extends LatestChangesState {}
final class LatestChangesLoaded extends LatestChangesState{
  final List<TransformerModel> latestTransformers;

  LatestChangesLoaded({required this.latestTransformers});
}
final class LatestChangesError extends LatestChangesState {
  final String error;

  LatestChangesError({required this.error});
}
