import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primaryColor: Colors.blue[600],
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[900]),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue[600],
          secondary: Colors.orange[400],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: TemperatureConverter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  // Controller for managing text input
  final TextEditingController inputController = TextEditingController();

  // Variable to store which conversion type is currently selected
  String selectedConversion = 'fahrenheitToCelsius';

  // Variable to store the conversion result as a string
  String conversionResult = '';

  // List to store conversion history entries
  List<String> conversionHistory = [];

  // Conversion function: Celsius to Fahrenheit using formula °F = °C x 9/5 + 32
  double celsiusToFahrenheit(double celsius) => celsius * 9 / 5 + 32;
  
  // Conversion function: Fahrenheit to Celsius using formula °C = (°F - 32) x 5/9
  double fahrenheitToCelsius(double fahrenheit) => (fahrenheit - 32) * 5 / 9;

  // Main conversion function that performs the temperature conversion
  void convert() {
    // Input validation: check if user entered a value
    if (inputController.text.isEmpty) {
      showInputError('Please enter a valid number');
      return;
    }
    try {
      // Parse user input to double, default to 0.0 if parsing fails
      double inputValue = double.tryParse(inputController.text) ?? 0.0;
      double convertedValue;
      String historyEntry;

      // Perform conversion based on selected conversion type
      if (selectedConversion == 'celsiusToFahrenheit') {
        convertedValue = celsiusToFahrenheit(inputValue);
        historyEntry = 'C to F: ${inputValue.toStringAsFixed(1)} => ${convertedValue.toStringAsFixed(2)}';
      } else {
        convertedValue = fahrenheitToCelsius(inputValue);
        historyEntry = 'F to C: ${inputValue.toStringAsFixed(1)} => ${convertedValue.toStringAsFixed(2)}';
      }

      // Update UI with new result and add to history
      setState(() {
        conversionResult = convertedValue.toStringAsFixed(2);
        conversionHistory.insert(0, historyEntry); // Add to beginning of list
      });
    } catch (e) {
      // Handle any parsing errors
      showInputError('Invalid input. Please enter a number.');
    }
  }

  void performConversion() {
    convert();
  }

  void showInputError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Input Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void clearHistory() {
    setState(() {
      conversionHistory.clear();
    });
  }

  Widget buildConversionRadioButton(String value, String title) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      value: value,
      groupValue: selectedConversion,
      onChanged: (String? newValue) {
        setState(() {
          selectedConversion = newValue!;
          conversionResult = ''; // Clear result when changing conversion type
        });
      },
      dense: true,
      activeColor: Colors.blue[600],
    );
  }

  Widget buildConvertButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: convert,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          'Convert',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildTemperatureInputSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Row containing input field, equals sign, and result display
            Row(
              children: [
                // Input field for temperature
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: inputController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
                      ),
                      labelText: 'Temperature',
                      hintText: 'Enter value',
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                // Equals sign separator
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.blue[600],
                      size: 20,
                    ),
                  ),
                ),

                // Result display area
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue[50],
                    ),
                    child: Text(
                      conversionResult.isEmpty ? '0.0' : conversionResult,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),
            // Convert button
            buildConvertButton(),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 48,
            color: Colors.grey[400],
          ),
          SizedBox(height: 12),
          Text(
            'No conversions yet.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Perform a conversion to see history.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHistoryList() {
    return ListView.builder(
      itemCount: conversionHistory.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[600],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  conversionHistory[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildHistorySection(Orientation orientation) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Conversion History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                if (conversionHistory.isNotEmpty)
                  TextButton.icon(
                    icon: Icon(Icons.clear_all, size: 18),
                    label: Text('Clear'),
                    onPressed: clearHistory,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange[600],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),

            Container(
              height: orientation == Orientation.portrait ? 250 : 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
              ),
              child: conversionHistory.isEmpty
                  ? buildEmptyHistory()
                  : Padding(
                      padding: EdgeInsets.all(8),
                      child: buildHistoryList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature Converter App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 2,
        centerTitle: true,
      ),

      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Conversion:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),

                        Row(
                          children: [
                            Expanded(
                              child: buildConversionRadioButton(
                                'fahrenheitToCelsius',
                                'Fahrenheit to Celsius'
                              ),
                            ),
                            Expanded(
                              child: buildConversionRadioButton(
                                'celsiusToFahrenheit',
                                'Celsius to Fahrenheit'
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                buildTemperatureInputSection(),

                SizedBox(height: 16),

                buildHistorySection(orientation),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}