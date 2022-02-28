import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../components/drawer_component.dart';
import '../controllers/pdf_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ignore: prefer_typing_uninitialized_variables
var getFile;

class _MyHomePageState extends State<MyHomePage> {
  PdfViewerController? pdfViewerController;

  getSharedFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      getFile = prefs.getString('filePath');
    });
  }

  @override
  void didChangeDependencies() {
    pdfViewerController = PdfViewerController();

    getSharedFile();
    super.didChangeDependencies();
  }

  final TextEditingController _pageController = TextEditingController();
  final GlobalKey<SfPdfViewerState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<PdfController>(context);

    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: AppBar(
        title: const Text('Nimu PDF Viewer'),
        backgroundColor: Colors.redAccent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openBookmarkView();
            },
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<PdfController>(builder: (context, value, _) {
            return getFile == null
                ? Consumer<PdfController>(builder: (context, val, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'No PDF file selected',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Tap on the button below to select a PDF file',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            value.filePicker(context);
                          },
                          child: Center(
                            child: Container(
                              height: 52,
                              width: MediaQuery.of(context).size.width / 1.4,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Center(
                                  child: Text(
                                'Pick File from Storage',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                : Expanded(
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
                            const SnackBar(
                                content: Text('Failed to load file')));
                      },
                      onDocumentLoaded: (document) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'File Loaded Successfully, Please wait...')));
                      },
                    ),
                  );
          }),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.teal,
        elevation: 2,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.zoom_in,
              size: 30,
              color: Colors.white,
            ),
            backgroundColor: Colors.redAccent.shade400,
            labelStyle: const TextStyle(fontSize: 16),
            label: 'Zoom In',
            onTap: () {
              pdfViewerController!.zoomLevel = 1.30;
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.zoom_out,
              size: 30,
              color: Colors.white,
            ),
            backgroundColor: Colors.redAccent.shade400,
            label: 'Zoom Out',
            labelStyle: const TextStyle(fontSize: 16),
            onTap: () {
              pdfViewerController!.zoomLevel = 0.70;
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.find_in_page,
              size: 30,
              color: Colors.white,
            ),
            backgroundColor: Colors.redAccent.shade400,
            labelStyle: const TextStyle(fontSize: 16),
            label: 'Jump To Page',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Jump to page'),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _pageController,
                          decoration: const InputDecoration(
                            hintText: 'Enter page number',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            value.jumpTo(
                                context,
                                int.parse(_pageController.text),
                                pdfViewerController);
                          },
                          child: const Text('Jump To'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.open_in_browser,
              size: 30,
              color: Colors.white,
            ),
            backgroundColor: Colors.redAccent.shade400,
            labelStyle: const TextStyle(fontSize: 16),
            label: 'Open Another File',
            onTap: () {
              value.filePicker(context);
            },
          ),
        ],
      ),
    );
  }
}
