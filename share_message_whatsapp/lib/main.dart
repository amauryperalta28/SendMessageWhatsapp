import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( primaryColor: Colors.orange.shade400),
      initialRoute: '/',
      routes: {'/': (context) => HomeScreen(platformVersion: _platformVersion)},
      // home: HomeScreen(platformVersion: _platformVersion),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    @required String platformVersion,
  })  : _platformVersion = platformVersion,
        super(key: key);

  final String _platformVersion;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _opcionSelecciona = 'None';
  List<String> _groups = ['None'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Envio de mensajes'),
        
        backgroundColor: Colors.orange.shade400,
        
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RaisedButton(
                    color: Colors.orange.shade400,
                    textColor: Colors.white,
                    onPressed: () {
                      print('hice click');
                    },
                    child: Container(child: Text('Agregar Grupo')),
                  ),
                  SizedBox(height: 20.0),
                  _crearDropdown(),
                  _buildMessageTextArea(),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildMemberLabel(),
                  _buildGroupsMembers()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMemberLabel() {
    return Container(
        child: Text(
      'Integrantes',
      style: TextStyle(fontSize: 20.0),
    ));
  }

  Widget _crearDropdown() {
    return Container(
      width: 150.0,
      child: DropdownButton(
        isExpanded: true,
        value: _opcionSelecciona,
        items: getOpcionesDropdown(),
        onChanged: (opt) {
          print(opt);

          setState(() {
            _opcionSelecciona = opt;
          });
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _groups.forEach((poder) {
      lista.add(DropdownMenuItem(
        value: poder,
        child: Text(poder),
      ));
    });

    return lista;
  }

  Future<void> sendMessage() async {
    await FlutterOpenWhatsapp.sendSingleMessage("18098026629", "Hello its me");
    print("sendt");
  }

  Widget _buildMessageTextArea() {
    return TextField(
      
      decoration: InputDecoration(
          hintText: 'Ingrese el mensaje a enviar al participante',
          hintMaxLines: 10),
      maxLines: 10,
    );
  }

  Widget _buildGroupsMembers() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Text('No hay integrantes cargados'),
    );
  }
}
