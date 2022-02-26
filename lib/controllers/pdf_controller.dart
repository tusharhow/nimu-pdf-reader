import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfController extends ChangeNotifier {
  File? file;

  var mainFile;

  filePicker(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('filePath', file!.path);

      mainFile = prefs.getString('filePath');

      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No file selected')));
    }
  }

  Future jumpTo(context, int pageNumber,
      PdfViewerController? _pdfViewerController) async {
    if (pageNumber == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file number selected')));
    } else {
      _pdfViewerController!.jumpToPage(pageNumber);
    }

    Navigator.pop(context);

    notifyListeners();
  }
}
