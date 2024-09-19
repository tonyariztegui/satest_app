import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cognomeController = TextEditingController();
  final TextEditingController _indirizzoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _imgpController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.11.11.158:1337', // Updated with your API base URL
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nomeController.dispose();
    _cognomeController.dispose();
    _indirizzoController.dispose();
    _telefonoController.dispose();
    _imgpController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final nome = _nomeController.text;
    final cognome = _cognomeController.text;
    final indirizzo = _indirizzoController.text;
    final telefono = _telefonoController.text;
    final imgp = _imgpController.text; // This is optional

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await _dio.post(
        '/api/registrazione', // Updated endpoint
        data: {
          'username': username,
          'email': email,
          'password': password,
          'nome': nome.isEmpty ? null : nome,
          'cognome': cognome.isEmpty ? null : cognome,
          'indirizzo': indirizzo.isEmpty ? null : indirizzo,
          'telefono': telefono.isEmpty ? null : telefono,
          'imgp': imgp.isEmpty ? null : imgp, // Optional field
        },
      );

      if (response.statusCode == 200) {
        // Successfully registered
        final data = response.data;
        print('User registered: ${data['username']}');
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = 'Registration failed';
        });
      }
    } on DioException catch (e) {
      setState(() {
        if (e.response != null) {
          _errorMessage = e.response!.data['message'] ?? 'Registration error';
        } else {
          _errorMessage = 'Error: ${e.message}';
        }
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    final telefonoRegex = RegExp(r'^[0-9]{10,}$');
    if (value == null || value.isEmpty) {
      return null; // Optional field
    } else if (!telefonoRegex.hasMatch(value)) {
      return 'Please enter a valid phone number with at least 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username *',
                  suffixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  suffixIcon: Icon(Icons.email),
                ),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password *',
                  suffixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password *',
                  suffixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'First Name *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cognomeController,
                decoration: const InputDecoration(
                  labelText: 'Last Name *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _indirizzoController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: _validatePhoneNumber,
              ),
              TextFormField(
                controller: _imgpController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _register();
                        }
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
