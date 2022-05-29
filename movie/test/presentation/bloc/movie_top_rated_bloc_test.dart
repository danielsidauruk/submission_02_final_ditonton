import 'package:flutter_test/flutter_test.dart';
import 'movie_top_rated_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import '../../../../test/dummy_data/dummy_object.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  test('initial should be Empty', () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [MovieTopRatedLoading, MovieTopRatedHasData] when get top rated movie data is successful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchMovieTopRated()),
      expect: () => [
        MovieTopRatedLoading(),
        MovieTopRatedHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [MovieTopRatedLoading, MovieTopRatedError] when get top rated movie data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchMovieTopRated()),
      expect: () => [
        MovieTopRatedLoading(),
        const MovieTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
