import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/pdf_controller.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({
    Key? key,
    required this.pdfViewerController,
    required this.getVal,
    required TextEditingController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PdfViewerController? pdfViewerController;
  final PdfController getVal;
  final TextEditingController _pageController;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Colors.redAccent,
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
            Icons.delete,
            size: 30,
            color: Colors.white,
          ),
          backgroundColor: Colors.redAccent.shade400,
          labelStyle: const TextStyle(fontSize: 16),
          label: 'Remove File',
          onTap: () {
            getVal.removeFile(context);
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
                          getVal.jumpTo(
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
            getVal.filePicker(context);
          },
        ),
      ],
    );
  }
}
