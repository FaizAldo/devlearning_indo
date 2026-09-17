import 'package:flutter/material.dart';
import 'package:devlearning_indo/pages/login_screen.dart';
import 'package:devlearning_indo/preference_system/preference.dart';
import 'package:devlearning_indo/reusable/app_texts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          AppTexts.aboutTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(AppTexts.appName),
              accountEmail: const Text(AppTexts.appTagline),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/icons/icon_logo.png'),
              ),
              decoration: BoxDecoration(color: Colors.lightGreen),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                AppTexts.homeTitle,
                style: TextStyle(color: Color(0xFF245B36)),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text(
                AppTexts.aboutTitle,
                style: TextStyle(color: Color(0xFF245B36)),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color(0xFF245B36)),
              ),
              onTap: () {
                Navigator.pop(context);
                _logout(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: Colors.lightGreen,
                child: Icon(Icons.code, color: Colors.white, size: 48),
              ),
              const SizedBox(height: 24),
              const Text(
                AppTexts.appName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF245B36),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                AppTexts.aboutDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF52665A),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppTexts.appVersion,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pop(context);
            return;
          }

          if (index == 2) {
            _logout(context);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: AppTexts.homeTitle,
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: AppTexts.aboutTitle,
          ),
          NavigationDestination(icon: Icon(Icons.logout), label: 'Logout'),
        ],
      ),
    );
  }

  static Future<void> _logout(BuildContext context) async {
    await PreferenceHandler.logOut();
    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(showLogoutMessage: true),
      ),
      (route) => false,
    );
  }
}
