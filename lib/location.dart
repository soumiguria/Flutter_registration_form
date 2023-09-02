import 'package:flutter/material.dart';

class District {
  final String name;
  final List<String> states;
  final List<String> pincodes;

  District({
    required this.name,
    required this.states,
    required this.pincodes,
  });
}

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? selectedDistrict;
  String? selectedState;
  String? selectedPincode;

  final List<District> districts = [
    District(
      name: "District 1",
      states: ["State 1A", "State 1B"],
      pincodes: ["100001", "100002"],
    ),
    District(
      name: "District 2",
      states: ["State 2A", "State 2B"],
      pincodes: ["200001", "200002"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cascading Dropdown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedDistrict,
              hint: const Text('Select District'),
              items: districts.map((district) {
                return DropdownMenuItem<String>(
                  value: district.name,
                  child: Text(district.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  selectedState = null;
                  selectedPincode = null;
                });
              },
            ),
            const SizedBox(height: 16),
            if (selectedDistrict != null)
              DropdownButton<String>(
                value: selectedState,
                hint: const Text('Select State'),
                items: districts
                    .firstWhere((district) => district.name == selectedDistrict)
                    .states
                    .map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                    selectedPincode = null;
                  });
                },
              ),
            const SizedBox(height: 16),
            if (selectedState != null)
              DropdownButton<String>(
                value: selectedPincode,
                hint: const Text('Select Pincode'),
                items: districts
                    .firstWhere((district) => district.name == selectedDistrict)
                    .pincodes
                    .map((pincode) {
                  return DropdownMenuItem<String>(
                    value: pincode,
                    child: Text(pincode),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPincode = value;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
