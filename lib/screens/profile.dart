import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';
import 'package:meal_mate/widgets/back_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Variables d'état pour les sélections
  String selectedRegime = '';
  List<String> preferences = [];

  // Options disponibles
  final List<String> regimes = [
    'OMNIVORE',
    'VEGETARIAN',
    'VEGAN',
    'GLUTEN-FREE',
    'PORK-FREE',
    'LACTOSE-FREE'
  ];

  final List<String> preferenceOptions = [
    'HEALTHY',
    'WORLD CUISINE',
    'COMFORT FOOD',
    'PROTEIN RICH'
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Charger les préférences sauvegardées
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedRegime = prefs.getString('selectedRegime') ?? '';
      preferences = prefs.getStringList('preferences') ?? [];
    });
  }

  // Sauvegarder les préférences
  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedRegime', selectedRegime);
    prefs.setStringList('preferences', preferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const MeatMateBackButton(
          iconColor: Colors.white,
          color: Colors.transparent,
        ),
        title: Text(
          'Profile',
          style: normalBoldWhiteStyle.copyWith(
            fontFamily: 'Omnes',
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My regime',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Omnes'),
            ),
            const SizedBox(height: 8.0),
            ...regimes.map((regime) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRegime = regime;
                      _savePreferences();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedRegime == regime
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          regime,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Omnes',
                            color: selectedRegime == regime
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 16.0),
            const Text(
              'My preferences',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Omnes'),
            ),
            const SizedBox(height: 8.0),
            ...preferenceOptions.map((preference) => GestureDetector(
                  onTap: () {
                    setState(() {
                      if (preferences.contains(preference)) {
                        preferences.remove(preference);
                      } else {
                        preferences.add(preference);
                      }
                      _savePreferences();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: preferences.contains(preference)
                            ? const Color.fromARGB(255, 255, 174, 0)
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          preference,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Omnes',
                            color: preferences.contains(preference)
                                ? const Color.fromARGB(255, 255, 174, 0)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
