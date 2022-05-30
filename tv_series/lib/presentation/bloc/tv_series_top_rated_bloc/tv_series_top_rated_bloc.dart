import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc/bloc.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TVSeriesTopRatedBloc
    extends Bloc<TVSeriesTopRatedEvent, TVSeriesTopRatedState> {
  final GetTopRatedTVSeries _getTopRatedTVSeries;

  TVSeriesTopRatedBloc(this._getTopRatedTVSeries)
      : super(TVSeriesTopRatedEmpty()) {
    on<FetchTVSeriesTopRated>(
      (event, emit) async {
        emit(TVSeriesTopRatedLoading());

        final topRatedResult = await _getTopRatedTVSeries.execute();

        topRatedResult.fold(
            (failure) => emit(TVSeriesTopRatedError(failure.message)),
            (data) => emit(TVSeriesTopRatedHasData(data)));
      },
    );
  }
}
