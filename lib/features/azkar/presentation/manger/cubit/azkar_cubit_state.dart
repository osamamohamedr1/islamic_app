part of 'azkar_cubit_cubit.dart';

@immutable
sealed class AzkarCubitState {}

final class AzkarCubitInitial extends AzkarCubitState {}

final class MorningAndNightAzkarLoaded extends AzkarCubitState {
  final AzkarModel azkarModel;

  MorningAndNightAzkarLoaded(this.azkarModel);
}

final class MorningAndNightAzkarError extends AzkarCubitState {
  final String message;

  MorningAndNightAzkarError(this.message);
}

final class MorningAndNightAzkarLoading extends AzkarCubitState {}

final class AllDuaoaded extends AzkarCubitState {
  final AzkarModel azkarModel;

  AllDuaoaded(this.azkarModel);
}

final class SleepAkarLoaded extends AzkarCubitState {
  final AzkarModel azkarModel;

  SleepAkarLoaded(this.azkarModel);
}

final class DifferentAzkarCollectionLoaded extends AzkarCubitState {
  final List<AzkarModel> azkarCollection;

  DifferentAzkarCollectionLoaded(this.azkarCollection);
}

final class DifferentAzkarDetailsLoaded extends AzkarCubitState {
  final AzkarModel azkarModel;

  DifferentAzkarDetailsLoaded(this.azkarModel);
}
