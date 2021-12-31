import 'dart:async';

import 'package:achieve_takehome_test/core/data/coinbase_asset.dart';
import 'package:achieve_takehome_test/providers/AssetsProvider.dart';
import 'package:achieve_takehome_test/providers/BaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssetsPage extends StatefulWidget {
  @override
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final _searchTextEditingController = TextEditingController();

  Timer _searchDebounce;
  AssetsProvider _assetsProvider;

  void onSearchQueryChanged(String search) {}

  void didBuild(BuildContext context) {
    _assetsProvider.fetchAssets();
  }

  //Future<Data> _newData;
  @override
  void initState() {
    super.initState();
    // _newData = _assetsProvider.fetchAssets();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      didBuild(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    final _isLight = _themeData.brightness == Brightness.light;
    _assetsProvider = Provider.of<AssetsProvider>(context, listen: false);

    return FutureBuilder(
      future: _assetsProvider.fetchAssets(),
      builder: (context, snapshot) {
        final _isLoading = snapshot.data?.state == ProviderState.LOADING;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            actions: [
              if (_isLoading)
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: ValueListenableBuilder(
                valueListenable: _searchTextEditingController,
                builder: (context, textVal, _) {
                  final _text = textVal.text;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          controller: _searchTextEditingController,
                          onChanged: onSearchQueryChanged,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Searching for a asset?',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            fillColor: _isLight ? Colors.grey[200] : null,
                            prefixIcon:
                                _text.isEmpty ? Icon(Icons.search) : null,
                            suffixIcon: _text.isNotEmpty
                                ? GestureDetector(
                                    child: Icon(Icons.close),
                                    onTap: () {
                                      onSearchQueryChanged(null);
                                      _searchTextEditingController.clear();
                                    },
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
            title: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset('assets/img/coin-cap.png'),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return _assetsProvider.fetchAssets(refresh: true);
            },
            child: Builder(
              // ignore: missing_return
              builder: (context) {
                if (snapshot.hasData) {
                 
                  ListView.builder(
                      itemCount: snapshot.data.lenght,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text("${snapshot.data[i].name}"),
                          subtitle: Text("${snapshot.data[i].priceUsd}"),
                          trailing: Text("${snapshot.data[i].marketCapUsd}"),
                        );
                      });
                  
                  
                } else {
                  return Center(child: CircularProgressIndicator());
                }

                /// TODO: Rework this to show fetched Assets
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }
}
