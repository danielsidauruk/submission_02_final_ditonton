import 'movie_recommendation_bloc_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import '../../../../test/dummy_data/dummy_object.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendation;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    movieRecommendationBloc =
        MovieRecommendationBloc(mockGetMovieRecommendation);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [MovieRecommendationLoading, MovieRecommendationHasData]  when recommendation data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(tId));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [MovieRecommendationLoading, MovieRecommendationError] when recommendation data is gotten unsuccessfully',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(tId));
    },
  );
}
