import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class TVSeriesDetailPage extends StatefulWidget {
  final int id;

  const TVSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TVSeriesDetailBloc>(context, listen: false)
          .add(FetchTVSeriesDetail(widget.id));
      BlocProvider.of<TVSeriesWatchlistBloc>(context, listen: false)
          .add(LoadWatchlistTVSeriesStatus(widget.id));
      BlocProvider.of<TVSeriesRecommendationBloc>(context, listen: false)
          .add(FetchTVSeriesRecommendation(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVSeriesDetailBloc, TVSeriesDetailState>(
        builder: (context, state) {
          if (state is TVSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVSeriesDetailHasData) {
            final tvSeriesDetail = state.result;
            return SafeArea(
              child: DetailContent(detail: tvSeriesDetail),
            );
          } else if (state is TVSeriesDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVSeriesDetail detail;

  const DetailContent({Key? key, required this.detail,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${detail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detail.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<TVSeriesWatchlistBloc,
                                TVSeriesWatchlistState>(
                              listener: (context, state) {
                                if (state is WatchlistSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                } else if (state is WatchlistFailure) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    },
                                  );
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (state is WatchlistHasData) {
                                      if (state.isAdded == false) {
                                        context
                                            .read<TVSeriesWatchlistBloc>()
                                            .add(AddWatchlistTVSeries(detail));
                                      } else if (state.isAdded == true) {
                                        context
                                            .read<TVSeriesWatchlistBloc>()
                                            .add(DeleteWatchlistTVSeries(
                                                detail));
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (state is WatchlistHasData)
                                        if (state.isAdded == false)
                                          const Icon(Icons.add)
                                        else if (state.isAdded == true)
                                          const Icon(Icons.check),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(detail.genres),
                            ),
                            IntrinsicHeight(
                              child: Row(children: [
                                Text(_showNumberOfSeasons(
                                    detail.numberOfSeasons)),
                                const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  _showDuration(detail.episodeRunTime[0]),
                                ),
                              ]),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: detail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${detail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              detail.overview,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Total ${_episode(detail.numberOfEpisodes)}",
                                      style: kHeading5,
                                    ),
                                    Text(
                                      (detail.numberOfEpisodes).toString(),
                                      style: kHeading5,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Total ${_season(detail.numberOfSeasons)}",
                                      style: kHeading6,
                                    ),
                                    Text(
                                      (detail.numberOfSeasons).toString(),
                                      style: kHeading5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              itemBuilder: (context, index) {
                                final season = detail.seasons[index];
                                return SeasonCard(item: season);
                                },
                              shrinkWrap: true,
                              itemCount: detail.seasons.length,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVSeriesRecommendationBloc,
                                TVSeriesRecommendationState>(
                              builder: (context, state) {
                                if (state is TVSeriesRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TVSeriesRecommendationError) {
                                  return Text(state.message);
                                } else if (state
                                    is TVSeriesRecommendationHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final recommendations =
                                            state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                detailTVSeriesRoute,
                                                arguments: recommendations.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${recommendations.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _showNumberOfSeasons(int total) {
    return '$total ${total > 1 ? 'seasons' : 'season'}';
  }

  String _season(int season){
    return season > 1 ? 'seasons' : 'season';
  }

  String _episode(int episode){
    return episode > 1 ? 'episodes' : 'episode';
  }
}
