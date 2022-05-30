import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

class MockTVSeriesWatchlistBloc
    extends MockBloc<TVSeriesWatchlistEvent, TVSeriesWatchlistState>
    implements TVSeriesWatchlistBloc {}

class TVSeriesWatchlistEventFake extends Fake
    implements TVSeriesWatchlistEvent {}

class TVSeriesWatchlistStateFake extends Fake
    implements TVSeriesWatchlistState {}

@GenerateMocks([TVSeriesWatchlistBloc])
void main() {
  late MockTVSeriesWatchlistBloc mockTVSeriesWatchlistBloc;

  setUp(() {
    mockTVSeriesWatchlistBloc = MockTVSeriesWatchlistBloc();
  });

  setUpAll(() {
    registerFallbackValue(TVSeriesWatchlistEventFake());
    registerFallbackValue(TVSeriesWatchlistStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesWatchlistBloc>.value(
      value: mockTVSeriesWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTVSeriesWatchlistBloc.state)
        .thenReturn(TVSeriesWatchlistLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesWatchlistPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTVSeriesWatchlistBloc.state)
        .thenReturn(const TVSeriesWatchlistHasData(<TVSeries>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesWatchlistPage()));

    expect(listViewFinder, findsOneWidget);
  });
  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTVSeriesWatchlistBloc.state)
        .thenReturn(const TVSeriesWatchlistError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesWatchlistPage()));

    expect(textFinder, findsOneWidget);
  });
}
