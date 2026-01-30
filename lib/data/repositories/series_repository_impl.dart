import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/series_info.dart';
import '../../domain/repositories/series_repository.dart';
import '../datasources/series_remote_datasource.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  final SeriesRemoteDataSource remoteDataSource;

  SeriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SeriesInfo>> getSeriesInfo(String seriesTitle) async {
    try {
      final seriesInfo = await remoteDataSource.getSeriesInfo(seriesTitle);
      return Right(seriesInfo);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
