import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../test/dummy_data/dummy_object.dart';
import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late TVSeriesPopularBloc tvSeriesPopularBloc;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    tvSeriesPopularBloc = TVSeriesPopularBloc(mockGetPopularTVSeries);
  });

  test('initial should be Empty', () {
    expect(tvSeriesPopularBloc.state, TVSeriesPopularEmpty());
  });

  group('Now Playing TVSeries', () {
    blocTest<TVSeriesPopularBloc, TVSeriesPopularState>(
      'Should emit [TVSeriesPopularLoading, TVSeriesPopularHasData] when get popular tv data is successful',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(FetchTVSeriesPopular()),
      expect: () => [
        TVSeriesPopularLoading(),
        TVSeriesPopularHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      },
    );

    blocTest<TVSeriesPopularBloc, TVSeriesPopularState>(
      'Should emit [TVSeriesPopularLoading, TVSeriesPopularError] when get popular tv data is unsuccessful',
      build: () {
        when(mockGetPopularTVSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(FetchTVSeriesPopular()),
      expect: () => [
        TVSeriesPopularLoading(),
        const TVSeriesPopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      },
    );
  });
}
