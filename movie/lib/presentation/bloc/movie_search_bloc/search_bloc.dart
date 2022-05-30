import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchMoviesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) => emit(SearchError(failure.message)),
        (data) => emit(SearchHasData(data))
      );
      }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
