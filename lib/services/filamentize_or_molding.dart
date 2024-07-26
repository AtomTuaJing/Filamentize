import 'dart:convert';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/pages/home_page_connected.dart';
import 'package:filamentize2/pages/home_page_connected_mo.dart';
import 'package:filamentize2/services/filamentizeData.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FilamentizeOrMolding extends StatefulWidget {
  const FilamentizeOrMolding({super.key});

  @override
  State<FilamentizeOrMolding> createState() => _FilamentizeOrMoldingState();
}

class _FilamentizeOrMoldingState extends State<FilamentizeOrMolding> {
  // initially set to filamentize page
  String filamentizeStatus = "";
  String filamentizeMode = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.watch<FilamentizeData>().filamentizeStatus != null) {
      context.read<FilamentizeData>().filamentizeStatus!.setNotifyValue(true);
    }
  }

  // method to switch page
  void toggleFilamentizePage() async {
    if (filamentizeMode == "Filamentize") {
      await context
          .read<FilamentizeData>()
          .setDeviceMode!
          .write(utf8.encode("Molding"));
    } else {
      await context
          .read<FilamentizeData>()
          .setDeviceMode!
          .write(utf8.encode("Filamentize"));
    }
  }

  // method to toggle filamentize status
  void toggleFilamentizeStatus() async {
    if (filamentizeStatus == "On") {
      showDialog(
          context: context,
          builder: (context) => const Center(
              child: CircularProgressIndicator(color: ColorsAsset.green)));
      await context
          .read<FilamentizeData>()
          .setDeviceStatus!
          .write(utf8.encode("Off"));
      Navigator.pop(context);
    } else if (filamentizeStatus == "Off") {
      showDialog(
          context: context,
          builder: (context) => const Center(
              child: CircularProgressIndicator(color: ColorsAsset.green)));
      await context
          .read<FilamentizeData>()
          .setDeviceStatus!
          .write(utf8.encode("On"));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<FilamentizeData>().filamentizeStatus != null) {
      return StreamBuilder(
        stream:
            context.read<FilamentizeData>().filamentizeStatus!.onValueReceived,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final decodedFilamentizeStatus =
                utf8.decode(snapshot.data!).split("/");
            filamentizeStatus = decodedFilamentizeStatus[0];
            filamentizeMode = decodedFilamentizeStatus[1];
            if (filamentizeMode == "Filamentize") {
              return HomePageConnected(
                  toggleFilamentize: toggleFilamentizePage,
                  toggleStatus: toggleFilamentizeStatus,
                  filamentizeStatus: filamentizeStatus);
            } else {
              return HomePageConnectedMo(
                  toggleFilamentize: toggleFilamentizePage,
                  toggleStatus: toggleFilamentizeStatus,
                  filamentizeStatus: filamentizeStatus);
            }
          }
          return const Center(
              child: CircularProgressIndicator(color: ColorsAsset.green));
        },
      );
    }
    return const Center(
        child: CircularProgressIndicator(color: ColorsAsset.green));
  }
}
