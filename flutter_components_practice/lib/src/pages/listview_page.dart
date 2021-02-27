import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class ListviewPage extends StatefulWidget {
  @override
  _ListviewPageState createState() => _ListviewPageState();
}

class _ListviewPageState extends State<ListviewPage> {
  List<int> _imagesIndex = [];
  int _lastAddedItem = 0;
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addTen();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _addTen();
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Stack(children: [createListview(), createLoading()]),
    );
  }

  Widget createListview() {
    return RefreshIndicator(
      onRefresh: getPageOne,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          final int _image = _imagesIndex[index];
          return FadeInImage(
            image: NetworkImage('https://picsum.photos/id/$_image/500/300'),
            placeholder: AssetImage('assets/jar-loading.gif'),
          );
        },
        itemCount: _imagesIndex.length,
      ),
    );
  }

  Future<Void> getPageOne() async {
    final duration = Duration(seconds: 2);
    Timer(duration, () {
      _imagesIndex.clear();
      _lastAddedItem++;
      _addTen();
    });

    return Future.delayed(duration);
  }

  void _addTen() {
    for (var i = 0; i < 10; i++) {
      _lastAddedItem++;
      _imagesIndex.add(_lastAddedItem);
    }
    setState(() {});
  }

  Future<Null> fetchData() async {
    _isLoading = true;
    setState(() {});
    final duration = Duration(seconds: 2);
    return Timer(duration, httpResponse);
  }

  void httpResponse() {
    _isLoading = false;
    _addTen();
    _scrollController.animateTo(
      _scrollController.position.pixels + 50,
      duration: Duration(milliseconds: 250),
      curve: Curves.bounceIn,
    );
  }

  createLoading() {
    if (_isLoading) {
      return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ),
            SizedBox(
              height: 15.0,
            ),
          ]);
    } else
      return Container();
  }
}
