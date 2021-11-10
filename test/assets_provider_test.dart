import 'package:achieve_takehome_test/providers/AssetsProvider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AssetsProvider assetProvider;

  setUp(() {
    /// TODO: Initialize `assetProvider`;
  });

  group("#Test AssetsProvider", () {
    test(':fetchAssets should work', () {
      /// TODO: In Addition, test that events are emitted
      /// in the expected order
      /// eg:
      /// -> AssetsProviderEvent(state: ProviderState.LOADING)
      /// -> AssetsProviderEvent(state: ProviderState.SUCCESS)
    });

    test(':fetchAssets should fail', () {});
  });
}
