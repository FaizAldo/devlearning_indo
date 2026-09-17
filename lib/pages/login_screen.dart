import 'package:flutter/material.dart';
import 'package:devlearning_indo/database/db_helper.dart';
import 'package:devlearning_indo/pages/home.dart';
import 'package:devlearning_indo/pages/register_screen.dart';
import 'package:devlearning_indo/preference_system/preference.dart';

class LoginScreen extends StatefulWidget {
  final bool showLogoutMessage;

  const LoginScreen({super.key, this.showLogoutMessage = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final userController = TextEditingController();

  final passController = TextEditingController();
  int _notificationVersion = 0;

  @override
  void initState() {
    super.initState();
    if (widget.showLogoutMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showNotification('Berhasil Logout', Colors.green);
        }
      });
    }
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
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

    if (!mounted) return;

    if (pengguna != null) {
      await PreferenceHandler.setLogin(true);
      _showNotification('Login berhasil', Colors.green);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;

      final messenger = ScaffoldMessenger.maybeOf(context);
      messenger?.removeCurrentMaterialBanner();

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
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

  void _showNotification(
    String message,
    Color color, {
    bool showCloseButton = false,
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    final notificationVersion = ++_notificationVersion;

    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: color),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color.withValues(alpha: 0.12),
        behavior: SnackBarBehavior.floating,
        action: showCloseButton
            ? SnackBarAction(
                label: 'Tutup',
                onPressed: messenger.removeCurrentSnackBar,
              )
            : null,
      ),
    );

    Future<void>.delayed(const Duration(seconds: 3), () {
      if (mounted && notificationVersion == _notificationVersion) {
        messenger.removeCurrentSnackBar();
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
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
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
