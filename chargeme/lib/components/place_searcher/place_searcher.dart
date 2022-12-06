import 'dart:convert';

import 'package:chargeme/components/place_searcher/api_keys.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PlaceSearcher {
  final String _baseUrl = "search-maps.yandex.ru";
  final String _path = "v1";

  Future<List<String>> getOrganizations({
    required String text,
    String lang = "ru_RU",
    LatLngBounds? bbox,
    int results = 10,
  }) async {
    var queryParameters = {
      'text': text,
      'lang': lang,
      'results': results.toString(),
      'type': "biz",
      'apikey': yandexOrganizationsAPIKey
    };

    // format bbox
    if (bbox != null) {
      final bboxValue =
          "${bbox.southeast.longitude},${bbox.southeast.latitude}~${bbox.northwest.longitude},${bbox.northwest.latitude}";
      queryParameters["bbox"] = bboxValue;
    }

    try {
      final response = await http.get(Uri.https(_baseUrl, _path, queryParameters));
      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));

        List<dynamic> features = body["features"];
        return features.map((e) => e["properties"]["description"] as String).toList();
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }
}

extension OtherCorners on LatLngBounds {
  LatLng get southeast {
    return LatLng(southwest.latitude, northeast.longitude);
  }

  LatLng get northwest {
    return LatLng(northeast.latitude, southwest.longitude);
  }
}
