import 'dart:io';
import 'dart:typed_data';

import 'package:jiffy/jiffy.dart';

String getFormattedDate(String dateInput, {String format}) {
  String resultDate;
  if (format == null) {
    resultDate = Jiffy(dateInput).format('EEE do MMM yyyy');
  } else {
    resultDate = Jiffy(dateInput).format(format);
  }
  return resultDate;
}

Future getImage(String address) async {
  if (address != null && address != '') {
    try {
      File file = File(address);
      Uint8List selectedImageAsBytes = await file.readAsBytes();
      return selectedImageAsBytes;
    } catch (ex) {
      return '';
    }
  } else
    return '';
}
