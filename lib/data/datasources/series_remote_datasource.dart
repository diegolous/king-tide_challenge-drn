import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/series_info_model.dart';

abstract class SeriesRemoteDataSource {
  Future<SeriesInfoModel> getSeriesInfo(String seriesTitle);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  final http.Client client;

  SeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<SeriesInfoModel> getSeriesInfo(String seriesTitle) async {
    final url = ApiConstants.getOmdbSeriesUrl(seriesTitle);

    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      // Check if OMDB returned an error
      if (jsonResponse['Response'] == 'False') {
        throw ServerException(jsonResponse['Error'] ?? 'Unknown error');
      }

      return SeriesInfoModel.fromJson(jsonResponse);
    } else {
      throw ServerException('Failed to fetch series info');
    }
  }
}
