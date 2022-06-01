import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies)
      : super(MovieNowPlayingEmpty()) {
    on<FetchMovieNowPlaying>(
      (event, emit) async {
        emit(MovieNowPlayingLoading());

        final nowPlayingResult = await _getNowPlayingMovies.execute();

        nowPlayingResult.fold(
            (failure) => emit(MovieNowPlayingError(failure.message)),
            (data) => emit(MovieNowPlayingHasData(data)));
      },
    );
  }
}
