import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SimplePdfViewer extends StatefulWidget {
  final int lessonNumber;

  const SimplePdfViewer({
    super.key,
    required this.lessonNumber,
  });

  @override
  State<SimplePdfViewer> createState() => _SimplePdfViewerState();
}

class _SimplePdfViewerState extends State<SimplePdfViewer> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Set loading to false immediately - let SfPdfViewer handle loading
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Lektion ${widget.lessonNumber} - eBook'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isLoading = false;
                _errorMessage = null;
              });
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'PDF neu laden',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'PDF wird geladen...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // Direct PDF loading - no complex asset checking
    String pdfPath = 'assets/App-data/Lektion_${widget.lessonNumber}/vt1_eBook_Lektion_${widget.lessonNumber}.pdf';
    
    return SfPdfViewer.asset(
      pdfPath,
      canShowPaginationDialog: true,
      canShowScrollHead: true,
      canShowScrollStatus: true,
      enableDoubleTapZooming: true,
      enableTextSelection: true,
      onDocumentLoaded: (PdfDocumentLoadedDetails details) {
        print('✅ PDF loaded successfully: ${details.document.pages.count} pages');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF geladen: ${details.document.pages.count} Seiten'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
        print('❌ PDF load failed: ${details.error}');
        setState(() {
          _errorMessage = 'PDF konnte nicht geladen werden: ${details.error}';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF Fehler: ${details.error}'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
} 