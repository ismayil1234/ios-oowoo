import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfOrDocumentProvider extends ChangeNotifier {
  PDFDocument pdfDocument;
  Map<String, dynamic> fileNameAsUrlAndTypeToDownload = {};
  String downloadPercentage;
  String storedPath;
  void getPdfDocument(PDFDocument pdfDocumen) {
    pdfDocument = pdfDocumen;
    notifyListeners();
  }

  void getFileNameAsUrlAndTypeToDownload(
      Map<String, dynamic> fileNameAsUrlAndTyp) {
    fileNameAsUrlAndTypeToDownload = fileNameAsUrlAndTyp;
    notifyListeners();
  }

  void updateDownloadPercentage(String percentage) {
    downloadPercentage = percentage;
    notifyListeners();
  }

  void getStoredPath(String path) {
    storedPath = path;
    notifyListeners();
  }
}
