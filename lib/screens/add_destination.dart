import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddDestination extends StatefulWidget {
  const AddDestination({super.key});

  @override
  State<AddDestination> createState() => _AddDestinationState();
}

class _AddDestinationState extends State<AddDestination> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> submitDestination() async {
    final url = Uri.parse('http://localhost:3000/destinations');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': nameController.text,
        'date': dateController.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Destinasi berhasil ditambahkan")));
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal menambahkan destinasi")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Destinasi'),
        backgroundColor: Color.fromARGB(255, 34, 102, 141),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Tempat',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Perjalanan (YYYY-MM-DD)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: submitDestination,
              child: Text('Simpan', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
