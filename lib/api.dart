import 'dart:convert';
import 'dart:io';

const Map<String, String> apiCategory = {
  'name': 'Currency',
  'route': 'currency',
};

class Api {
  final HttpClient _httpClient = HttpClient();

  final String _host = 'flutter.udacity.com';

  ///
  /// response json example:
  /// ```
  /// {
  ///   units: [
  ///     {
  ///       name: "US Dollar",
  ///       conversion: 1,
  ///       description: "It is a little-known fact that the production cost
  ///                     of each item in the Dollar Menu is the true driver
  ///                     for the fluctuations in the US Dollar."
  ///     },
  ///     {
  ///       name: "Brownie Points",
  ///       conversion: 0.9037143852380408,
  ///       description: "While not a "monetary" currency,
  ///                     Brownie Points are a form of social currency
  ///                     that include doing favors and helping others."
  ///     },
  ///   ]
  /// }
  /// ```
  Future<List> getUnits(String category) async {
    final uri = Uri.https(_host, '/$category');
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['units'] == null) {
      print('Error retrieving units.');
      return null;
    }
    return jsonResponse['units'];
  }

  /// response json example:
  /// ```
  /// {
  ///   status: "ok",
  ///   conversion: 0.4044796662470448
  /// }
  /// ```
  Future<double> convert(
    String category,
    String amount,
    String fromUnitName,
    String toUnitName,
  ) async {
    final uri = Uri.http(
      _host,
      '/$category/convert',
      {
        'amount': amount,
        'from': fromUnitName,
        'to': toUnitName,
      },
    );
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['status'] == null) {
      print('Error retrieving conversion.');
      return null;
    } else if (jsonResponse['status'] == 'error') {
      print(jsonResponse['message']);
      return null;
    }

    return jsonResponse['conversion'].toDouble();
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}
