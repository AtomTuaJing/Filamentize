import 'package:filamentize2/pages/home_page.dart';
import 'package:filamentize2/services/filamentizeData.dart';
import 'package:filamentize2/services/filamentize_or_molding.dart';
import 'package:filamentize2/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotConnectedOrConnected extends StatefulWidget {
  const NotConnectedOrConnected({super.key});

  @override
  State<NotConnectedOrConnected> createState() =>
      _NotConnectedOrConnectedState();
}

class _NotConnectedOrConnectedState extends State<NotConnectedOrConnected> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterBluePlus.events.onConnectionStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.connectionState ==
              BluetoothConnectionState.connected) {
            return const Navigation(
              connectionState: true,
            );
          }
          return const Navigation(connectionState: false);
        } else if (snapshot.hasError) {
          return Text(
            "error: ${snapshot.error}",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
            ),
          );
        } else {
          return const Navigation(
            connectionState: false,
          );
        }
      },
    );
  }
}
