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
    final url = 'https://api.coincap.io/v2/assets',
    bool refresh = false,
    String search,
    int limit = 30,
    int offset,
  }) async {
    addEvent(AssetsProviderEvent(state: ProviderState.LOADING));

    try {
      /// TODO: Fetch assets from Coinbase

      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse == null) {
          return;
        }

        List<Data> loadedData = [];
        for (var u in jsonResponse) {
          Data btcData = Data(
            name:u['name'],
            priceUsd:u['priceUsd'],
            marketCapUsd:u['marketCapUsd'],
          );
          loadedData.add(btcData);
        }
        print("hello");

        return loadedData;
      }

      // addEvent(AssetsProviderEvent(state: ProviderState.SUCCESS));
    } on NetworkError catch (e) {
      addEvent(AssetsProviderEvent<NetworkError>(
        state: ProviderState.ERROR,
        data: e,
      ));
    }
  }
}
