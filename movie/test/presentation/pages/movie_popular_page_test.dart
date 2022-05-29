import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

import '../../../../test/dummy_data/dummy_object.dart';

class MockMoviePopularBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

class MoviePopularEventFake extends Fake implements MoviePopularEvent {}

class MoviePopularStateFake extends Fake implements MoviePopularState {}

@GenerateMocks([MoviePopularBloc])
void main() {
  late MockMoviePopularBloc mockMoviePopularBloc;

  setUpAll(() {
    registerFallbackValue(MoviePopularEventFake());
    registerFallbackValue(MoviePopularStateFake());
  });

  setUp(() {
    mockMoviePopularBloc = MockMoviePopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>.value(
      value: mockMoviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockMoviePopularBloc.state).thenReturn(MoviePopularLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockMoviePopularBloc.state)
            .thenReturn(MoviePopularHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockMoviePopularBloc.state)
            .thenReturn(const MoviePopularError('Error Message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
}
