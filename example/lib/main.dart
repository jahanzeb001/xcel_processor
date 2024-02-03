// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:xcel_processor/xcel_processor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xcel Processor Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var result =
                await ExcelProcessor.pickAndReadExcel('YourTable', 1, 2);
            _showResultDialog(context, result);
          },
          child: const Text('Pick and Process Excel'),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context, Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xcel Processor Result'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: _buildResultWidgets(result),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildResultWidgets(Map<String, dynamic> result) {
    if (result.containsKey('error')) {
      return [
        Text('Error: ${result['error']}'),
      ];
    } else {
      return [
        Text('Table Name: ${result['tableName']}'),
        Text('Row: ${result['row']}'),
        Text('Column: ${result['column']}'),
        Text('Data: ${result['data']}'),
      ];
    }
  }
}
