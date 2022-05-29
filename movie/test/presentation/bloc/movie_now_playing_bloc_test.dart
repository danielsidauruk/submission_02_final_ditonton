import 'package:flutter_test/flutter_test.dart';
import 'movie_now_playing_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import '../../../../test/dummy_data/dummy_object.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('initial should be Empty', () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [MovieNowPlayingLoading, MovieNowPlayingHasData] when get now playing movie data is successful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchMovieNowPlaying()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [MovieNowPlayingLoading, MovieNowPlayingError] when get now playing movie data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchMovieNowPlaying()),
      expect: () => [
        MovieNowPlayingLoading(),
        const MovieNowPlayingError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
