import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_destination.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  List destinations = [];

  @override
  void initState() {
    super.initState();
    fetchDestinations();
  }

  // Fungsi untuk menghapus destinasi berdasarkan ID
  Future<void> deleteDestination(String destinationId) async {
    final url = Uri.parse('http://localhost:3000/destinations/$destinationId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Destinasi berhasil dihapus',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
      fetchDestinations(); // Memperbarui tampilan setelah penghapusan
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menghapus destinasi',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    }
  }

  // Menampilkan dialog konfirmasi sebelum menghapus destinasi
  void showDeleteConfirmation(String destinationId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi Penghapusan',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus destinasi ini?',
            style: GoogleFonts.poppins(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog tanpa menghapus
              },
              child: Text('Batal', style: GoogleFonts.poppins()),
            ),
            TextButton(
              onPressed: () {
                deleteDestination(destinationId); // Menghapus destinasi
                Navigator.of(context).pop(); // Menutup dialog setelah menghapus
              },
              child: Text(
                'Hapus',
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mendapatkan daftar destinasi (misalnya dari API)
  Future<void> fetchDestinations() async {
    final url = Uri.parse('http://localhost:3000/destinations');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          destinations = json.decode(response.body);
          print(destinations); // DEBUG: Cetak data destinasi
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal memuat daftar destinasi: ${response.reasonPhrase}',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan saat memuat data',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      print("Error fetching destinations: $e");
    }
  }

  // Fungsi untuk menampilkan dialog edit
  void showEditDialog(dynamic destination) {
    final TextEditingController editNameController = TextEditingController(
      text: destination['name'],
    );
    final TextEditingController editDateController = TextEditingController(
      text: destination['date'],
    ); // Perlu format yang benar

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Destinasi',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: editNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Tempat',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: editDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Trip',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    locale: const Locale('id'),
                  );

                  if (picked != null) {
                    final start = DateFormat('dd/MM/yyyy').format(picked.start);
                    final end = DateFormat('dd/MM/yyyy').format(picked.end);
                    setState(() {
                      editDateController.text = "$start - $end";
                    });
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal', style: GoogleFonts.poppins()),
            ),
            TextButton(
              onPressed: () async {
                final updatedName = editNameController.text;
                final updatedDate = editDateController.text;

                final url = Uri.parse(
                  'http://localhost:3000/destinations/${destination['_id']}',
                );
                final response = await http.put(
                  url,
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({'name': updatedName, 'date': updatedDate}),
                );

                if (response.statusCode == 200) {
                  Navigator.of(context).pop();
                  fetchDestinations();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Destinasi berhasil diperbarui',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Gagal memperbarui destinasi',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                }
              },
              child: Text(
                'Simpan',
                style: GoogleFonts.poppins(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF8DC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEF8DC),
        elevation: 0,
        title: Text(
          'List Destinasimu',
          style: GoogleFonts.poppins(
            color: const Color(0xFF225B75),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body:
          destinations.isEmpty
              ? Center(
                child: Text(
                  'Belum ada destinasi',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF225B75),
                  ),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  final destination = destinations[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF8DC),
                      border: Border.all(color: const Color(0xFF225B75)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 32,
                          color: Color(0xFF225B75),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          destination['name'],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xFF225B75),
                          ),
                        ),
                        const SizedBox(height: 4),
                        RepaintBoundary(
                          child: Row(
                            mainAxisSize:
                                MainAxisSize
                                    .min, // Coba ubah ke mainAxisSize: MainAxisSize.max,
                            children: [
                              // SizedBox( // Coba bungkus dengan SizedBox
                              //   width: 24,
                              //   height: 24,
                              const Icon(
                                Icons.calendar_today,
                                key: ValueKey('calendar_icon'), // Tambahkan key
                                size: 14,
                                color: Color(0xFF225B75),
                              ),
                              // ),
                              const SizedBox(width: 4),
                              Text(
                                destination['date'],
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF225B75),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              label: Text('Edit', style: GoogleFonts.poppins()),
                              onPressed: () {
                                showEditDialog(destination);
                              },
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: Text(
                                'Hapus',
                                style: GoogleFonts.poppins(),
                              ),
                              onPressed: () {
                                showDeleteConfirmation(destination['_id']);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF225B75),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDestination()),
          );
          fetchDestinations();
        },
      ),
    );
  }
}
