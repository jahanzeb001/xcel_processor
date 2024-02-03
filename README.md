# xcel_processor

A Flutter package for processing data from Excel files. This package provides a simple and efficient way to integrate Excel data processing into your Flutter applications.

## Features

- Read data from specified rows and columns in Excel files.
- Simple and efficient integration into Flutter applications.

## Getting Started

To use this package, add the following dependency to your `pubspec.yaml` file:

## Usage

Minimal example:

```dart
import 'package:flutter/material.dart';
import 'package:xcel_processor/xcel_processor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xcel Processor Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var result = await ExcelProcessor.pickAndReadExcel('YourTable', 1, 2);
            _showResultDialog(context, result);
          },
          child: Text('Pick and Process Excel'),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context, Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xcel Processor Result'),
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
              child: Text('Close'),
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

```
