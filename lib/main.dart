// Stefan Drozdek
// CIS 3334
// Unit 6
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrencyForm(),
    );
  }
}

class CurrencyForm extends StatefulWidget {
  const CurrencyForm({super.key});

  @override
  State<CurrencyForm> createState() => _CurrencyFormState();
}

class _CurrencyFormState extends State<CurrencyForm> {
  // Controllers to manage text field values
  final TextEditingController _dollarsController = TextEditingController();
  final TextEditingController _eurosController = TextEditingController();
  String dollarResult = '';
  String euroResult = '';


  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _dollarsController.dispose();
    _eurosController.dispose();
    super.dispose();
  }

  // Conversion functions
  void _convertDollarsToEuros() {
    String dollarsText = _dollarsController.text;
    if (dollarsText.isNotEmpty) {
      try {
        double conversionRate = 0.86;
        double dollars = double.parse(dollarsText);
        double euros = dollars * conversionRate; // Conversion rate
        //_dollarsController.text = euros.toStringAsFixed(2);
        setState(() {
          dollarResult = "\$${dollars.toStringAsFixed(2)} converts to €${euros.toStringAsFixed(2)}";
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid dollar amount'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _convertEurosToDollars() {
    String eurosText = _eurosController.text;
    if (eurosText.isNotEmpty) {
      try {
        double conversionRate = 1.17;
        double euros = double.parse(eurosText);
        double dollars = euros * conversionRate; // Conversion rate
        //_eurosController.text = dollars.toStringAsFixed(2);
        setState(() {
          euroResult = "€${euros.toStringAsFixed(2)} converts to \$${dollars.toStringAsFixed(2)}";
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid Euro amount'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Clear both text fields
  void _clearForm() {
    _eurosController.clear();
    _dollarsController.clear();
    setState(() {
      dollarResult = "";
      euroResult = "";
    });
  }

  // Validation function for dollars
  String? _validateDollars(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Dollar amount';
    }
    return null;
  }

  // Validation function for euros
  String? _validateEuros(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Euro amount';
    }
    return null;
  }

  // Widget section
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dollars Text Field
              TextFormField(
                controller: _dollarsController,
                decoration: const InputDecoration(
                  labelText: 'Dollars',
                  hintText: 'Enter dollar amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: _validateDollars,
              ),

              const SizedBox(height: 24),

              // Convert Dollars to euros button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _convertDollarsToEuros,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Convert to Euros',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Euros to Dollars Text Field
              TextFormField(
                controller: _eurosController,
                decoration: const InputDecoration(
                  labelText: 'Euros',
                  hintText: 'Enter the Euro amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: _validateEuros,
              ),

              const SizedBox(height: 24),

              // convert euros to dollars button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _convertEurosToDollars,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Convert to Euros',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Clear Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: _clearForm,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text('Clear Form'),
                ),
              ),

              const SizedBox(height: 12),

              // Rows for displaying results
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dollarResult,
                    style: const TextStyle(fontSize: 14),
                  )
                ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      euroResult,
                      style: const TextStyle(fontSize: 14),
                    )
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
