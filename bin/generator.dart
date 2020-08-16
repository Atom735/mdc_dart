import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

const pathIn = r'D:\github\material-components-web-7.0.0\packages';
const pathOut = r'D:\github\mdc_dart\lib\src';
const pathOutScss = r'D:\github\mdc_dart\lib\scss';

final _dbIndex = StringBuffer();
final filesInProc = <File>{};
final packs = <MdcPack>{};

String mapTypes(final String s) {
  switch (s) {
    case 'string':
      return 'String';
    case 'number':
      return 'num';
    case 'boolean':
      return 'bool';
    default:
      return s;
  }
}

class MdcPack {
  final Directory dirIn;
  final Directory dirOut;
  final String name;
  final String main;
  final String module;

  MdcPack.fromJson(this.dirIn, this.dirOut, dynamic json)
      : name = (json['name'] as String)
            .replaceAll('@material/', 'mdc-')
            .replaceAll('-', '_'),
        main = p
            .basenameWithoutExtension(json['main'] as String)
            .replaceAll('dist/', ''),
        module = json['module'] {
    if (dirOut.existsSync()) {
      return;
    }

    dirOut.createSync();
    packs.add(this);

    ts2dart(File(p.join(dirIn.path, p.setExtension(module, '.ts'))));
  }

  static final re = RegExp(
      r"""
(\/\*[\s\S]*?\*\/|\/\/.*)
|^(import|export)\s+(\*|{[^}]+}|\w+)(?:\s+(?:as\s+(\w+)\s+)?from\s+'([^']*)')?\s*;
|(\s+)
|(})
|(?:^export\s+interface\s+(\w+)(?:\s+extends\s+((?:\w+)(?:\s*,\s*\w+)*))?\s*{)
|(?:(\w+)\(([^\)]*)\)\s*:\s*(\w+)\s*;)
      """
          .trim()
          .replaceAll('\r', '')
          .replaceAll('\n', ''),
      multiLine: true);

  static const reComment = 1;
  static const reImExPort = 2;
  static const reImExEntity = 3;
  static const reImExAs = 4;
  static const reImExFrom = 5;
  static const reWhiteSapce = 6;
  static const reCloseBreket = 7;
  static const reExportInterface = 8;
  static const reExportInterfaceExtends = 9;
  static const reFunctionIdent = 10;
  static const reFunctionArgs = 11;
  static const reFunctionRetType = 12;

  void ts2dart(File file) {
    if (filesInProc.contains(file)) {
      return;
    } else {
      filesInProc.add(file);
    }
    final s = StringBuffer();
    final data = file.readAsStringSync();

    var iBracketsList = <String>[];
    var i0 = 0;
    for (Match match;
        (match = re.matchAsPrefix(data, i0)) != null;
        i0 = match.end) {
      final subStr = data.substring(i0, match.start);
      if (subStr.isNotEmpty) {
        s.write('@Error{$subStr}');
      }
      if (match.group(reWhiteSapce) != null) {
        s.write(match.group(reWhiteSapce));
      } else if (match.group(reComment) != null) {
        s.write(match.group(reComment));
        if (match.group(reComment).startsWith('//')) {
          s.writeln();
        }
      } else if (match.group(reImExPort) != null) {
        final _entity = match.group(reImExEntity) != null
            ? match
                .group(reImExEntity)
                .replaceFirst('{', '')
                .replaceFirst('}', '')
                .trim()
            : null;
        final _as = match.group(reImExAs);
        final _from = match
            .group(reImExFrom)
            ?.replaceAll('@material/', 'package:mdc_dart/src/mdc-');
        String getEntity() =>
            _entity == '*' || _entity == null ? '' : ' show $_entity';
        String getAs() => _as != null ? ' as $_as' : '';
        if (match.group(reImExPort) == 'import') {
          s.write("import '$_from.dart'${getEntity()}${getAs()};");
        } else if (match.group(reImExPort) == 'export' && _from != null) {
          s.write("export '$_from.dart'${getEntity()}${getAs()};");
        } else {
          s.write('@ErrorImportOrExport{${match.group(0)}}');
        }
        if (_from != null) {
          if (_from.startsWith('package:mdc_dart/src/')) {
            ts2dart(File(
                p.join(pathIn, p.setExtension(_from.substring(21), '.ts'))));
          } else if (_from.startsWith('./')) {
            ts2dart(File(p.join(p.dirname(file.path),
                p.setExtension(_from.substring(2), '.ts'))));
          }
        }
      } else if (match.group(reCloseBreket) != null) {
        final _match = match.group(reCloseBreket);
        if (iBracketsList.isEmpty) {
          s.write('@Error{$_match}');
        } else {
          final _l = iBracketsList.removeLast();
          s.write('$_match /* $_l */');
        }
      } else if (match.group(reExportInterface) != null) {
        final _ident = match.group(reExportInterface);
        final _extends = match.group(reExportInterfaceExtends);
        iBracketsList.add(_ident);
        if (_extends == null) {
          s.write('abstract class $_ident {');
        } else {
          s.writeln('abstract class $_ident');
          s.write('    implements $_extends {');
        }
      } else if (match.group(reFunctionIdent) != null) {
        final _retType = match.group(reFunctionRetType);
        final _ident = match.group(reFunctionIdent);
        final _args = match.group(reFunctionArgs);

        var b = false;
        s.write('${mapTypes(_retType)} $_ident(');
        _args.split(',').forEach((_arg) {
          if (_arg.isEmpty) {
            return;
          }
          final v = _arg.split(':');
          if (b) {
            s.write(', ');
          }
          s.write('${mapTypes(v[1].trim())} ${v[0].trim()}');
          b = true;
        });
        s.write(');');
      }
    }

    final subStr = data.substring(i0);
    if (subStr.isNotEmpty) {
      s.write('@Error{$subStr}');
    }

    final _pathOut = p.join(pathOut,
        p.setExtension(file.path.substring(pathIn.length + 1), '.dart'));
    Directory(p.dirname(_pathOut)).createSync(recursive: true);
    File(_pathOut).writeAsStringSync(s.toString());
  }
}

void main(List<String> args) {
  if (Directory(pathOut).existsSync()) {
    Directory(pathOut).deleteSync(recursive: true);
  }
  Directory(pathOut).createSync(recursive: true);
  Directory(pathOutScss).createSync(recursive: true);

  Directory(pathIn).listSync(recursive: false).forEach((dirPack) {
    if (dirPack is Directory) {
      final packName = p.basename(dirPack.path);

      final filePack = File(p.join(dirPack.path, 'package.json'));
      if (filePack.existsSync()) {
        final jsonPack = jsonDecode(filePack.readAsStringSync());
        if (jsonPack['module'] != null) {
          MdcPack.fromJson(
              dirPack, Directory(p.join(pathOut, packName)), jsonPack);
        } else {
          print('Folder havent package module: $dirPack');
        }
      } else {
        print('Folder havent package json: $dirPack');
      }

      final libScss = Directory(p.join(pathOutScss, packName))
        ..createSync(recursive: false);
      dirPack.listSync(recursive: false).forEach((file) {
        if (file is File) {
          final fileName = p.basename(file.path);
          final fileExt = p.extension(fileName);
          if (fileExt == '.scss') {
            File(p.join(libScss.path, fileName)).writeAsStringSync(file
                .readAsStringSync()
                .replaceAll('@material/', 'package:mdc_dart/scss/mdc-'));
          }
        }
      });
    } else {
      print('Unknown: $dirPack');
    }
  });

  File(p.join(pathOut, '_index.ts')).writeAsStringSync(_dbIndex.toString());
}
