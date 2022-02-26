import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nimu_pdf_reader/screens/about_us.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controllers/pdf_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'logo/logo.png',
                  height: 180,
                  width: 180,
                ),
              ),
              const Divider(
                height: 1,
              ),
              ListTile(
                title: const Text('Home',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Rate Us',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Share',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {},
              ),
              ListTile(
                title: const Text('About',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => const AboutUs()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Nimu PDF Viewer'),
          backgroundColor: Colors.redAccent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                if (value == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No PDF file selected')));
                } else {
                  return _scaffoldKey.currentState!.openBookmarkView();
                }
              },
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
                size: 30,
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) => AlertDialog(
            //         title: const Text('Jump to page'),
            //         content: SizedBox(
            //           height: MediaQuery.of(context).size.height / 6.5,
            //           child: Column(
            //             children: [
            //               TextFormField(
            //                 controller: _pageController,
            //                 decoration: const InputDecoration(
            //                   hintText: 'Enter page number',
            //                 ),
            //                 keyboardType: TextInputType.number,
            //               ),
            //               const SizedBox(
            //                 height: 15,
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {
            //                   value.jumpTo(
            //                       context,
            //                       int.parse(_pageController.text),
            //                       pdfViewerController);
            //                 },
            //                 child: const Text('Jump To'),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            //   icon: const Icon(
            //     Icons.find_in_page,
            //     color: Colors.white,
            //     size: 30,
            //   ),
            // ),
          ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<PdfController>(builder: (context, value, _) {
              return getFile == null
                  ? Consumer<PdfController>(builder: (context, val, _) {
                      return GestureDetector(
                        onTap: () async {
                          value.filePicker(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text(
                                'No file selected',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.4,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
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
                                  'Pick File',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
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
          backgroundColor: Colors.red,
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
        ));
  }
}
