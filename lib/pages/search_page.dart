import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Container(
            height: 40,
            child: SearchBar(
              hintText: "Search",
              hintStyle: Theme.of(context).searchBarTheme.hintStyle,
              leading: const Icon(Icons.search),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: Theme.of(context).searchBarTheme.backgroundColor,
            ),
          )),
      body: Center(child: Text('Search')),
    );
  }
}
