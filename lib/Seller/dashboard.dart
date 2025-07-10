import 'package:belanja/Class/userPref.dart' as userPref;
import 'package:belanja/login.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/api.dart' as api;

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardPage();
  }
}

class DashboardPage extends State<Dashboard> {
  Map<String, String?> user = {};
  Map<String, dynamic> report = {};
  
  void setData() async {
    final userdata = await userPref.getUserData();
    setState(() {
      user = userdata;
    });
  }

  void fetchData() async {
    final data = await api.getReport();
    setState(() {
      report = data;
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "WELCOME BACK",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Total Omset & Total Transaksi
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            "Total Omset",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text("Rp ${report['totalOmset'][0]['total_omset'] ?? 0}}"),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            "Total Transaksi",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text("${report['totalTransaksi'][0]['total_transaksi'] ?? 0}} transaksi"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Most Active & Top Spender
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            "Most Active Customer",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(report['memberTeraktif'][0]['name'] ?? ""),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            "Top Spender",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(report['memberTopSpender'][0]['name'] ?? ""),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Best Seller Products
            const Text(
              "Best Seller Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: report['bestSellerProduct'].length,
                itemBuilder: (context, index) {
                  final product = report['bestSellerProduct'][index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(product['name']),
                      subtitle: Text("Terjual: ${product['total_terjual']}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
