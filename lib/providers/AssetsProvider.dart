import 'dart:convert';

import 'package:achieve_takehome_test/providers/BaseProvider.dart';
import 'package:achieve_takehome_test/services/ApiService.dart';
import 'package:achieve_takehome_test/core/data/coinbase_asset.dart';
import 'package:achieve_takehome_test/utils/network_error.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class AssetsProviderEvent<T> {
  final ProviderState state;
  final T data;

  const AssetsProviderEvent({
    this.data,
    @required this.state,
  });

  get length => null;
}

class AssetsProvider extends BaseProvider<AssetsProviderEvent> {
  final ApiService _apiService;

  AssetsProvider({
    @required ApiService apiService,
  }) : _apiService = apiService;

  Future<void> fetchAssets({
    final url = 'api.coincap.io/v2/assets',
    bool refresh = false,
    String search,
    int limit = 30,
    int offset,
  }) async {
    addEvent(AssetsProviderEvent(state: ProviderState.LOADING));

    try {
      /// TODO: Fetch assets from Coinbase
      ///
      //http.get(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var jsonMap = json.decode(jsonResponse);

        var coinCapAsset = Data.fromJson(jsonMap);
        return coinCapAsset;
      } else {
        throw Exception('Unexpected error occured');
      }

      // ignore: dead_code
      addEvent(AssetsProviderEvent(state: ProviderState.SUCCESS));
      notifyListeners();
      //return coinCapAsset;
    } on NetworkError catch (e) {
      addEvent(AssetsProviderEvent<NetworkError>(
        state: ProviderState.ERROR,
        data: e,
      ));
    }
  }
}
