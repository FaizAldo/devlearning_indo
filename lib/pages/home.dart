import 'package:flutter/material.dart';
import 'package:devlearning_indo/pages/about.dart';
import 'package:devlearning_indo/pages/login_screen.dart';
import 'package:devlearning_indo/database/db_helper.dart';
import 'package:devlearning_indo/models/form_input.dart';
import 'package:devlearning_indo/models/product.dart';
import 'package:devlearning_indo/preference_system/preference.dart';
import 'package:devlearning_indo/reusable/app_texts.dart';

const _categories = [
  'Buah-buahan',
  'Sayuran',
  'Elektronik',
  'Pakaian Pria',
  'Pakaian Wanita',
  'Alat Tulis Kantor',
  'Buku & Majalah',
  'Peralatan Dapur',
  'Makanan Ringan',
  'Minuman',
];

const _categoryDetails = [
  {'name': 'Buah-buahan', 'icon': Icons.local_grocery_store_outlined},
  {'name': 'Sayuran', 'icon': Icons.eco_outlined},
  {'name': 'Elektronik', 'icon': Icons.devices_outlined},
  {'name': 'Pakaian Pria', 'icon': Icons.man_outlined},
  {'name': 'Pakaian Wanita', 'icon': Icons.woman_outlined},
  {'name': 'Alat Tulis Kantor', 'icon': Icons.edit_outlined},
  {'name': 'Buku & Majalah', 'icon': Icons.menu_book_outlined},
  {'name': 'Peralatan Dapur', 'icon': Icons.kitchen_outlined},
  {'name': 'Makanan Ringan', 'icon': Icons.fastfood_outlined},
  {'name': 'Minuman', 'icon': Icons.local_cafe_outlined},
];

final _products = [
  const Product(
    name: 'Apel Segar',
    category: 'Buah-buahan',
    description: 'Buah segar pilihan untuk kebutuhan sehari-hari.',
  ),
  const Product(
    name: 'Sayuran Organik',
    category: 'Sayuran',
    description: 'Sayuran segar untuk hidangan sehat keluarga.',
  ),
  const Product(
    name: 'Laptop Belajar',
    category: 'Elektronik',
    description: 'Perangkat untuk mendukung aktivitas belajar teknologi.',
  ),
  const Product(
    name: 'Kemeja Pria',
    category: 'Pakaian Pria',
    description: 'Pakaian nyaman untuk aktivitas sehari-hari.',
  ),
  const Product(
    name: 'Blus Wanita',
    category: 'Pakaian Wanita',
    description: 'Pakaian wanita dengan desain nyaman dan modern.',
  ),
  const Product(
    name: 'Paket Alat Tulis',
    category: 'Alat Tulis Kantor',
    description: 'Perlengkapan tulis untuk belajar dan bekerja.',
  ),
  const Product(
    name: 'Buku Pemrograman',
    category: 'Buku & Majalah',
    description: 'Referensi belajar pemrograman untuk pemula.',
  ),
  const Product(
    name: 'Set Peralatan Dapur',
    category: 'Peralatan Dapur',
    description: 'Peralatan praktis untuk membantu memasak di rumah.',
  ),
  const Product(
    name: 'Camilan Nusantara',
    category: 'Makanan Ringan',
    description: 'Pilihan camilan lokal untuk menemani aktivitas.',
  ),
  const Product(
    name: 'Jus Buah Segar',
    category: 'Minuman',
    description: 'Minuman segar untuk menemani aktivitas harian.',
  ),
];

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _databaseHelper = DatabaseHelper.instance;
  int _notificationVersion = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _selectHome() {
    setState(() {
      _selectedIndex = 0;
    });
    Navigator.pop(context);
  }

  Future<void> _logout() async {
    await PreferenceHandler.logOut();
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(showLogoutMessage: true),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: const Text(
          AppTexts.appName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: _buildHomeForm(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 0) {
            setState(() {
              _selectedIndex = 0;
            });
            return;
          }

              if (index == 2) {
                _logout();
                return;
              }

              const page = AboutPage();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
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
              NavigationDestination(
                icon: Icon(Icons.logout),
                label: 'Logout',
              ),
        ],
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
              decoration: const BoxDecoration(color: Colors.lightGreen),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                AppTexts.homeTitle,
                style: TextStyle(color: Color(0xFF245B36)),
              ),
              selected: _selectedIndex == 0,
              onTap: _selectHome,
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text(
                AppTexts.aboutTitle,
                style: TextStyle(color: Color(0xFF245B36)),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color(0xFF245B36)),
              ),
              onTap: () {
                Navigator.pop(context);
                _logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            AppTexts.formTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF245B36),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            AppTexts.formDescription,
            style: TextStyle(color: Color(0xFF52665A)),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama',
              labelStyle: TextStyle(color: Color(0xFF52665A)),
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline, color: Color(0xFF245B36)),
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Nama wajib diisi'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xFF52665A)),
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF245B36)),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email wajib diisi';
              }
              if (!value.contains('@')) {
                return 'Masukkan email yang valid';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _messageController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Pesan',
              labelStyle: TextStyle(color: Color(0xFF52665A)),
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.message_outlined,
                color: Color(0xFF245B36),
              ),
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Pesan wajib diisi'
                : null,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.send),
              label: const Text('Kirim'),
            ),
          ),
          const SizedBox(height: 32),
          _buildCategorySections(),
        ],
      ),
    );
  }

  Widget _buildCategorySections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppTexts.categoryListTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF245B36),
          ),
        ),
        const Text(
          AppTexts.categoryListDescription,
          style: TextStyle(color: Color(0xFF52665A)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          itemBuilder: (context, index) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(_categories[index]),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          AppTexts.categoryIconTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF245B36),
          ),
        ),
        const Text(
          AppTexts.categoryIconDescription,
          style: TextStyle(color: Color(0xFF52665A)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categoryDetails.length,
          itemBuilder: (context, index) {
            final category = _categoryDetails[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                category['icon'] as IconData,
                color: const Color(0xFF245B36),
              ),
              title: Text(category['name'] as String),
            );
          },
        ),
        const SizedBox(height: 24),
        const Text(
          AppTexts.productListTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF245B36),
          ),
        ),
        const Text(
          AppTexts.productListDescription,
          style: TextStyle(color: Color(0xFF52665A)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _products.length,
          itemBuilder: (context, index) => ListProduk(produk: _products[index]),
        ),
      ],
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _databaseHelper.insertFormInput(
      FormInput(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      ),
    );
    _showNotification(
      'Data berhasil disimpan',
      Colors.green,
      showCloseButton: true,
    );
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
}

class ListProduk extends StatelessWidget {
  final Product produk;

  const ListProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/icons/icon_logo.png',
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          'Produk: ${produk.name}',
          style: const TextStyle(
            color: Color(0xFF245B36),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Kategori: ${produk.category}\n${produk.description}'),
        isThreeLine: true,
      ),
    );
  }
}
