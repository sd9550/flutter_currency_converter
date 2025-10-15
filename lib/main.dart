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

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _dollarsController.dispose();
    _eurosController.dispose();
    super.dispose();
  }

  void _convertDollarsToEuros() {
    String dollarsText = _dollarsController.text;
    if (dollarsText.isNotEmpty) {
      try {
        double dollars = double.parse(dollarsText);
        double euros = dollars * 0.85; // Conversion rate
        _dollarsController.text = euros.toStringAsFixed(2);
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
        double euros = double.parse(eurosText);
        double dollars = euros * 1.15; // Conversion rate
        _eurosController.text = dollars.toStringAsFixed(2);
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

  void _clearForm() {
    _eurosController.clear();
    _dollarsController.clear();
  }

  // Validation function for dollars
  String? _validateDollars(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a dollar amount';
    }
    return null;
  }

  // Validation function for euros
  String? _validateEuros(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a euro amount';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.blue,
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

              // convert dollars to euros button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _convertDollarsToEuros,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                    backgroundColor: Colors.blue,
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
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text('Clear Form'),
                ),
              ),

              /* Display entered text (for demonstration)
              Card(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const Text(
                        'Entered Data:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Email: ${_emailController.text}'),
                      Text('Password: ${_passwordController.text}'),
                    ],
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
