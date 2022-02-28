import 'package:flutter/material.dart';

class NoPDFWidget extends StatelessWidget {
  NoPDFWidget({
    Key? key,
    required this.value,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  var value;

  @override
  Widget build(BuildContext context) {
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
  }
}
