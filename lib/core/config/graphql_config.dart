import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink? _httpLink;
  static GraphQLClient? _client;

  static HttpLink get httpLink {
    _httpLink ??= HttpLink(
      // GraphQL endpoint is at root /graphql, not /api/graphql
      'https://futuramaapi.com/graphql',
    );
    return _httpLink!;
  }

  static GraphQLClient get client {
    _client ??= GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
    return _client!;
  }

  static void reset() {
    _httpLink = null;
    _client = null;
  }
}
