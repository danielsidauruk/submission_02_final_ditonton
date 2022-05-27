import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late TVSeriesTopRatedBloc tvSeriesTopRatedBloc;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    tvSeriesTopRatedBloc = TVSeriesTopRatedBloc(mockGetTopRatedTVSeries);
  });

  test('initial should be Empty', () {
    expect(tvSeriesTopRatedBloc.state, TVSeriesTopRatedEmpty());
  });

  group('Now Playing TVSeries', () {
    blocTest<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
      'Should emit [TVSeriesTopRatedLoading, TVSeriesTopRatedHasData] when get top rated tv data is successful',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTVSeriesTopRated()),
      expect: () => [
        TVSeriesTopRatedLoading(),
        TVSeriesTopRatedHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      },
    );

    blocTest<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
      'Should emit [TVSeriesTopRatedLoading, TVSeriesTopRatedError] when get top rated tv data is unsuccessful',
      build: () {
        when(mockGetTopRatedTVSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTVSeriesTopRated()),
      expect: () => [
        TVSeriesTopRatedLoading(),
        const TVSeriesTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      },
    );
  });
}
