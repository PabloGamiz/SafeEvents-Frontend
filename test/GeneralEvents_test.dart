import 'package:safeevents/EventsGeneral.dart';
import 'package:test/test.dart';
import 'http_model/GeneralEventsModel.dart';

void main() {

  List<ListEsdevenimentsModel> esdeveniments = List();
  esdeveniments.add(ListEsdevenimentsModel({Controller({1, 'KIKO RIVERA ON CONCERT', 'descripción de ejemplo', 30, 30, Location({1, 'Palau Sant Jordi', 'Palau Sant Jordi, Barcelona'})})});
  esdeveniments.add(ListEsdevenimentsModel({Controller({2, 'El clasico', 'FC Barcelona vs Real Madrid', 30, 30, Location({2, 'Camp Nou', 'Camp Nou, Pedralbes'})})});

  Group('FiltrarLlistaPerLloc', () {
    
    test('La llista conté el nombre d\'esdeveniments correcte quan no es filtra res', () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, '', 0);
      expect(esdevenimentsFiltrats.length, 2);
    });

    test('La llista filtrada conté el nombre d\'esdeveniments correcte quan es filtra per un lloc que existeix', () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, 'Palau Sant Jordi', 0);
      expect(esdevenimentsFiltrats.length, 1);
    });

    test('La llista filtrada no conté cap esdeveniments quan es filtra per un lloc que no existeix', () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, 'Madrid', 0);
      expect(esdevenimentsFiltrats.length, 0);
    });
  });

  Group('FiltrarLlistaPerCategoria', () {
      test('La llista conté el nombre d\'esdeveniments correcte quan no es filtra per cap categoria', () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, '', 1);
      expect(esdevenimentsFiltrats.length, 2);
    });

    test('La llista filtrada conté el nombre d\'esdeveniments correcte quan es filtra per una categoria amb esdeveniments', () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, 'Esport', 1);
      expect(esdevenimentsFiltrats.length, 1);
    });

    test('La llista filtrada no conté cap esdeveniments quan es filtra per una categoria sense esdeveniments', () {
      List<ListEsdevenimentsModel> esdevenimentsFiltrats = List();
      esdevenimentsFiltrats = filtrarEsdeveniments(esdeveniments, 'Art', 1);
      expect(esdevenimentsFiltrats.length, 0);
    });
  });
}