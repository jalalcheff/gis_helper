part of 'signout_cubit.dart';

@immutable
sealed class SignoutState {}

final class SignoutInitial extends SignoutState {}
final class SignoutSuccess extends SignoutState {
  final String message;

  SignoutSuccess({required this.message});
}
final class SignoutError extends SignoutState {
  final String message;

  SignoutError({required this.message});
}
