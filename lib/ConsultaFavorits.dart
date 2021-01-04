import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_models/FavsModel.dart';
import 'http_requests/http_favs.dart';

class ConsultaFavortis extends StatefulWidget {
  ConsultaFavortis();

  _ConsultaFavoritsState createState() => _ConsultaFavoritsState();
}

class _ConsultaFavoritsState extends State<ConsultaFavortis> {
  Future<List<FavsModel>> favs;

  @override
  void initState() {
    super.initState();
    favs = fetchFavEvents();
  }

  Future<List<FavsModel>> fetchFavEvents() async {
    return await http_Favs();
  }

  Widget createListEventWidget(AsyncSnapshot<List<FavsModel>> snapshot) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: snapshot.data.map(_buildEventWidget).toList(),
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavsModel>>(
      future: favs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return createListEventWidget(snapshot);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

_esdevenimentEspecific(int id) {
  runApp(MaterialApp(
    home: Mostra(idevent: id),
  ));
}

Widget _buildEventWidget(FavsModel event) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 1.0,
      horizontal: 4.0,
    ),
    child: Card(
      color: Colors.lightBlue,
      child: ListTile(
        onTap: () {
          _esdevenimentEspecific(event.id);
        },
        title: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                event.title,
                style: TextStyle(fontSize: 24, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        subtitle: Row(
          children: [
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: Text(event.price.toString() + '€',
                  style: TextStyle(fontSize: 40, color: Colors.white)),
            ),
            Expanded(
              //color: Colors.red,
              //height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Text(
                        event.location,
                        /*filteredEvents[index].location.name,*/
                        style: TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Text(event.closureDate.toString().substring(0, 16),
                      style: TextStyle(color: Colors.white)),
                  Container(
                    height: 5,
                  ),
                  Text('Música', //filteredEvents[index].category,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
