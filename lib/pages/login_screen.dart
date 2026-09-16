import 'dart:async';

import 'package:flutter/material.dart';
import 'package:devlearning_indo/database/db_helper.dart';
import 'package:devlearning_indo/pages/home.dart';
import 'package:devlearning_indo/pages/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final userController = TextEditingController();

  final passController = TextEditingController();
  Timer? _notificationTimer;

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    _notificationTimer?.cancel();
    super.dispose();
  }

  void login() async {
    final user = userController.text.trim();
    final pass = passController.text;

    if (user.isEmpty || pass.isEmpty) {
      _showNotification('Isi semua field!', Colors.red);
      return;
    }

    final pengguna = await DatabaseHelper.instance.loginUser(user, pass);

    if (!mounted) return; // Menghindari linter warning penggunaan BuildContext

    if (pengguna != null) {
      _showNotification('Login berhasil', Colors.green);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeApp()),
        (route) => false,
      );
    } else {
      _showNotification('Login gagal: email atau password salah.', Colors.red);
    }
  }

  void resetPassword() {
    _showNotification('Fitur reset password segera hadir', Colors.orange);
  }

  void _showNotification(String message, Color color) {
    final messenger = ScaffoldMessenger.of(context);
    _notificationTimer?.cancel();
    final remainingSeconds = ValueNotifier<int>(59);

    void closeNotification() {
      _notificationTimer?.cancel();
      remainingSeconds.dispose();
      messenger.hideCurrentMaterialBanner();
    }

    messenger
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: ValueListenableBuilder<int>(
            valueListenable: remainingSeconds,
            builder: (context, seconds, child) {
              return Text('$message ($seconds detik)');
            },
          ),
          backgroundColor: color.withValues(alpha: 0.12),
          leading: Icon(Icons.info_outline, color: color),
          actions: [
            TextButton(
              onPressed: closeNotification,
              child: const Text('Tutup'),
            ),
          ],
        ),
      );

    _notificationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        remainingSeconds.dispose();
        return;
      }

      remainingSeconds.value--;
      if (remainingSeconds.value <= 0) {
        timer.cancel();
        remainingSeconds.dispose();
        messenger.hideCurrentMaterialBanner();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: formKey,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/icons/icon_logo.png',
                        width: 108,
                        height: 108,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF245B36),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Silakan masuk ke akun Anda',
                      style: TextStyle(color: Color(0xFF52665A)),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Email',
                      style: TextStyle(color: Color(0xFF245B36)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: userController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email wajib diisi';
                        } else if (!value.contains('@')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Masukkan email',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFF245B36),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Text(
                      'Password',
                      style: TextStyle(color: Color(0xFF245B36)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password wajib diisi';
                        } else if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Masukkan password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF245B36),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: resetPassword,
                        child: const Text(
                          'Lupa password',
                          style: TextStyle(color: Color(0xFF245B36)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Belum punya akun? ',
                            style: TextStyle(color: Color(0xFF52665A)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Color(0xFF245B36),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
