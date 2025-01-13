import 'package:get/get.dart';
import 'package:junaidtraders/models/bill_model.dart';
import 'package:junaidtraders/utils/constants.dart';
import 'package:junaidtraders/utils/extensions.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../models/customer_model.dart';

class PrintingService {
  static final PrintingService instance = PrintingService._internal();
  Printer? printer;

  factory PrintingService() {
    return instance;
  }

  PrintingService._internal();

  Future<void> init() async {
    var list = await Printing.listPrinters();
    for (var p in list) {
      if (p.isAvailable) {
        printer = p;
        printer.printInfo();
        break;
      }
    }
  }

  Future<void> printBill(Bill model) async {
    final doc = pw.Document();
    final image = await imageFromAssetBundle('assets/images/logo.png');
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.legal,
        build: (con) {
          return pw.Align(
            alignment: pw.Alignment.topCenter,
            child: pw.Container(
              width: 410,
              child: pw.Column(
                children: [
                  pw.SizedBox(height: 22),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(
                        children: [
                          getFittedContainer(
                              child: getValueText(' Date:  '), width: 40),
                          getFittedContainer(
                              child: getTitleText(
                                DateTime.now().formatedDateTime2(),
                              ),
                              width: 100),
                        ],
                      ),
                      pw.SizedBox(
                        width: 120,
                        child: Image(
                          image,
                          fit: pw.BoxFit.fitWidth,
                        ),
                      ),
                      pw.Row(
                        children: [
                          getFittedContainer(
                              child: getValueText(''), width: 40),
                          getFittedContainer(
                              child: getTitleText(''), width: 100),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(
                        children: [
                          getFittedContainer(
                              child: getValueText(' Code:  '), width: 30),
                          getFittedContainer(
                              child: getTitleText(
                                model.customer!.code!,
                              ),
                              width: 120),
                        ],
                      ),
                      pw.Row(
                        children: [
                          getFittedContainer(
                              child: getValueText(' Phone:  '), width: 30),
                          getFittedContainer(
                              child: getTitleText(
                                model.customer!.phone!,
                              ),
                              width: 120),
                        ],
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      getFittedContainer(
                          child: getValueText(' Name:  '), width: 30),
                      getFittedContainer(
                          child: getTitleText(
                            model.customer!.name!,
                          ),
                          width: 120),
                    ],
                  ),
                  pw.Divider(thickness: 2),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 5),
                    child: pw.Row(
                      children: [
                        getFittedContainer(
                          child: getTitleText('No'),
                          width: 30,
                        ),
                        getSpacer(width: 10),
                        getFittedContainer(
                          child: getTitleText('Name'),
                          width: 150,
                        ),
                        getSpacer(width: 20),
                        getFittedContainer(
                          child: getTitleText('Qty'),
                          width: 50,
                        ),
                        getSpacer(width: 10),
                        getFittedContainer(
                          child: getTitleText('Price'),
                          width: 50,
                        ),
                        getSpacer(width: 10),
                        getFittedContainer(
                          child: getTitleText('Total'),
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < model.billingItems!.length; i++)
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 2),
                      child: pw.Row(
                        children: [
                          getFittedContainer(
                            child: getValueText('${i + 1}'),
                            width: 30,
                          ),
                          getSpacer(width: 10),
                          getFittedContainer(
                            child: getValueText(
                                model.billingItems![i].item!.name ?? ''),
                            width: 150,
                          ),
                          getSpacer(width: 20),
                          getFittedContainer(
                            child: getValueText(
                                model.billingItems![i].quantity.toString()),
                            width: 50,
                          ),
                          getSpacer(width: 10),
                          getFittedContainer(
                            child: getValueText(
                                (model.billingItems![i].item!.sale ?? 0)
                                    .toStringAsFixed(0)),
                            width: 50,
                          ),
                          getSpacer(width: 10),
                          getFittedContainer(
                            child: getValueText(
                                ((model.billingItems![i].quantity ?? 0) *
                                        (model.billingItems![i].item!.sale ??
                                            0))
                                    .toStringAsFixed(0)),
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                  pw.Divider(thickness: 2),
                  pw.SizedBox(
                    width: 410,
                    child: Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          getFittedContainer(
                              child: getValueText(' Total:  '), width: 30),
                          getFittedContainer(
                              child: getTitleText(
                                (model.totalAmount ?? 0).toStringAsFixed(0),
                              ),
                              width: 120),
                        ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => doc.save());
    await printPage(doc);
  }

  Future<void> printReportSheet(List<Customer> customer) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        build: (con) {
          return pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Text(
                    '   Date:  ',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    DateTime.now().formatedDateTime(),
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Divider(thickness: 2),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Row(
                  children: [
                    getFittedContainer(
                      child: getTitleText('Code'),
                      width: 30,
                    ),
                    getSpacer(width: 10),
                    getFittedContainer(
                      child: getTitleText('name'),
                      width: 120,
                    ),
                    getSpacer(width: 20),
                    getFittedContainer(
                      child: getTitleText('Number'),
                      width: 90,
                    ),
                    getSpacer(width: 10),
                    getFittedContainer(
                      child: getTitleText('Address'),
                      width: 110,
                    ),
                    getSpacer(width: 20),
                    getFittedContainer(
                      child: getTitleText('Ammount'),
                      width: 84,
                    ),
                  ],
                ),
              ),
              for (var c in customer)
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Row(
                    children: [
                      getFittedContainer(
                          child: getValueText(c.code ?? ''), width: 30),
                      getSpacer(width: 10),
                      getFittedContainer(
                          child: getValueText(c.name ?? ''), width: 120),
                      getSpacer(width: 20),
                      getFittedContainer(
                          child: getValueText(c.phone ?? ''), width: 90),
                      getSpacer(width: 10),
                      getFittedContainer(
                          child: getValueText(c.address ?? ''), width: 110),
                      getSpacer(width: 20),
                      getFittedContainer(
                          child:
                              getValueText((c.credit ?? 0).toStringAsFixed(0)),
                          width: 84),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => doc.save());
    await printPage(doc);
  }

  Future<void> printPage(Document doc) async {
    if (printer == null) {
      await init();
      if (printer == null) {
        Get.snackbar('Printer not found', 'Please attack printer first');
        return;
      } else {}
    } else {
      await Printing.directPrintPdf(
          printer: printer!,
          onLayout: (formet) {
            return doc.save();
          });
    }
  }

  Widget getTitleText(
    String title,
  ) {
    return pw.Text(
      title,
      overflow: pw.TextOverflow.clip,
      style: pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }

  Widget getValueText(String title) {
    return pw.Text(
      title,
      overflow: pw.TextOverflow.clip,
      maxLines: 1,
      style: pw.TextStyle(
        fontSize: 10,
        fontWeight: pw.FontWeight.normal,
      ),
    );
  }

  Widget getFittedContainer({required Widget child, required double width}) {
    return pw.SizedBox(width: width, child: child);
  }

  Widget getSpacer({double? width}) {
    return pw.SizedBox(width: width ?? legalPage.width * 0.02);
  }
}
