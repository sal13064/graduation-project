import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import your localization

class CentersPage extends StatelessWidget {
  const CentersPage({super.key});

  // Function to open Google Maps with a search for nearby autism centers
  void _openNearbyAutismCenters() async {
    const String url =
        'https://www.google.com/maps/search/Autism+Centers+near+me/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.centers),
        backgroundColor: const Color(0xFFB2A4D4),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openNearbyAutismCenters,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB2A4D4),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          ),
          child: Text(AppLocalizations.of(context)!.showNearbyAutismCenters),
        ),
      ),
    );
  }
}
