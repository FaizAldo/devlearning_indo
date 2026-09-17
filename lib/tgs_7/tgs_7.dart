import 'package:flutter/material.dart';

void main() {
  runApp(const Tgs7());
}

class Tgs7 extends StatelessWidget {
  const Tgs7({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 7 Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Menyimpan halaman yang sedang dipilih
  String halamanAktif = 'Checkbox';

  // Checkbox
  bool setuju = false;

  // Switch
  bool modeGelap = false;

  // Dropdown
  String? kategori;

  // Date Picker
  DateTime? tanggalLahir;

  // Time Picker
  TimeOfDay? waktuPengingat;

  // Fungsi mengganti halaman
  void pilihMenu(String menu) {
    setState(() {
      halamanAktif = menu;
    });

    Navigator.pop(context);
  }

  // Fungsi memilih tanggal
  Future<void> pilihTanggal() async {
    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        tanggalLahir = tanggal;
      });
    }
  }

  // Fungsi memilih waktu
  Future<void> pilihWaktu() async {
    final TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (waktu != null) {
      setState(() {
        waktuPengingat = waktu;
      });
    }
  }

  // Format tanggal Indonesia
  String formatTanggal(DateTime tanggal) {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${tanggal.day} ${bulan[tanggal.month - 1]} ${tanggal.year}';
  }

  // Format waktu
  String formatWaktu(TimeOfDay waktu) {
    final jam = waktu.hourOfPeriod.toString().padLeft(2, '0');
    final menit = waktu.minute.toString().padLeft(2, '0');
    final periode = waktu.period == DayPeriod.am ? 'AM' : 'PM';

    return '$jam:$menit $periode';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(halamanAktif),
        backgroundColor: modeGelap ? Colors.grey[900] : Colors.blue,
        foregroundColor: Colors.white,
      ),

      // DRAWER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: modeGelap ? Colors.grey[900] : Colors.blue,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.menu,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Form Input Interaktif',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tugas 7 Flutter',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // MENU CHECKBOX
            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text('Syarat & Ketentuan'),
              selected: halamanAktif == 'Syarat & Ketentuan',
              onTap: () {
                pilihMenu('Syarat & Ketentuan');
              },
            ),

            // MENU SWITCH
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Mode Gelap'),
              selected: halamanAktif == 'Mode Gelap',
              onTap: () {
                pilihMenu('Mode Gelap');
              },
            ),

            // MENU DROPDOWN
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Pilih Kategori Produk'),
              selected: halamanAktif == 'Pilih Kategori Produk',
              onTap: () {
                pilihMenu('Pilih Kategori Produk');
              },
            ),

            // MENU TANGGAL
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Pilih Tanggal Lahir'),
              selected: halamanAktif == 'Pilih Tanggal Lahir',
              onTap: () {
                pilihMenu('Pilih Tanggal Lahir');
              },
            ),

            // MENU JAM
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Atur Pengingat'),
              selected: halamanAktif == 'Atur Pengingat',
              onTap: () {
                pilihMenu('Atur Pengingat');
              },
            ),
          ],
        ),
      ),

      // BODY
      body: Container(
        color: modeGelap ? Colors.grey[900] : Colors.white,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: buildHalaman(),
        ),
      ),
    );
  }

  // Menampilkan halaman sesuai menu
  Widget buildHalaman() {
    switch (halamanAktif) {
      case 'Syarat & Ketentuan':
        return buildCheckbox();

      case 'Mode Gelap':
        return buildSwitch();

      case 'Pilih Kategori Produk':
        return buildDropdown();

      case 'Pilih Tanggal Lahir':
        return buildDatePicker();

      case 'Atur Pengingat':
        return buildTimePicker();

      default:
        return buildCheckbox();
    }
  }

  // =========================
  // CHECKBOX
  // =========================
  Widget buildCheckbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_box,
          size: 60,
          color: Colors.blue,
        ),

        const SizedBox(height: 15),

        const Text(
          'Syarat & Ketentuan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: CheckboxListTile(
            title: const Text(
              'Saya menyetujui semua persyaratan yang berlaku',
            ),
            value: setuju,
            onChanged: (value) {
              setState(() {
                setuju = value ?? false;
              });
            },
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Hasil:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          setuju
              ? 'Lanjutkan pendaftaran diperbolehkan'
              : 'Anda belum bisa melanjutkan',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: setuju ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  // =========================
  // SWITCH
  // =========================
  Widget buildSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.dark_mode,
          size: 60,
          color: modeGelap ? Colors.white : Colors.blue,
        ),

        const SizedBox(height: 15),

        Text(
          'Mode Gelap',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: modeGelap ? Colors.white : Colors.black,
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: SwitchListTile(
            title: const Text('Aktifkan Mode Gelap'),
            value: modeGelap,
            onChanged: (value) {
              setState(() {
                modeGelap = value;
              });
            },
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Hasil:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: modeGelap ? Colors.white : Colors.black,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          modeGelap ? 'Mode Gelap Aktif' : 'Mode Terang Aktif',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: modeGelap ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  // =========================
  // DROPDOWN
  // =========================
  Widget buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.category,
          size: 60,
          color: Colors.blue,
        ),

        const SizedBox(height: 15),

        const Text(
          'Pilih Kategori Produk',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Kategori Produk',
            border: OutlineInputBorder(),
          ),
          value: kategori,
          hint: const Text('Pilih kategori'),
          items: const [
            DropdownMenuItem(
              value: 'Elektronik',
              child: Text('Elektronik'),
            ),
            DropdownMenuItem(
              value: 'Pakaian',
              child: Text('Pakaian'),
            ),
            DropdownMenuItem(
              value: 'Makanan',
              child: Text('Makanan'),
            ),
            DropdownMenuItem(
              value: 'Lainnya',
              child: Text('Lainnya'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              kategori = value;
            });
          },
        ),

        const SizedBox(height: 20),

        const Text(
          'Hasil:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          kategori != null
              ? 'Anda memilih kategori: $kategori'
              : 'Belum ada kategori yang dipilih',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // =========================
  // DATE PICKER
  // =========================
  Widget buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.calendar_month,
          size: 60,
          color: Colors.blue,
        ),

        const SizedBox(height: 15),

        const Text(
          'Pilih Tanggal Lahir',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton.icon(
          onPressed: pilihTanggal,
          icon: const Icon(Icons.calendar_today),
          label: const Text('Pilih Tanggal Lahir'),
        ),

        const SizedBox(height: 20),

        const Text(
          'Hasil:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          tanggalLahir != null
              ? 'Tanggal Lahir: ${formatTanggal(tanggalLahir!)}'
              : 'Tanggal lahir belum dipilih',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // =========================
  // TIME PICKER
  // =========================
  Widget buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.access_time,
          size: 60,
          color: Colors.blue,
        ),

        const SizedBox(height: 15),

        const Text(
          'Atur Pengingat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton.icon(
          onPressed: pilihWaktu,
          icon: const Icon(Icons.access_time),
          label: const Text('Pilih Waktu Pengingat'),
        ),

        const SizedBox(height: 20),

        const Text(
          'Hasil:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          waktuPengingat != null
              ? 'Pengingat diatur pukul: ${formatWaktu(waktuPengingat!)}'
              : 'Waktu pengingat belum dipilih',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

