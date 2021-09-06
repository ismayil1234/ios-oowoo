import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oowoo/Controllers/pdf_or_document_Provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PdfOrDocumentService {
  Future downloadPdfOrDocument(
      Map<String, dynamic> urlAndType, BuildContext context) async {
    // if(url.contains('.mp4'))
    //'url':pdfUrl,'type':'mp4'
    Dio dio = Dio();
    // var dir =
    //getDownloadsDirectory for ios
    if (Platform.isAndroid) {
      await getExternalStorageDirectories().then((value) async {
        var dir = value[0];
        // print(value[0]);
        var f = File("${dir.path}/oowoo.$urlAndType['type']");
        // print(f);
        // print(dir.path);
        String fileName =
            urlAndType['url'].substring(urlAndType['url'].lastIndexOf("/") + 1);
        Response response = await dio
            .download(urlAndType['url'], "${dir.path}/$fileName",
                onReceiveProgress: (received, total) {
          if (total != -1) {
            // var percentage;
            // if (total < 100) {
            var percentage = (received / total * 100).toStringAsFixed(0) + "%";
            // } else {
            //   percentage = 'Downloaded';
            // }
            Provider.of<PdfOrDocumentProvider>(context, listen: false)
                .updateDownloadPercentage(percentage);
            // print((received / total * 100).toStringAsFixed(0) + "%");
          }
        });
        Provider.of<PdfOrDocumentProvider>(context, listen: false)
            .getStoredPath(dir.path);
        // print('fileName is $fileName');
        // print('f is $f');
        // print('response is $response');
        // print(response.data);
        // print(response.headers);
        return response;
      });
    } else if (Platform.isIOS) {
      await getApplicationDocumentsDirectory().then((value) async {
        var dir = value;
        // print(value[0]);
        var f = File("${dir.path}/oowoo.$urlAndType['type']");
        // print(f);
        // print(dir.path);
        String fileName =
            urlAndType['url'].substring(urlAndType['url'].lastIndexOf("/") + 1);
        Response response = await dio
            .download(urlAndType['url'], "${dir.path}/$fileName",
                onReceiveProgress: (received, total) {
          if (total != -1) {
            // var percentage;
            // if (total < 100) {
            var percentage = (received / total * 100).toStringAsFixed(0) + "%";
            // } else {
            //   percentage = 'Downloaded';
            // }
            Provider.of<PdfOrDocumentProvider>(context, listen: false)
                .updateDownloadPercentage(percentage);
            // print((received / total * 100).toStringAsFixed(0) + "%");
          }
        });
        Provider.of<PdfOrDocumentProvider>(context, listen: false)
            .getStoredPath(dir.path);
        // print('fileName is $fileName');
        // print('f is $f');
        // print('response is $response');
        // print(response.data);
        // print(response.headers);
        return response;
      });
    }
  }
}
