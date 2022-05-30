import 'package:tv_series/tv_series.dart';

class GetWatchlistTVSeriesStatus {
  final TVSeriesRepository repository;

  GetWatchlistTVSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
