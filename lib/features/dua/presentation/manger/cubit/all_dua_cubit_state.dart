part of 'all_dua_cubit_cubit.dart';

@immutable
sealed class AllDuaCubitState {}

final class AllDuaCubitInitial extends AllDuaCubitState {}

final class AllDuaCubitLoaded extends AllDuaCubitState {
  final AzkarModel azkarModel;

  AllDuaCubitLoaded(this.azkarModel);
}

final class AllDuaCubitError extends AllDuaCubitState {
  final String message;

  AllDuaCubitError(this.message);
}

final class AllDuaCubitLoading extends AllDuaCubitState {}
