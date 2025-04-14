part of 'feeders_number_cubit.dart';

@immutable
sealed class FeedersNumberState {}

final class FeedersNumberInitial extends FeedersNumberState {}
final class FeedersNumberLoading extends FeedersNumberState {}
final class FeedersNumberLoaded extends FeedersNumberState {
  final int feedersNumber;

  FeedersNumberLoaded({required this.feedersNumber});
}
final class FeedersNumberError extends FeedersNumberState {
  final String error;

  FeedersNumberError({required this.error});
}
