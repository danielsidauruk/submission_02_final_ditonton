import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class SearchTVSeriesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTVSeries _searchTVSeries;

  SearchTVSeriesBloc(this._searchTVSeries) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final searchResult = await _searchTVSeries.execute(query);

      searchResult.fold((failure) => emit(SearchError(failure.message)),
          (data) => emit(SearchHasData(data)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
