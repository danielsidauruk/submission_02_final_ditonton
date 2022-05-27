import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_series_on_air_bloc_test.mocks.dart';

@GenerateMocks([GetOnAirTVSeries])
void main() {
  late MockGetOnAirTVSeries mockGetOnAirTVSeries;
  late TVSeriesOnAirBloc tvSeriesOnAirBloc;

  setUp(() {
    mockGetOnAirTVSeries = MockGetOnAirTVSeries();
    tvSeriesOnAirBloc = TVSeriesOnAirBloc(mockGetOnAirTVSeries);
  });

  test('initial should be Empty', () {
    expect(tvSeriesOnAirBloc.state, TVSeriesOnAirEmpty());
  });

  group('Now Playing TVSeries', () {
    blocTest<TVSeriesOnAirBloc, TVSeriesOnAirState>(
      'Should emit [TVSeriesOnAirLoading, TVSeriesOnAirHasData] when get now playing tv data is successful',
      build: () {
        when(mockGetOnAirTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return tvSeriesOnAirBloc;
      },
      act: (bloc) => bloc.add(FetchTVSeriesOnAir()),
      expect: () => [
        TVSeriesOnAirLoading(),
        TVSeriesOnAirHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetOnAirTVSeries.execute());
      },
    );

    blocTest<TVSeriesOnAirBloc, TVSeriesOnAirState>(
      'Should emit [TVSeriesOnAirLoading, TVSeriesOnAirError] when get now playing tv data is unsuccessful',
      build: () {
        when(mockGetOnAirTVSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesOnAirBloc;
      },
      act: (bloc) => bloc.add(FetchTVSeriesOnAir()),
      expect: () => [
        TVSeriesOnAirLoading(),
        const TVSeriesOnAirError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnAirTVSeries.execute());
      },
    );
  });
}
