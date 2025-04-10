import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_destination.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Future<void> fetchDestinations() async {
    final url = Uri.parse('http://localhost:3000/destinations');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        destinations = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal memuat destinasi")));
    }
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Text(
                          destination['date'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF225B75),
                          ),
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
