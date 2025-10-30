import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final success = await _authService.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _error = 'Invalid username or password';
      });
    }
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    Navigator.pushReplacementNamed(context, '/registration');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/core/assets/darkGreenLogo.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            Text('Login Page', style: style),

            // Card(
            // child: Padding(
            //   padding: const EdgeInsets.all(20.0),
            // ),
            // ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
                TextButton(
                  onPressed: _isLoading ? null : _register,
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
