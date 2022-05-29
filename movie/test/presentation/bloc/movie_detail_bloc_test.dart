import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import 'movie_detail_bloc_test.mocks.dart';
import '../../../../test/dummy_data/dummy_object.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [MovieDetailLoading, MovieDetailHasData]  when detail data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [MovieDetailLoading, MovieDetailError] when detail data is gotten unsuccessfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}
