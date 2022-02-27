import 'package:flutter/material.dart';
import 'package:nimu_pdf_reader/controllers/pdf_controller.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PdfController>(
          create: (_) => PdfController(),
        ),
      ],
      child: MaterialApp(
        title: 'Nimu PDF Reader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
