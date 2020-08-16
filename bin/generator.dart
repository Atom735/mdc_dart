import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

const pathIn = r'D:\github\material-components-web-7.0.0\packages';
const pathOut = r'D:\github\mdc_dart\lib';

final _DbIndex = StringBuffer();

class MdcPack {
  final Directory dirIn;
  final Directory dirOut;
  final String name;
  final String main;
  final String module;

  MdcPack.fromJson(this.dirIn, this.dirOut, dynamic json)
      : name = (json['name'] as String)
            .replaceAll('@material/', '')
            .replaceAll('-', '_'),
        main = p
            .basenameWithoutExtension(json['main'] as String)
            .replaceAll('dist/', ''),
        module = json['module'] {
    dirOut.createSync();

    ts2dartIndex(File(p.join(dirIn.path, p.setExtension(module, '.ts'))));
  }

  void ts2dartIndex(File file) {
    final s = StringBuffer();
    s.writeln("@JS('$main')");
    s.writeln('library $name;');
    s.writeln('');
    s.writeln("import 'dart:html';");
    s.writeln("import 'package:js/js.dart';");
    s.writeln('');
    final lines = LineSplitter().convert(file.readAsStringSync());

    var inCommentBlock = false;
    for (var line in lines) {
      if (line.isEmpty) {
      } else if (inCommentBlock) {
        if (line.endsWith('*/')) {
          inCommentBlock = false;
          continue;
        }
      } else if (line.startsWith('/*')) {
        inCommentBlock = true;
        continue;
      } else {
        s.writeln('// ERROR_LINE: $line');
        _DbIndex.writeln(line);
      }
    }

    if (inCommentBlock) {
      s.writeln('// ERROR: CommentBlock not closed');
    }

    File(p.join(dirOut.path, p.setExtension(p.basename(file.path), '.dart')))
        .writeAsStringSync(s.toString());
  }
}

void main(List<String> args) {
  Directory(p.join(pathOut, 'scss')).createSync(recursive: false);
  Directory(p.join(pathOut, 'src')).createSync(recursive: false);

  Directory(pathIn).listSync(recursive: false).forEach((dirPack) {
    if (dirPack is Directory) {
      final packName = p.basename(dirPack.path);

      final libScss = Directory(p.join(pathOut, 'scss', packName))
        ..createSync(recursive: false);

      final filePack = File(p.join(dirPack.path, 'package.json'));
      if (filePack.existsSync()) {
        final jsonPack = jsonDecode(filePack.readAsStringSync());
        if (jsonPack['module'] != null) {
          MdcPack.fromJson(
              dirPack, Directory(p.join(pathOut, 'src', packName)), jsonPack);
        } else {
          print('Folder havent package module: $dirPack');
        }
      } else {
        print('Folder havent package json: $dirPack');
      }

      dirPack.listSync(recursive: false).forEach((file) {
        if (file is File) {
          final fileName = p.basename(file.path);
          final fileExt = p.extension(fileName);
          if (fileExt == '.scss') {
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

  File(p.join(pathOut, '_index.ts')).writeAsStringSync(_DbIndex.toString());
}
