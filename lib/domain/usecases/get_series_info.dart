import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/series_info.dart';
import '../repositories/series_repository.dart';

class GetSeriesInfo {
  final SeriesRepository repository;

  GetSeriesInfo(this.repository);

  Future<Either<Failure, SeriesInfo>> call(String seriesTitle) async {
    return await repository.getSeriesInfo(seriesTitle);
  }
}
