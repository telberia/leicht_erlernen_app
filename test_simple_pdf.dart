import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(const TestPdfApp());
}

class TestPdfApp extends StatelessWidget {
  const TestPdfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Test',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PDF Test - Lektion 1'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const TestPdfViewer(),
      ),
    );
  }
}

class TestPdfViewer extends StatelessWidget {
  const TestPdfViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.asset(
      'assets/App-data/Lektion_1/vt1_eBook_Lektion_1.pdf',
      onDocumentLoaded: (PdfDocumentLoadedDetails details) {
        print('✅ PDF loaded: ${details.document.pages.count} pages');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ PDF loaded: ${details.document.pages.count} pages'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
        print('❌ PDF failed: ${details.error}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ PDF failed: ${details.error}'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
} 