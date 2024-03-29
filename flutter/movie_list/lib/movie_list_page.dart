// list_page.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_list/movie_dto.dart';
import 'package:movie_list/movie_repository.dart';
import 'package:http/http.dart' as http;

class MovieListPage extends HookWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listState = useState<List<MovieDTOTable>?>(null);
    useEffect(() {
      MovieRepository.instance.getDTOList().then((value){
        listState.value = value as List<MovieDTOTable>?;
      });
    }, []);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: listState.value?.map((e) => MovieListItem(movieDTOTable: e)).toList() ?? [],
        ),
      ),
    );
  }
}

class MovieListItem extends StatelessWidget {
  MovieDTOTable movieDTOTable;

  MovieListItem({Key? key, required this.movieDTOTable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black),
      ),
      child: Column(
        children: [
          Text("movieCd : ${movieDTOTable.movieCd}"),
          Divider(),
          Text("movieNm : ${movieDTOTable.movieNm}"),
          Divider(),
          Text("openDt : ${movieDTOTable.openDt}"),
        ],
      ),
    );
  }
}
