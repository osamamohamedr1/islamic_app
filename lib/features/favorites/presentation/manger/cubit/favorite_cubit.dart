import 'package:bloc/bloc.dart';
import 'package:islamic_app/core/models/azkar_model/array.dart';
import 'package:islamic_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepo) : super(FavoriteInitial());
  final FavoriteRepo favoriteRepo;

  void getFavorites() async {
    final favorites = await favoriteRepo.getAllFavoriteDuas();
    emit(FavoriteLoaded(favorites));
  }
}
