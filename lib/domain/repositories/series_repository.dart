import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/series_info.dart';

abstract class SeriesRepository {
  Future<Either<Failure, SeriesInfo>> getSeriesInfo(String seriesTitle);
}
