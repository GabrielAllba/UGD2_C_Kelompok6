import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd2_c_kelompok6/components/pdf/custom_row_invoice.dart';
import 'package:ugd2_c_kelompok6/components/pdf/item_doc.dart';

Future<void> createPdf(
  String tipe,
  String checkin,
  String checkout,
  String harga_dasar,
  String harga,
  String username,
  String email,
  String no_telpon,
  BuildContext context,
) async {
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  final doc = pw.Document();

  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
          ),
        ),
      );
    },
  );

  DateTime checkinDate = DateTime.parse(checkin);
  DateTime checkoutDate = DateTime.parse(checkout);

  List<String> dateList = [];

  for (DateTime date = checkinDate;
      date.isBefore(checkoutDate) || date.isAtSameMomentAs(checkoutDate);
      date = date.add(Duration(days: 1))) {
    String formattedDate =
        "${date.day} ${_getMonthName(date.month)} ${date.year}";
    dateList.add(formattedDate);
  }

  // Print the list
  dateList.forEach((date) => print(date));

  // Add the checkout date to the list
  dateList.add(checkout);
  final List<CustomRow> elements = [
    CustomRow("Tanggal", "Jumlah", "Harga"),
    for (var product in dateList)
      CustomRow(
        product.toString(),
        '1',
        harga_dasar.toString(),
      ),
    CustomRow(
      "Total",
      "",
      "Rp ${harga}",
    )
  ];

  pw.Widget table = itemColumn(elements);
  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      header: (pw.Context context) {
        return headerPDF();
      },
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                personalDataFromInput(username, email, no_telpon),
                pw.SizedBox(height: 10.h),
                pw.SizedBox(height: 5.h),
                contentOfInvoice(table),
                pw.SizedBox(height: 1.h),
              ],
            ),
          ),
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
            color: PdfColor.fromHex('#FFBD59'),
            child: footerPDF(formattedDate));
      },
    ),
  );
}

pw.Header headerPDF() {
  return pw.Header(
      margin: pw.EdgeInsets.zero,
      outlineColor: PdfColors.amber50,
      outlineStyle: PdfOutlineStyle.normal,
      level: 5,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.rectangle,
        gradient: pw.LinearGradient(
          colors: [PdfColor.fromHex('#FCDF8A'), PdfColor.fromHex('#F38381')],
          begin: pw.Alignment.topLeft,
          end: pw.Alignment.bottomRight,
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          '-Modul 8 Library-',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ));
}

pw.Padding personalDataFromInput(
  String username,
  String email,
  String no_telpon,
) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 5.h, vertical: 1.h),
    child: pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                'Username',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                username,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                'Email',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                email,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                'No Telpon',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                no_telpon,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

pw.Padding topOfInvoice(pw.MemoryImage imageInvoice) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Image(imageInvoice, height: 30.h, width: 30.w),
        pw.Expanded(
          child: pw.Container(
            height: 10.h,
            decoration: const pw.BoxDecoration(
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                color: PdfColors.amberAccent),
            padding: const pw.EdgeInsets.only(
                left: 40, top: 10, bottom: 10, right: 40),
            alignment: pw.Alignment.centerLeft,
            child: pw.DefaultTextStyle(
              style:
                  const pw.TextStyle(color: PdfColors.amber100, fontSize: 12),
              child: pw.GridView(
                crossAxisCount: 2,
                children: [
                  pw.Text('Awesome Product',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.Text('Anggrek Street 12',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Jakarta 5111',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1.h),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Contact Us',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Phone Number',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.Text('0812345678',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.Text('Email',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.Text('awesomeproduct@gmail.conm',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Padding contentOfInvoice(pw.Widget table) {
  return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Column(children: [
        pw.Text(
            "Dear Customer, thank you for buying our product. we hope the products can make your day."),
        pw.SizedBox(height: 3.h),
        table,
        pw.Text("Thanks for your trust, and till the next time."),
        pw.SizedBox(height: 3.h),
        pw.Text("Kind regards,"),
        pw.SizedBox(height: 3.h),
        pw.Text("1150"),
      ]));
}

pw.Center footerPDF(String formattedDate) => pw.Center(
    child: pw.Text('Created At $formattedDate',
        style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue)));

String _getMonthName(int month) {
  final List<String> monthNames = [
    "", // Index 0 is not used
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  return monthNames[month];
}
