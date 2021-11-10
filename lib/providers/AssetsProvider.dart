import 'package:achieve_takehome_test/providers/BaseProvider.dart';
import 'package:achieve_takehome_test/services/ApiService.dart';
import 'package:achieve_takehome_test/utils/network_error.dart';
import 'package:meta/meta.dart';

class AssetsProviderEvent<T> {
  final ProviderState state;
  final T data;

  const AssetsProviderEvent({
    this.data,
    @required this.state,
  });
}

class AssetsProvider extends BaseProvider<AssetsProviderEvent> {
  final ApiService _apiService;

  AssetsProvider({
    @required ApiService apiService,
  }) : _apiService = apiService;

  Future<void> fetchAssets({
    bool refresh = false,
    String search,
    int limit = 30,
    int offset,
  }) async {
    addEvent(AssetsProviderEvent(state: ProviderState.LOADING));

    try {
      /// TODO: Fetch assets from Coinbase

      addEvent(AssetsProviderEvent(state: ProviderState.SUCCESS));
    } on NetworkError catch (e) {
      addEvent(AssetsProviderEvent<NetworkError>(
        state: ProviderState.ERROR,
        data: e,
      ));
    }
  }
}
