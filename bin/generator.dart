import 'dart:io';

import 'package:path/path.dart' as p;

void main(List<String> args) {
  const pathIn = r'D:\github\material-components-web-7.0.0\packages';
  const pathOut = r'D:\github\mdc_dart\lib';
  Directory(p.join(pathOut, 'scss')).createSync(recursive: false);
  Directory(pathIn).listSync(recursive: false).forEach((dirPack) {
    if (dirPack is Directory) {
      final packName = p.basename(dirPack.path);

      final libScss = Directory(p.join(pathOut, 'scss', packName))
        ..createSync(recursive: false);
      dirPack.listSync(recursive: false).forEach((file) {
        if (file is File) {
          final fileName = p.basename(file.path);
          final fileExt = p.extension(fileName);
          if (fileExt.toLowerCase() == '.scss') {
            File(p.join(libScss.path, fileName)).writeAsStringSync(file
                .readAsStringSync()
                .replaceAll('@material/', 'package:mdc_dart/scss/'));
          }
        }
      });
    } else {
      print('Unknown: $dirPack');
    }
  });
}
