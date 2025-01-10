import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'contentview.dart';
import 'models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  final Function(Locale) changeLanguage;
  const SignUpPage({Key? key,required this.changeLanguage}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController =
      TextEditingController(); // Fixed naming
  final TextEditingController _phoneNumberController =
      TextEditingController(); // Fixed naming
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Create auth user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user == null) throw Exception('User creation failed');

      // Create user data
      UserModel userData = UserModel(
        userId: userCredential.user!.uid,
        email: _emailController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        registrationDate: DateTime.now(),
        username: _usernameController.text.trim(),
      );

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('user') // Fixed collection name
          .doc(userCredential.user!.uid)
          .set(userData.toMap());

      // Cache user ID

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  ContentView(changeLanguage: widget.changeLanguage,)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getErrorMessage(e))),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'This email is already registered. Please use a different email or try logging in.';
        case 'weak-password':
          return 'Password is too weak. Please use at least 6 characters with letters and numbers.';
        case 'invalid-email':
          return 'Invalid email format. Please check your email address.';
        case 'operation-not-allowed':
          return 'Email/password accounts are not enabled. Please contact support.';
        case 'network-request-failed':
          return 'Network error. Please check your internet connection.';
        default:
          print('Firebase Auth Error: ${error.code} - ${error.message}');
          return 'Registration failed: ${error.message}';
      }
    } else if (error is FirebaseException) {
      print('Firebase Error: ${error.code} - ${error.message}');
      return 'Database error: ${error.message}';
    } else {
      print('Unexpected Error: $error');
      return 'An unexpected error occurred. Please try again later.';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signup),
        backgroundColor: const Color(0xFFB2A4D4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Email is required';
                    if (!value!.contains('@')) return 'Invalid email';
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return 'Phone number is required';
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.phoneNumber,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Username is required';
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.username,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Password is required';
                    if (value!.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB2A4D4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                // ... existing login link code ...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
