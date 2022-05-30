import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc/bloc.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TVSeriesPopularBloc
    extends Bloc<TVSeriesPopularEvent, TVSeriesPopularState> {
  final GetPopularTVSeries _getPopGetPopularTVSeries;

  TVSeriesPopularBloc(this._getPopGetPopularTVSeries)
      : super(TVSeriesPopularEmpty()) {
    on<FetchTVSeriesPopular>(
      (event, emit) async {
        emit(TVSeriesPopularLoading());

        final popularResult = await _getPopGetPopularTVSeries.execute();

        popularResult.fold(
            (failure) => emit(TVSeriesPopularError(failure.message)),
            (data) => emit(TVSeriesPopularHasData(data)));
      },
    );
  }
}
