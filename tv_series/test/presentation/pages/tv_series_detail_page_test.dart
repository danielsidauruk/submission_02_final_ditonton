import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/annotations.dart';

import '../../../../test/dummy_data/dummy_object.dart';


class MockTVSeriesDetailBloc
    extends MockBloc<TVSeriesDetailEvent, TVSeriesDetailState>
    implements TVSeriesDetailBloc {}

class TVSeriesDetailEventFake extends Fake implements TVSeriesDetailEvent {}

class TVSeriesDetailStateFake extends Fake implements TVSeriesDetailState {}

class MockTVSeriesRecommendationBloc
    extends MockBloc<TVSeriesRecommendationEvent, TVSeriesRecommendationState>
    implements TVSeriesRecommendationBloc {}

class TVSeriesRecommendationEventFake extends Fake
    implements TVSeriesRecommendationEvent {}

class TVSeriesRecommendationStateFake extends Fake
    implements TVSeriesRecommendationState {}

class MockTVSeriesWatchlistBloc
    extends MockBloc<TVSeriesWatchlistEvent, TVSeriesWatchlistState>
    implements TVSeriesWatchlistBloc {}

class TVSeriesWatchlistEventFake extends Fake
    implements TVSeriesWatchlistEvent {}

class TVSeriesWatchlistStateFake extends Fake
    implements TVSeriesWatchlistState {}

@GenerateMocks([TVSeriesDetailBloc])
void main() {
  late MockTVSeriesDetailBloc mockTVSeriesDetailBloc;
  late MockTVSeriesRecommendationBloc mockTVSeriesRecommendationBloc;
  late MockTVSeriesWatchlistBloc mockTVSeriesWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(TVSeriesDetailEventFake());
    registerFallbackValue(TVSeriesDetailStateFake());
    registerFallbackValue(TVSeriesRecommendationEventFake());
    registerFallbackValue(TVSeriesRecommendationStateFake());
    registerFallbackValue(TVSeriesWatchlistEventFake());
    registerFallbackValue(TVSeriesWatchlistStateFake());
  });

  setUp(() {
    mockTVSeriesDetailBloc = MockTVSeriesDetailBloc();
    mockTVSeriesRecommendationBloc = MockTVSeriesRecommendationBloc();
    mockTVSeriesWatchlistBloc = MockTVSeriesWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesDetailBloc>(
            create: (context) => mockTVSeriesDetailBloc),
        BlocProvider<TVSeriesRecommendationBloc>(
            create: (context) => mockTVSeriesRecommendationBloc),
        BlocProvider<TVSeriesWatchlistBloc>(
            create: (context) => mockTVSeriesWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockTVSeriesDetailBloc.state)
            .thenReturn(TVSeriesDetailHasData(testTVSeriesDetail));
        when(() => mockTVSeriesRecommendationBloc.state)
            .thenReturn(TVSeriesRecommendationHasData(testTVSeriesList));
        when(() => mockTVSeriesWatchlistBloc.state)
            .thenReturn(const WatchlistHasData(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester
            .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when tv is added to watchlist',
          (WidgetTester tester) async {
        when(() => mockTVSeriesDetailBloc.state)
            .thenReturn(TVSeriesDetailHasData(testTVSeriesDetail));
        when(() => mockTVSeriesRecommendationBloc.state)
            .thenReturn(TVSeriesRecommendationHasData(testTVSeriesList));
        when(() => mockTVSeriesWatchlistBloc.state)
            .thenReturn(const WatchlistHasData(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester
            .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });
}
