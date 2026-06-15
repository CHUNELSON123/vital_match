import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;

  ApiClient({
    required this.client,
  });
}