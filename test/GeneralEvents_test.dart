import 'package:flutter/material.dart';
import 'package:safeevents/EventsGeneral.dart';
import 'package:safeevents/http_models/GeneralEventsModel.dart';
import 'package:test/test.dart';

void main() {
  List<Feedback> feedback = List();
  List<dynamic> services = List();
  List<ListEsdevenimentsModel> esdeveniments = List();
  esdeveniments.add(ListEsdevenimentsModel(
      id: 1,
      title: 'Kiko Rivera',
      description: 'descripcion',
      capacity: 30,
      taken: 1,
      price: 1,
      checkInDate: DateTime.now(),
      closureDate: DateTime.now(),
      location: 'Palau Sant Jordi',
      feedbacks: feedback,
      services: services,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      image: 'image',
      tipus: 'musica'));
  esdeveniments.add(ListEsdevenimentsModel(
      id: 2,
      title: "El clasico",
      description: "descripcion",
      capacity: 30,
      taken: 1,
      price: 1,
      checkInDate: DateTime.now(),
      closureDate: DateTime.now(),
      location: "Camp Nou",
      feedbacks: feedback,
      services: services,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      image: "image",
      tipus: "Esport"));

  group('FiltrarLlistaPerLloc', () {
    test(
        'La llista conté el nombre d\'esdeveniments correcte quan no es filtra res',
        () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, '', 0);
      expect(esdevenimentsFiltrats.length, 2);
    });

    test(
        'La llista filtrada conté el nombre d\'esdeveniments correcte quan es filtra per un lloc que existeix',
        () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats =
          filtrarEsdeveniments(esdeveniments, 'Palau Sant Jordi', 0);
      expect(esdevenimentsFiltrats.length, 1);
    });

    test(
        'La llista filtrada no conté cap esdeveniments quan es filtra per un lloc que no existeix',
        () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, 'Madrid', 0);
      expect(esdevenimentsFiltrats.length, 0);
    });
  });

  group('FiltrarLlistaPerCategoria', () {
    test(
        'La llista conté el nombre d\'esdeveniments correcte quan no es filtra per cap categoria',
        () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, '', 1);
      expect(esdevenimentsFiltrats.length, 2);
    });

    test(
        'La llista filtrada conté el nombre d\'esdeveniments correcte quan es filtra per una categoria amb esdeveniments',
        () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, 'Esport', 1);
      expect(esdevenimentsFiltrats.length, 1);
    });

    test(
        'La llista filtrada no conté cap esdeveniments quan es filtra per una categoria sense esdeveniments',
        () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, 'Art', 1);
      expect(esdevenimentsFiltrats.length, 0);
    });
  });
}
