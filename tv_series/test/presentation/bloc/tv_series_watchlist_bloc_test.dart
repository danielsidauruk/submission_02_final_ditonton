import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../test/dummy_data/dummy_object.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTVSeries,
  GetWatchlistTVSeriesStatus,
  SaveWatchlistTVSeries,
  RemoveWatchlistTVSeries
])
void main() {
  late TVSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;
  late MockGetWatchListTVSeriesStatus mockGetWatchlistTVSeriesStatus;
  late MockSaveTVSeriesWatchlist mockSaveWatchlistTVSeries;
  late MockRemoveTVSeriesWatchlist mockRemoveWatchlistTVSeries;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    mockGetWatchlistTVSeriesStatus = MockGetWatchListTVSeriesStatus();
    mockSaveWatchlistTVSeries = MockSaveTVSeriesWatchlist();
    mockRemoveWatchlistTVSeries = MockRemoveTVSeriesWatchlist();
    tvSeriesWatchlistBloc = TVSeriesWatchlistBloc(
        mockGetWatchlistTVSeries,
        mockGetWatchlistTVSeriesStatus,
        mockSaveWatchlistTVSeries,
        mockRemoveWatchlistTVSeries);
  });

  test('initial state should be empty', () {
    expect(tvSeriesWatchlistBloc.state, TVSeriesWatchlistEmpty());
  });

  blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
    'Should emit [TVSeriesWatchlistLoading, TVSeriesWatchlistHasData]  when detail data is gotten successfully',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTVSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TVSeriesWatchlistLoading(),
      TVSeriesWatchlistHasData(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );

  blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
    'Should emit [TVSeriesWatchlistLoading, TVSeriesWatchlistError] when detail data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTVSeries()),
    expect: () => [
      TVSeriesWatchlistLoading(),
      const TVSeriesWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );
}
