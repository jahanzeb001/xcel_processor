library xcel_processor;

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

class ExcelProcessor {
  static Future<Map<String, dynamic>> pickAndReadExcel(
      String tableName, int rows, int column) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      var file = result.files.first;

      try {
        var bytes = File(file.path!).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        for (var table in excel.tables.keys) {
          if (table == tableName) {
            int desiredRow = rows;
            int desiredColumn = column;

            if (desiredRow <= excel.tables[table]!.maxRows &&
                desiredColumn < excel.tables[table]!.maxColumns) {
              var cell =
                  excel.tables[table]!.rows[desiredRow - 1][desiredColumn];
              var cellValue = cell?.value;

              if (cellValue != null) {
                String columnName =
                    String.fromCharCode('A'.codeUnitAt(0) + desiredColumn);

                return {
                  'tableName': tableName,
                  'row': desiredRow,
                  'column': columnName,
                  'data': cellValue.toString(),
                };
              } else {
                return {
                  'error':
                      'Cell at Row $desiredRow, Column $desiredColumn is empty.',
                };
              }
            } else {
              return {
                'error': 'Invalid row or column specified.',
              };
            }
          }
        }

        return {
          'error': 'Table $tableName does not exist.',
        };
      } catch (e) {
        return {
          'error': 'Error reading Excel file: $e',
        };
      }
    } else {
      return {
        'error': 'File picking canceled.',
      };
    }
  }
}
