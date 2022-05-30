import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../test/dummy_data/dummy_object.dart';
import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesRecommendations])
void main() {
  late TVSeriesRecommendationBloc tvSeriesRecommendationBloc;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendation;

  setUp(() {
    mockGetTVSeriesRecommendation = MockGetTVSeriesRecommendations();
    tvSeriesRecommendationBloc =
        TVSeriesRecommendationBloc(mockGetTVSeriesRecommendation);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(tvSeriesRecommendationBloc.state, TVSeriesRecommendationEmpty());
  });

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
    'Should emit [TVSeriesRecommendationLoading, TVSeriesRecommendationHasData]  when recommendation data is gotten successfully',
    build: () {
      when(mockGetTVSeriesRecommendation.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchTVSeriesRecommendation(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TVSeriesRecommendationLoading(),
      TVSeriesRecommendationHasData(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTVSeriesRecommendation.execute(tId));
    },
  );

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
    'Should emit [TVSeriesRecommendationLoading, TVSeriesRecommendationError] when recommendation data is gotten unsuccessfully',
    build: () {
      when(mockGetTVSeriesRecommendation.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchTVSeriesRecommendation(tId)),
    expect: () => [
      TVSeriesRecommendationLoading(),
      const TVSeriesRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVSeriesRecommendation.execute(tId));
    },
  );
}
