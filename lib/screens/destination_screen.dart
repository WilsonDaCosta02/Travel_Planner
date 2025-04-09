import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_destination.dart';

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
    final url = Uri.parse(
      'http://localhost:3000/destinations',
    ); // Ganti IP jika perlu
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        destinations = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal memuat data destinasi")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Perjalanan'),
        backgroundColor: Color.fromARGB(255, 34, 102, 141),
      ),
      body:
          destinations.isEmpty
              ? Center(child: Text('Belum ada perjalanan'))
              : ListView.builder(
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  final item = destinations[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.place, color: Colors.blue),
                      title: Text(item['name']),
                      subtitle: Text('Tanggal: ${item['date']}'),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDestination()),
          );
          fetchDestinations(); // Refresh list setelah kembali
        },
      ),
    );
  }
}
