import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationBloc(this._getMovieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<FetchMovieRecommendation>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationLoading());

      final recommendationResult = await _getMovieRecommendations.execute(id);

      recommendationResult.fold(
        (failure) => emit(MovieRecommendationError(failure.message)),
        (data) => emit(MovieRecommendationHasData(data)),
      );
    });
  }
}
