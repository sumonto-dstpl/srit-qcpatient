import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // List of filter categories
  final List<String> categories = [
    'Experience',
    'Fees',
    'Availability',
    'Gender',
    'Language',
    'City',
  ];

  // Tracks the selected category
  int selectedCategoryIndex = 0;

  // Right-side filter data
  final Map<String, Widget> filterOptions = {
    'Experience': ExperienceFilterWidget(),
    'Fees': FeesFilterWidget(),
    'Availability': AvailabilityFilterWidget(),
    'Gender': GenderFilterWidget(),
    'Language': LanguageFilterWidget(),
    'City': CityFilterWidget(),
  };

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Filters', style: TextStyle(fontSize: screenHeight * 0.025)),
      ),
      body: Row(
        children: [
          // Left Side: Categories List
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF95C8D6).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.020,
                right: MediaQuery.of(context).size.height * 0.0,
                top: MediaQuery.of(context).size.height * 0.0,
                bottom: MediaQuery.of(context).size.height * 0.02),
            width: screenWidth * 0.35,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedCategoryIndex == index
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Stack(
                      children: [
                        if (selectedCategoryIndex ==
                            index) // Show the side line only for the selected cell
                          Positioned(
                            top: 6, // Gap from the top
                            left: 0,
                            bottom: 6, // Gap from the bottom
                            child: Container(
                              width: 2.0, // Same as border width
                              color: Colors.black, // Border color
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.all(screenHeight * 0.02),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              fontWeight: selectedCategoryIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Right Side: Filter Options
          Expanded(
            child: Container(
              padding: EdgeInsets.all(screenHeight * 0.02),
              child: filterOptions[categories[selectedCategoryIndex]],
            ),
          ),
        ],
      ),
    );
  }
}

// Example Widgets for Filter Options
class ExperienceFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Experience Filter:',
            style: TextStyle(fontSize: screenHeight * 0.025)),
        SizedBox(height: screenHeight * 0.01),
        CheckboxListTile(
          title: Text('0-2 Years',
              style: TextStyle(fontSize: screenHeight * 0.02)),
          value: false,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: Text('3-5 Years',
              style: TextStyle(fontSize: screenHeight * 0.02)),
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class FeesFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fees Filter:', style: TextStyle(fontSize: screenHeight * 0.025)),
        SizedBox(height: screenHeight * 0.01),
        Slider(
          value: 500,
          min: 0,
          max: 1000,
          divisions: 10,
          label: '500',
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class AvailabilityFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Availability Filter:',
            style: TextStyle(fontSize: screenHeight * 0.025)),
        SizedBox(height: screenHeight * 0.01),
        Row(
          children: [
            Expanded(
                child: Text('Morning',
                    style: TextStyle(fontSize: screenHeight * 0.02))),
            Switch(value: false, onChanged: (value) {}),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Text('Evening',
                    style: TextStyle(fontSize: screenHeight * 0.02))),
            Switch(value: false, onChanged: (value) {}),
          ],
        ),
      ],
    );
  }
}

class GenderFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender Filter:',
            style: TextStyle(fontSize: screenHeight * 0.025)),
        SizedBox(height: screenHeight * 0.01),
        RadioListTile(
          title: Text('Male', style: TextStyle(fontSize: screenHeight * 0.02)),
          value: 'Male',
          groupValue: null,
          onChanged: (value) {},
        ),
        RadioListTile(
          title:
              Text('Female', style: TextStyle(fontSize: screenHeight * 0.02)),
          value: 'Female',
          groupValue: null,
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class LanguageFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Language Filter:',
            style: TextStyle(fontSize: screenHeight * 0.025)),
        SizedBox(height: screenHeight * 0.01),
        DropdownButton<String>(
          value: null,
          hint: Text('Select a language',
              style: TextStyle(fontSize: screenHeight * 0.02)),
          items: ['English', 'Hindi', 'Spanish']
              .map((lang) => DropdownMenuItem(
                    value: lang,
                    child: Text(lang,
                        style: TextStyle(fontSize: screenHeight * 0.02)),
                  ))
              .toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class CityFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('City Filter:', style: TextStyle(fontSize: screenHeight * 0.025)),
        SizedBox(height: screenHeight * 0.01),
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter city name',
            labelStyle: TextStyle(fontSize: screenHeight * 0.02),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(fontSize: screenHeight * 0.02),
        ),
      ],
    );
  }
}
