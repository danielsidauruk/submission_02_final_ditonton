import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

class MockMovieWatchlistBloc extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class MovieWatchlistEventFake extends Fake implements MovieWatchlistEvent {}

class MovieWatchlistStateFake extends Fake implements MovieWatchlistState {}

@GenerateMocks([MovieWatchlistBloc])
void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  setUpAll(() {
    registerFallbackValue(MovieWatchlistEventFake());
    registerFallbackValue(MovieWatchlistStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieWatchlistBloc>.value(
      value: mockMovieWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.state).thenReturn(MovieWatchlistLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.state).thenReturn(const MovieWatchlistHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.state).thenReturn(const MovieWatchlistError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
