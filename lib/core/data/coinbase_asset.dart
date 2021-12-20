/// TODO: Complete the [CoinCapAsset] class
/// and also implement methods for converting to and from JSON.
///
/// You are free to use any helper package
class CoinCapAsset {
  final String name;
  final double priceUsd;
  final double marketCapUsd;

  CoinCapAsset({this.name, this.priceUsd, this.marketCapUsd});
  factory CoinCapAsset.fromJson(Map<String, dynamic> json) {
    return CoinCapAsset(
      name: json['name'],
      priceUsd:json['priceUsd'],
      marketCapUsd:json['marketCapUsd'],


    );
  }
}
