part of 'user_accountdata_cubit.dart';

@immutable
sealed class UserAccountdataState {}

final class UserAccountdataInitial extends UserAccountdataState {}
final class UserAccountdataSuccess extends UserAccountdataState {
  final AccountResource userAccountdata;

  UserAccountdataSuccess({required this.userAccountdata});
}
final class UserAccountdataError extends UserAccountdataState {
  final String message;
  UserAccountdataError({required this.message});
}
