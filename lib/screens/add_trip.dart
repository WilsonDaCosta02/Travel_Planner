import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTrip extends StatefulWidget {
  const AddTrip({super.key});

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Future<void> submitTrip() async {
  final title = titleController.text;
  final startDate = startDateController.text;
  final endDate = endDateController.text;

  // Validasi input
  if (title.isEmpty || startDate.isEmpty || endDate.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Semua field harus diisi!")),
    );
    return;
  }

  // Validasi format tanggal
  final dateFormat = RegExp(r'^\d{4}-\d{2}-\d{2}$'); // YYYY-MM-DD
  if (!dateFormat.hasMatch(startDate) || !dateFormat.hasMatch(endDate)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Format tanggal harus YYYY-MM-DD")),
    );
    return;
  }

  // Cek apakah tanggal mulai lebih besar dari tanggal akhir
  if (DateTime.parse(startDate).isAfter(DateTime.parse(endDate))) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tanggal mulai tidak boleh lebih besar dari tanggal akhir")),
    );
    return;
  }

  final url = Uri.parse('http://localhost:3000/trips');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'destinations': [],
    }),
  );

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Trip berhasil ditambahkan")),
    );
    Navigator.pop(context); // kembali ke halaman daftar trip
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Gagal menambahkan trip")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Trip'),
        backgroundColor: Color.fromARGB(255, 34, 102, 141),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Judul Trip',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: startDateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Mulai (YYYY-MM-DD)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: endDateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Akhir (YYYY-MM-DD)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: submitTrip,
              child: Text('Simpan', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
