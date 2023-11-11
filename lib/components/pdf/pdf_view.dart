import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd2_c_kelompok6/components/pdf/custom_row_invoice.dart';
import 'package:ugd2_c_kelompok6/components/pdf/item_doc.dart';
import 'package:ugd2_c_kelompok6/components/pdf/preview_screen.dart';
import 'package:barcode_widget/barcode_widget.dart';

Future<void> createPdf(
  String tipe_kamar,
  String checkin,
  String checkout,
  String harga_dasar,
  String harga,
  String username,
  String email,
  String no_telpon,
  String id_pemesanan,
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

  int nights = checkoutDate.difference(checkinDate).inDays;

  for (int i = 0; i <= nights; i++) {
    DateTime currentDate = checkinDate.add(Duration(days: i));
  }

  String _getFormattedDate(DateTime date) {
    return "${date.day} ${_getMonthName(date.month)} ${date.year}";
  }

  String formattedCheckinCheckout =
      "${_getFormattedDate(checkinDate)} - ${_getFormattedDate(checkoutDate)}";
  dateList.add(formattedCheckinCheckout);

// Print the list
  dateList.forEach((date) => print(date));

  // Add the checkout date to the list
  final List<CustomRow> elements = [
    CustomRow("Tipe Kamar", "Tanggal", "Jumlah", "Harga"),
    for (var product in dateList)
      CustomRow(
        tipe_kamar,
        product.toString(),
        nights > 0 ? nights.toString() : '1',
        harga_dasar.toString(),
      ),
    CustomRow(
      "",
      "Total",
      "",
      "Rp ${harga}",
    )
  ];

  pw.Widget table = itemColumn(elements);

  final myFont = await PdfGoogleFonts.poppinsRegular();

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      header: (pw.Context context) {
        return headerPDF(id_pemesanan);
      },
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                personalDataFromInput(username, email, no_telpon, myFont),
                pw.SizedBox(height: 10.h),
                pw.SizedBox(height: 5.h),
                contentOfInvoice(table, myFont),
                pw.SizedBox(height: 1.h),
                barcodeGaris(id_pemesanan),
              ],
            ),
          ),
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
            color: PdfColor.fromHex('#FFBD59'),
            child: footerPDF(formattedDate, myFont));
      },
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PreviewScreen(doc: doc),
    ),
  );
}

pw.Header headerPDF(String id) {
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
          'Invoice Pembayaran Kamar',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ));
}

pw.Padding personalDataFromInput(
    String username, String email, String no_telpon, Font font) {
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
                  font: font,
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
                  font: font,
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
                  font: font,
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
                  font: font,
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
                  font: font,
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
                  font: font,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

pw.Padding topOfInvoice(pw.MemoryImage imageInvoice, Font font) {
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
                  pw.Text(
                    'Awesome Product',
                    style: pw.TextStyle(
                      fontSize: 10.sp,
                      color: PdfColors.blue800,
                      font: font,
                    ),
                  ),
                  pw.Text(
                    'Anggrek Street 12',
                    style: pw.TextStyle(
                      fontSize: 10.sp,
                      color: PdfColors.blue800,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Jakarta 5111',
                      style: pw.TextStyle(
                        fontSize: 10.sp,
                        color: PdfColors.blue800,
                        font: font,
                      )),
                  pw.SizedBox(height: 1.h),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Contact Us',
                      style: pw.TextStyle(
                        fontSize: 10.sp,
                        color: PdfColors.blue800,
                        font: font,
                      )),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Phone Number',
                      style: pw.TextStyle(
                        fontSize: 10.sp,
                        color: PdfColors.blue800,
                        font: font,
                      )),
                  pw.Text('0812345678',
                      style: pw.TextStyle(
                        fontSize: 10.sp,
                        color: PdfColors.blue800,
                        font: font,
                      )),
                  pw.Text('Email',
                      style: pw.TextStyle(
                        fontSize: 10.sp,
                        color: PdfColors.blue800,
                        font: font,
                      )),
                  pw.Text('awesomeproduct@gmail.conm',
                      style: pw.TextStyle(
                        fontSize: 10.sp,
                        color: PdfColors.blue800,
                        font: font,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Padding contentOfInvoice(pw.Widget table, Font font) {
  return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Column(children: [
        pw.Text(
          "Terima Kasih telah memilih kami! Berikut rincian pembayaran kamar hotel",
          style: pw.TextStyle(font: font),
        ),
        pw.SizedBox(height: 3.h),
        table,
        pw.SizedBox(height: 3.h),
        pw.Text(
          "Terima Kasih",
          style: pw.TextStyle(font: font),
        ),
        pw.SizedBox(height: 3.h),
        pw.Text(
          "Hormat Kami,",
          style: pw.TextStyle(font: font),
        ),
        pw.SizedBox(height: 3.h),
        pw.Text(
          "Hotel Sahid Yogyakarta",
          style: pw.TextStyle(font: font),
        ),
      ]));
}

pw.Center footerPDF(String formattedDate, Font font) => pw.Center(
    child: pw.Text('Created At $formattedDate',
        style:
            pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue, font: font)));

pw.Container barcodeGaris(String id_pemesanan) {
  return pw.Container(
      child: pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
          child: pw.BarcodeWidget(
              barcode: Barcode.code128(escapes: true),
              data: id_pemesanan,
              width: 20.w,
              height: 10.h)));
}

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
