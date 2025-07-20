part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<AzkarArray> favorites;

  FavoriteLoaded(this.favorites);
}
