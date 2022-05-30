import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie/movie.dart';
import 'package:bloc/bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());
      final detailResult = await _getMovieDetail.execute(id);

      detailResult.fold(
              (failure) => emit(MovieDetailError(failure.message)),
              (data) => emit(MovieDetailHasData(data)));
      },
    );
  }
}