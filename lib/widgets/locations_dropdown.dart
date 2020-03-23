import 'package:flutter/material.dart';

class LocationsDropdown extends StatefulWidget {
  final List<String> countries;
  final Function callback;

  LocationsDropdown({@required this.countries, @required this.callback});

  @override
  State<StatefulWidget> createState() {
    return _LocationsDropdownState();
  }
}

class _LocationsDropdownState extends State<LocationsDropdown> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Choose Country',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: DropdownButton(
            value: dropdownValue == null ? 'World' : dropdownValue,
            elevation: 16,
            style: TextStyle(color: Colors.green),
            items: widget.countries.map((country) {
              return DropdownMenuItem(value: country, child: Text(country));
            }).toList(),
            onChanged: (String country) {
              setState(() {
                dropdownValue = country;
              });
              // fire callback to update state for selected country
              widget.callback(country);
            },
          ),
        ),
      ],
    );
  }
}
