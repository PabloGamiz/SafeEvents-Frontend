import 'EsdevenimentEspecific.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: "TemplateCOVID",
  home: Template(),
));
class Template extends StatefulWidget {
  Template({Key key}) : super(key: key);
  @override
  _TemplateState createState() => _TemplateState();
}
class _TemplateState extends State<Template> {
  Future<bool> _onBackPressed() async{
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Si tornes enrere no es publicarà l\'Esdeveniment \n\n N\'estàs segur/a?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () =>
                    Navigator.pop(context,false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () =>
                    _goBack(),
                child: Text('Sí'),
              ),
            ],
          ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Positioned(
                    left: 8.0,
                    top: 70.0,
                    child: InkWell(
                      onTap: () {
                        _goBackDef();
                      },
                      child: Icon(Icons.arrow_back,
                          color: Colors.blue),
                    ),
                  ),
                ),
                Column(

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: FadeInImage(

                            // En esta propiedad colocamos la imagen a descargar
                            image: NetworkImage(
                                'https://github.com/noobcoder17/covid-19/blob/master/assets/corona_virus.png?raw=true'),

                            // En esta propiedad colocamos el gif o imagen de carga
                            // debe estar almacenado localmente
                            placeholder: NetworkImage(
                                'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                            // En esta propiedad colocamos mediante el objeto BoxFit
                            // la forma de acoplar la imagen en su contenedor
                            fit: BoxFit.cover,

                            // En esta propiedad colocamos el alto de nuestra imagen
                            height: 120,
                          ),
                        ),
                        Container(
                          child: FadeInImage(

                            // En esta propiedad colocamos la imagen a descargar
                            image: NetworkImage('assets/SafeEventsBlack.png'),

                            // En esta propiedad colocamos el gif o imagen de carga
                            // debe estar almacenado localmente
                            placeholder: NetworkImage(
                                'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                            // En esta propiedad colocamos mediante el objeto BoxFit
                            // la forma de acoplar la imagen en su contenedor
                            fit: BoxFit.cover,

                            // En esta propiedad colocamos el alto de nuestra imagen
                            height: 120,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text('Prevenció COVID 19',
                      style: TextStyle(
                        color: Colors.blue
                      ),),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text('Per la teva seguretat i per la de tots, segueix aquestes recomanacions',
                        style: TextStyle(
                          color: Colors.blueGrey
                      ),
                    ),
                    ),
                  ],
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 20),
                        title: Text('Renta\'t les mans\n',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        subtitle: Text(
                            'Renta\'t les mans regularment durant 20 segons, amb sabó i/o gel hidroalohòlic'),
                        leading: FadeInImage(

                          // En esta propiedad colocamos la imagen a descargar
                          image: NetworkImage(
                              'https://github.com/noobcoder17/covid-19/blob/master/assets/prevention/wash_hands.png?raw=true'),

                          // En esta propiedad colocamos el gif o imagen de carga
                          // debe estar almacenado localmente
                          placeholder: NetworkImage(
                              'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                          // En esta propiedad colocamos mediante el objeto BoxFit
                          // la forma de acoplar la imagen en su contenedor
                          fit: BoxFit.cover,

                          // En esta propiedad colocamos el alto de nuestra imagen
                          height: 260,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  child: Column(
                      children: <Widget>[

                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 20),
                          title: Text('Utilitza la mascareta\n',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          subtitle: Text(
                              'Has de dur posada la mascareta en tot moment, cobrint la boca i el nas.\nMai et treguis la mascareta!'),
                          leading: FadeInImage(

                            // En esta propiedad colocamos la imagen a descargar
                            image: NetworkImage(
                                'https://github.com/noobcoder17/covid-19/blob/master/assets/prevention/face_mask.png?raw=true'),

                            // En esta propiedad colocamos el gif o imagen de carga
                            // debe estar almacenado localmente
                            placeholder: NetworkImage(
                                'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                            // En esta propiedad colocamos mediante el objeto BoxFit
                            // la forma de acoplar la imagen en su contenedor
                            fit: BoxFit.cover,

                            // En esta propiedad colocamos el alto de nuestra imagen
                            height: 260,
                          ),
                        ),
                      ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[

                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 20),
                        title: Text('Evita les aglomeracions\n',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        subtitle: Text(
                            'Procura estar a mínim 2 m de la gent del teu voltant, estigues segur/a en tot moment!'),
                        leading: FadeInImage(

                          // En esta propiedad colocamos la imagen a descargar
                          image: NetworkImage(
                              'https://x-madrid.com/wp-content/uploads/2020/06/distancia_icono.png'),

                          // En esta propiedad colocamos el gif o imagen de carga
                          // debe estar almacenado localmente
                          placeholder: NetworkImage(
                              'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                          // En esta propiedad colocamos mediante el objeto BoxFit
                          // la forma de acoplar la imagen en su contenedor
                          fit: BoxFit.cover,

                          // En esta propiedad colocamos el alto de nuestra imagen
                          height: 260,
                        ),
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
        )
    );

  }
  _goBack() {
    Navigator.pop(context,false);
    _goBackDef();
  }
  _goBackDef() {

    runApp(
        MaterialApp(
          home: Mostra(idevent: 20),
        ));
  }

}