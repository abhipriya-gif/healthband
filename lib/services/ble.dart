import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
//import 'package:google_fonts/google_fonts.dart';


class Ble extends StatefulWidget {
  //Ble({required Key key, required this.title}) : super(key: key);

   @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Ble> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  late StreamSubscription _subscription;
  late StreamSubscription<ConnectionStateUpdate> _connection;
  late int temperature;
  String temperatureStr = "Hello";



  void _connectBLE() {
    setState(() {
      temperatureStr = 'Loading';
    });
    _disconnect();
    _subscription = _ble.scanForDevices(
        withServices: [],
        scanMode: ScanMode.lowLatency,
        requireLocationServicesEnabled: true).listen((device) {
      if (device.name == 'Nano33BLESENSE') {
        print('Nano33BLESENSE found!');
        _connection = _ble
            .connectToDevice(
          id: device.id,
        )
            .listen((connectionState) async {
          // Handle connection state updates
          print('connection state:');
          print(connectionState.connectionState);
          if (connectionState.connectionState ==
              DeviceConnectionState.connected) {
            final characteristic = QualifiedCharacteristic(
                serviceId: Uuid.parse("9A48ECBA-2E92-082F-C079-9E75AAE428B1"),
                characteristicId: Uuid.parse("00000002-627e-47e5-a3fc-ddabd97aa966"),
                deviceId: device.id);
            final response = await _ble.readCharacteristic(characteristic);
            print(response);
            setState(() {
              temperature = response[0];
              temperatureStr = temperature.toString() + '°';
            });
            _disconnect();
            print('disconnected');
          }
        }, onError: (dynamic error) {
          // Handle a possible error
          print(error.toString());
        });
      }
    }, onError: (error) {
      print('error!');
      print(error.toString());
    });
  }
  void _disconnect() async {
    _subscription.cancel();
    if (_connection != null) {
      await _connection.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         child: Center(child: Text(temperatureStr))
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _connectBLE,
        tooltip: 'Increment',
        backgroundColor: Color(0xFF74A4BC),
        child: Icon(Icons.loop),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}