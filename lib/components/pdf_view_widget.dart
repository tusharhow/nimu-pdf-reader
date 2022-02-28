import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewWidget extends StatelessWidget {
  const PDFViewWidget({
    Key? key,
    required GlobalKey<SfPdfViewerState> scaffoldKey,
    required this.pdfViewerController,
    required this.getFile,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<SfPdfViewerState> _scaffoldKey;
  final PdfViewerController? pdfViewerController;
  final getFile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfPdfViewer.file(
        File(getFile),
        key: _scaffoldKey,
        controller: pdfViewerController,
        onPageChanged: (page) {},
        onTextSelectionChanged: (text) {},
        currentSearchTextHighlightColor: Colors.red,
        initialZoomLevel: 1.30,
        enableDocumentLinkAnnotation: true,
        canShowScrollStatus: true,
        enableDoubleTapZooming: true,
        canShowPaginationDialog: true,
        canShowScrollHead: true,
        enableTextSelection: true,
        interactionMode: PdfInteractionMode.selection,
        onDocumentLoadFailed: (exception) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to load file')));
        },
        onDocumentLoaded: (document) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('File Loaded Successfully, Please wait...')));
        },
      ),
    );
  }
}
