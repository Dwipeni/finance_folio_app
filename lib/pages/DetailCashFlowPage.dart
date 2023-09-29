import 'package:finance_folio_app/constant/finance_type_constants.dart';
import 'package:finance_folio_app/helper/dbhelper.dart';
import 'package:finance_folio_app/models/finance.dart';
import 'package:flutter/material.dart';

class DetailCashFlowPage extends StatefulWidget {
  @override
  _DetailCashFlowPageState createState() => _DetailCashFlowPageState();
}

class _DetailCashFlowPageState extends State<DetailCashFlowPage> {
  List<Finance> cashFlowData = [];

  @override
  void initState() {
    super.initState();
    _fetchCashFlowData();
  }

  Future<void> _fetchCashFlowData() async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database
    List<Finance> data = await dbHelper.getFinance();

    setState(() {
      cashFlowData = data;
    });
  }

  Future<void> _deleteItem(int index) async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database

    // Delete the item from the database
    await dbHelper.deleteDataFinance(cashFlowData[index].id!);

    // Remove the item from the list
    setState(() {
      cashFlowData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Cash Flow"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "Detail Cash Flow",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.left,
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: cashFlowData.length,
            itemBuilder: (context, index) {
              final item = cashFlowData[index];
              final isIncome = item.type == incomeType;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: ListTile(
              leading: Icon(
                isIncome ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                color: isIncome ? Colors.green : Colors.red,
              ),
              title: Text(item.date!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${isIncome ? 'Income' : 'Expense'}: ${item.amount}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Description: ${item.description}",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: () async {
                  _deleteItem(index);
                },
                child: Icon(Icons.delete, color: Colors.red),
              ),
            ),
          );
        },
      ),
    ),
    Container(
      width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman Home
            },
              style: ButtonStyle(
                  backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)))),
                  child: const Text("<< Back"),
                ),
              ),
      ],
      ),
    );
  }
}