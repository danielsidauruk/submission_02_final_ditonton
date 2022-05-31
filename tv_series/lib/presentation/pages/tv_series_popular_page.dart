import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';

class TVSeriesPopularPage extends StatefulWidget {
  const TVSeriesPopularPage({Key? key}) : super(key: key);

  @override
  State<TVSeriesPopularPage> createState() => _TVSeriesPopularPageState();
}

class _TVSeriesPopularPageState extends State<TVSeriesPopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TVSeriesPopularBloc>(context, listen: false)
            .add(FetchTVSeriesPopular()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVSeriesPopularBloc, TVSeriesPopularState>(
          builder: (context, state) {
            if (state is TVSeriesPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TVSeriesPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final popularTVSeries = state.result[index];
                  return TVSeriesCard(item: popularTVSeries);
                },
                itemCount: state.result.length,
              );
            } else if (state is TVSeriesPopularError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
