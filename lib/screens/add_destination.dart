import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AddDestination extends StatefulWidget {
  const AddDestination({super.key});

  @override
  State<AddDestination> createState() => _AddDestinationState();
}

class _AddDestinationState extends State<AddDestination> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool _isLoading = false;

  Future<void> addDestination() async {
    setState(() {
      _isLoading = true;
    });

    final name = nameController.text;
    final dateRange = dateController.text;

    if (name.isEmpty || dateRange.isEmpty || !dateRange.contains(" - ")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nama dan rentang tanggal harus diisi dengan benar',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final parts = dateRange.split(" - ");
    if (parts.length != 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Format tanggal tidak valid',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final startDate = DateFormat('dd/MM/yyyy').parse(parts[0].trim());
      final endDate = DateFormat('dd/MM/yyyy').parse(parts[1].trim());

      final formattedDateRange =
          "${DateFormat('yyyy-MM-dd').format(startDate)} - ${DateFormat('yyyy-MM-dd').format(endDate)}";

      final url = Uri.parse('http://localhost:3000/destinations');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'date': formattedDateRange}),
      );

      if (response.statusCode == 201) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Destinasi berhasil ditambahkan!',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal menambahkan destinasi: ${response.reasonPhrase}',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan saat memproses tanggal',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      print("Error parsing date: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF8DC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tambah Destinasimu',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF225B75),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF225B75)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nama Tempat',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFFB0B0B0),
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF225B75)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tanggal Trip (DD/MM/YYYY - DD/MM/YYYY)',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFFB0B0B0),
                      ),
                      suffixIcon: Icon(Icons.calendar_today), // Tambahkan ini
                    ),
                    style: GoogleFonts.poppins(),
                    onTap: () async {
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        locale: const Locale('id'),
                      );

                      if (picked != null) {
                        final start = DateFormat(
                          'dd/MM/yyyy',
                        ).format(picked.start);
                        final end = DateFormat('dd/MM/yyyy').format(picked.end);
                        setState(() {
                          dateController.text = "$start - $end";
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF225B75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: _isLoading ? null : addDestination,
                    child: Text(
                      _isLoading ? 'Menyimpan...' : 'Simpan',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
