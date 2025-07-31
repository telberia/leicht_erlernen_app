import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../services/assets_service.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart' show kIsWeb;

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
  String? _pdfPath;
  String? _errorMessage;
  List<String> _debugInfo = [];

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _debugInfo.clear();
    });

    try {
      _debugInfo.add('🔍 Searching for PDF files for Lektion ${widget.lessonNumber}...');
      _debugInfo.add('🌐 Running on: ${kIsWeb ? 'Web' : 'Mobile'}');
      
      // SIMPLE APPROACH: Try to load PDF directly first
      String directPath = 'App-data/Lektion_${widget.lessonNumber}/vt1_eBook_Lektion_${widget.lessonNumber}.pdf';
      _debugInfo.add('🎯 Trying direct path: $directPath');
      
      try {
        await rootBundle.load(directPath);
        _debugInfo.add('✅ Direct path works!');
        setState(() {
          _pdfPath = directPath;
          _isLoading = false;
        });
        return; // Success! Exit early
      } catch (e) {
        _debugInfo.add('❌ Direct path failed: $e');
      }
      
      // First, check AssetManifest.json
      _debugInfo.add('📋 Checking AssetManifest.json...');
      try {
        final manifestContent = await rootBundle.loadString('AssetManifest.json');
        _debugInfo.add('✅ AssetManifest.json loaded (${manifestContent.length} chars)');
        
        // Look for our PDF in the manifest
        if (manifestContent.contains('vt1_eBook_Lektion_${widget.lessonNumber}.pdf')) {
          _debugInfo.add('✅ PDF found in manifest!');
        } else {
          _debugInfo.add('❌ PDF not found in manifest');
          // Show what's actually in the manifest
          if (manifestContent.contains('App-data')) {
            _debugInfo.add('📄 Found App-data entries in manifest');
          } else {
            _debugInfo.add('❌ No App-data entries found in manifest');
          }
        }
      } catch (e) {
        _debugInfo.add('❌ Failed to load AssetManifest.json: $e');
      }
      
      // Test basic asset loading
      _debugInfo.add('🧪 Testing basic asset loading...');
      try {
        await rootBundle.load('App-data/Lektion_1/vt1_eBook_Lektion_1.pdf');
        _debugInfo.add('✅ Basic asset loading works!');
      } catch (e) {
        _debugInfo.add('❌ Basic asset loading failed: $e');
      }
      
      // Get all possible PDF paths
      List<String> pdfPaths = AssetsService.getPdfPaths(widget.lessonNumber);
      _debugInfo.add('📋 Checking ${pdfPaths.length} possible PDF paths (including URL encoding):');
      
      for (String path in pdfPaths) {
        _debugInfo.add('  - $path');
      }
      
      // Check PDF files specifically
      Map<String, bool> pdfCheck = await AssetsService.checkPdfFiles(widget.lessonNumber);
      _debugInfo.add('📄 PDF file check:');
      pdfCheck.forEach((path, exists) {
        _debugInfo.add('  - $path: ${exists ? "✅" : "❌"}');
      });
      
      // Check directory structure
      Map<String, bool> dirCheck = await AssetsService.checkLessonDirectories(widget.lessonNumber);
      _debugInfo.add('📁 Directory check for Lektion ${widget.lessonNumber}:');
      dirCheck.forEach((dir, exists) {
        _debugInfo.add('  - $dir: ${exists ? "✅" : "❌"}');
      });
      
      String? pdfPath = await AssetsService.getAvailablePdfPath(widget.lessonNumber);
      
      if (pdfPath != null) {
        _debugInfo.add('✅ Found PDF at: $pdfPath');
        setState(() {
          _pdfPath = pdfPath;
          _isLoading = false;
        });
      } else {
        _debugInfo.add('❌ No PDF found in any of the expected paths');
        _debugInfo.add('💡 This might be a URL encoding issue in Flutter Web');
        setState(() {
          _isLoading = false;
          _errorMessage = 'PDF-Datei für Lektion ${widget.lessonNumber} nicht gefunden';
        });
      }
    } catch (e) {
      _debugInfo.add('❌ Error during PDF search: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Fehler beim Laden der PDF-Datei: $e';
      });
    }
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
            onPressed: _loadPdf,
            icon: const Icon(Icons.refresh),
            tooltip: 'PDF neu laden',
          ),
          IconButton(
            onPressed: _showDebugInfo,
            icon: const Icon(Icons.bug_report),
            tooltip: 'Debug Info',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  void _showDebugInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Debug Information'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Lektion: ${widget.lessonNumber}'),
              const SizedBox(height: 8),
              Text('PDF Path: ${_pdfPath ?? 'Not found'}'),
              const SizedBox(height: 8),
              Text('Error: ${_errorMessage ?? 'None'}'),
              const SizedBox(height: 16),
              const Text('Debug Log:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ..._debugInfo.map((info) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(info, style: const TextStyle(fontSize: 12)),
              )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Test all variations
              await AssetsService.testAllVariations(widget.lessonNumber);
              Navigator.pop(context);
            },
            child: const Text('Test All Paths'),
          ),
          TextButton(
            onPressed: () async {
              // Show AssetManifest.json
              try {
                final manifestContent = await rootBundle.loadString('AssetManifest.json');
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('AssetManifest.json'),
                    content: SingleChildScrollView(
                      child: Text(manifestContent, style: const TextStyle(fontSize: 10)),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to load manifest: $e')),
                );
              }
            },
            child: const Text('Show Manifest'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Schließen'),
          ),
        ],
      ),
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

    if (_pdfPath != null) {
      return SfPdfViewer.asset(
        _pdfPath!,
        canShowPaginationDialog: true,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          print('✅ PDF loaded successfully: ${details.document.pages.count} pages');
          _debugInfo.add('✅ PDF loaded successfully: ${details.document.pages.count} pages');
        },
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          print('❌ PDF load failed: ${details.error}');
          _debugInfo.add('❌ PDF load failed: ${details.error}');
          setState(() {
            _errorMessage = 'PDF konnte nicht geladen werden: ${details.error}';
            _pdfPath = null;
          });
        },
      );
    }

    return _buildErrorOrFallbackContent();
  }

  Widget _buildErrorOrFallbackContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Error message if there's an error
          if (_errorMessage != null)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error, color: Colors.red.shade600),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'PDF Fehler',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          
          // Title
          Text(
            'Inhalt für Lektion ${widget.lessonNumber}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AssetsService.getLessonTitle(widget.lessonNumber),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          
          // Retry button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton.icon(
              onPressed: _loadPdf,
              icon: const Icon(Icons.refresh),
              label: const Text('PDF erneut versuchen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          
          // Fallback content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getFallbackContent(widget.lessonNumber),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text('Zurück'),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getFallbackContent(int lessonNumber) {
    switch (lessonNumber) {
      case 1:
        return [
          _buildPdfSection(
            'Grundlagen - Begrüßungen und Vorstellung',
            [
              'Hallo - Hello',
              'Guten Tag - Good day',
              'Auf Wiedersehen - Goodbye',
              'Danke - Thank you',
              'Bitte - Please',
            ],
          ),
          const SizedBox(height: 20),
          _buildPdfSection(
            'Zahlen (Zahlen)',
            [
              'Eins - One',
              'Zwei - Two',
              'Drei - Three',
              'Vier - Four',
              'Fünf - Five',
            ],
          ),
        ];
      case 2:
        return [
          _buildPdfSection(
            'Familie (Familie)',
            [
              'Mutter - Mother',
              'Vater - Father',
              'Sohn - Son',
              'Tochter - Daughter',
              'Bruder - Brother',
              'Schwester - Sister',
            ],
          ),
        ];
      case 3:
        return [
          _buildPdfSection(
            'Farben (Farben)',
            [
              'Rot - Red',
              'Blau - Blue',
              'Gelb - Yellow',
              'Grün - Green',
              'Schwarz - Black',
              'Weiß - White',
            ],
          ),
        ];
      case 4:
        return [
          _buildPdfSection(
            'Tiere (Tiere)',
            [
              'Hund - Dog',
              'Katze - Cat',
              'Pferd - Horse',
              'Kuh - Cow',
              'Schwein - Pig',
            ],
          ),
        ];
      case 5:
        return [
          _buildPdfSection(
            'Essen (Essen)',
            [
              'Brot - Bread',
              'Käse - Cheese',
              'Wurst - Sausage',
              'Apfel - Apple',
              'Banane - Banana',
            ],
          ),
        ];
      case 6:
        return [
          _buildPdfSection(
            'Warnhinweise (Warnhinweise)',
            [
              'Achtung! - Attention!',
              'Vorsicht! - Caution!',
              'Warnung! - Warning!',
            ],
          ),
          const SizedBox(height: 20),
          _buildPdfSection(
            'Zwischenübung (Zwischenübung)',
            [
              'Fotografieren verboten - Photography forbidden',
              'Schwimmen verboten - Swimming forbidden',
              'Essen und Trinken verboten - Eating and drinking forbidden',
            ],
          ),
          const SizedBox(height: 20),
          _buildPdfSection(
            'Aufforderungen im Alltag (Aufforderungen im Alltag)',
            [
              'Ihr Name bitte. - Your name please.',
              'Die Fahrkarte bitte. - The ticket please.',
              'Ihren Reisepass bitte. - Your passport please.',
              'Ihren Führerschein bitte. - Your driver license please.',
            ],
          ),
        ];
      default:
        return [
          _buildPdfSection(
            'Lektion $lessonNumber Inhalt',
            [
              'Vokabeln für Lektion $lessonNumber',
              'Grammatikübungen',
              'Hörverständnis',
              'Sprechübungen',
              'Schreibübungen',
            ],
          ),
          const SizedBox(height: 20),
          _buildPdfSection(
            'Neue Wörter',
            [
              'Wort 1 - Word 1',
              'Wort 2 - Word 2',
              'Wort 3 - Word 3',
              'Wort 4 - Word 4',
              'Wort 5 - Word 5',
            ],
          ),
        ];
    }
  }

  Widget _buildPdfSection(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              '• $item',
              style: const TextStyle(fontSize: 16),
            ),
          )),
        ],
      ),
    );
  }
} 