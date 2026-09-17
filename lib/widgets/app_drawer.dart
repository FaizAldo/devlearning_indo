import 'package:faizaldo_ppkd_app_dev/home/home.dart';
import 'package:faizaldo_ppkd_app_dev/tugas_flutter_1/layouting.dart';
import 'package:faizaldo_ppkd_app_dev/tugas_flutter_1/profil.dart';
import 'package:faizaldo_ppkd_app_dev/tugas_flutter2/profil_layout.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _bukaHalaman(BuildContext context, Widget halaman) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (_) => halaman),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF155E63)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpeg'),
              ),
              accountName: Text('Muhammad Faiz Aldo Firmansyah'),
              accountEmail: Text('Menu Halaman'),
            ),
            _item(context, Icons.home, 'Home', const Home()),
            _item(context, Icons.person, 'Profil Saya', const ProfilLayout()),
            _item(
              context,
              Icons.account_circle,
              'Profil Tugas 1',
              const Profil(),
            ),
            _item(
              context,
              Icons.article,
              'Layouting Tugas 1',
              const Layouting(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    Widget halaman,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF155E63)),
      title: Text(title),
      onTap: () => _bukaHalaman(context, halaman),
    );
  }
}
