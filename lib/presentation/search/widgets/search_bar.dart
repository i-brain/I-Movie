import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:i_movie/bloc/search/search_movie_cubit.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  CustomSearchDelegate({
    required this.cubit,
  });
  final SearchMovieCubit cubit;

  var box = Hive.box('search');

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      handleSuggestions();
      cubit.searchMovie(query);
      close(context, query);
    });

    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> listToShow;
    List<String> suggestionList = box.get('list').cast<String>();
    if (query.isNotEmpty) {
      listToShow = suggestionList
          .where((e) => e.contains(query) && e.startsWith(query))
          .toList();
    } else {
      listToShow = suggestionList;
    }

    return ListView.builder(
      itemCount: listToShow.length,
      itemBuilder: (_, i) {
        var list = listToShow.reversed;
        var noun = list.elementAt(i);
        return ListTile(
          title: Text(
            noun,
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            List<dynamic> list = box.get('list');

            list.remove(noun);

            list.add(noun);
            cubit.searchMovie(noun);
            close(context, noun);
          },
        );
      },
    );
  }

  void handleSuggestions() {
    if (box.containsKey('list')) {
      List<dynamic> list = box.get('list');
      if (list.contains(query)) {
        list.remove(query);
      }
      if (list.length > 4) {
        list.removeAt(0);
      }
      list.add(query);
      box.put('list', list);
    } else {
      box.put('list', [query]);
    }
  }
}
