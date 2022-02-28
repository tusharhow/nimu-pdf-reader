import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../components/drawer_component.dart';
import '../components/floating_widget.dart';
import '../components/no_pdf_widget.dart';
import '../components/pdf_view_widget.dart';
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
  final GlobalKey<ScaffoldState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final getVal = Provider.of<PdfController>(context);

    return Scaffold(
      drawer: const DrawerComponent(),
      key: _formKey,
      appBar: AppBar(
        title: const Text(
          'Nimu PDF Viewer',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.redAccent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            _formKey.currentState!.openDrawer();
          },
          child: Image.asset(
            'logo/menu.png',
            height: 30,
            width: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          getFile == null
              ? Container()
              : IconButton(
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
                    return NoPDFWidget(
                      value: value,
                    );
                  })
                : PDFViewWidget(
                    scaffoldKey: _scaffoldKey,
                    pdfViewerController: pdfViewerController,
                    getFile: getFile);
          }),
        ],
      ),
      floatingActionButton: getFile == null
          ? null
          : FloatingButtonWidget(
              pdfViewerController: pdfViewerController,
              getVal: getVal,
              pageController: _pageController,
            ),
    );
  }
}
