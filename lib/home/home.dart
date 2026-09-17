import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF155E63),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.school_rounded,
                    size: 30,
                    color: Color(0xFF155E63),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'DevLearning Indo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Belajar Flutter',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_rounded),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.person_rounded),
            title: Text('Profil'),
          ),
          ListTile(
            leading: Icon(Icons.assignment_rounded),
            title: Text('Tugas'),
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF155E63),
        foregroundColor: Colors.white,
        title: const Text('Home'),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF3F7F6),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dashboard_rounded,
              size: 72,
              color: Color(0xFF155E63),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selamat Datang',
              style: TextStyle(
                color: Color(0xFF155E63),
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Aplikasi ini berisi halaman profil, tugas, dan latihan widget Flutter.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF155E63),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih halaman yang ingin kamu buka melalui menu di kiri atas.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF234044), fontSize: 16),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
