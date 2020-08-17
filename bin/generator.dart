import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

// const pathIn = r'D:\github\material-components-web-7.0.0\packages';
const pathIn = r'D:\ARGilyazeev\github\material-components-web\packages';
// const pathOut = r'D:\github\mdc_dart\lib\src';
const pathOut = r'D:\ARGilyazeev\github\mdc_dart\lib\src';
// const pathOutScss = r'D:\github\mdc_dart\lib\scss';
const pathOutScss = r'D:\ARGilyazeev\github\mdc_dart\lib\scss';

final _dbIndex = StringBuffer();
final filesInProc = <File>{};
final packs = <MdcPack>{};

String mapTypes(String s) {
  s = s.trim();
  if (s.contains('|')) {
    final v = s.split('|');
    var k = -1;
    var j = -1;
    for (var i = 0; i < v.length; i++) {
      if (v[i].trim() != 'null') {
        k = i;
        j++;
      }
    }
    if (j == 0) {
      return mapTypes(v[k]);
    } else {
      return s;
    }
  }
  switch (s) {
    case 'string':
      return 'String';
    case 'number':
      return 'num';
    case 'boolean':
      return 'bool';
    case 'void':
      return 'void';
    default:
      return s;
  }
}

final _re = RegExp(
    r"""
(\/\*[\s\S]*?\*\/|\/\/.*)
|^\s*(import|export)\s+(\*|{[^}]+}|\w+)(?:\s+(?:as\s+(\w+)\s+)?from\s+'([^']*)')?\s*;
|(\s+)
|(}(?:\s*;)?)
|(?:^\s*(?:export\s+)?(interface|class)\s+(\w+(?:\<[^\>]*?\>)?)(?:\s+extends\s+((?:[\w<>]+)(?:\s*,\s*[\w<>]+)*))?\s*{)
|(?:([\w]+(?:<[^\(]+)?)\(([^\)]*)\)\s*:([^;]+);)
|(?:^\s*(?:export\s+)?const\s+(\w+)\s*=\s*{)
|(?:(\w+)\s*:\s*(\[|[^\,}]+),?)
|(?:^\s*(?:export\s+)?enum\s+(\w+)\s*{)
|(?:(\w+)\s*=\s*([^,}]*)\s*,?)
      """
        .trim()
        .replaceAll('\r', '')
        .replaceAll('\n', ''),
    multiLine: true);

enum _Enum {
  full,
  comment,
  importType,
  importObj,
  importAs,
  importFrom,
  whiteSapce,
  closeBreket,
  classType,
  classIdent,
  classExtends,
  functionIdent,
  functionArgs,
  functionType,
  constIdent,
  constKey,
  constValue,
  enumIdent,
  classVarSetKey,
  classVarSetValue,

  unknownSymbol,
}

extension NumberParsing on Match {
  bool has(final _Enum i) => get(i) != null;
  String get(final _Enum i) => group(i.index);
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
        (match = _re.matchAsPrefix(data, i0)) != null;
        i0 = match.end) {
      final subStr = data.substring(i0, match.start);
      if (subStr.isNotEmpty) {
        s.write('@Error{$subStr}');
      }
      if (match.has(_Enum.classVarSetKey)) {
        final _key = match.get(_Enum.classVarSetKey);
        final _val = match.get(_Enum.classVarSetValue);
        if (iBracketsList.last.startsWith('enum:')) {
          s.write('static const $_key = $_val;');
        } else {
          s.write('@Error{${match.get(_Enum.full)}}');
        }
      } else if (match.has(_Enum.enumIdent)) {
        final _ident = match.get(_Enum.enumIdent);
        iBracketsList.add('enum:$_ident');
        s.write('class $_ident {');
      } else if (match.has(_Enum.constKey)) {
        final _key = match.get(_Enum.constKey);
        final _value = match.get(_Enum.constValue);
        s.write("'$_key': ");
        if (_value == '[') {
          var i = 0;
          final _value = data.substring(match.end);
          List<String> _list;
          void _d(int d) {
            while (true) {
              final _o = _value.indexOf('[', i);
              final _c = _value.indexOf(']', i);
              if (_o == -1 || _c < _o) {
                i = _c + 1;
                if (d > 0) {
                  return;
                } else {
                  _list = _value
                      .substring(0, i - 1)
                      .split(',')
                      .map((e) => e.replaceAll('\'', '').trim())
                      .toList(growable: true)
                        ..removeWhere((e) => e.isEmpty);
                  return;
                }
              } else if (_o < _c) {
                i = _o + 1;
                _d(d + 1);
              }
            }
          }

          _d(0);

          final _re = RegExp(r"\s*(?:\.join\('([^']*)'\)),");
          match = _re.matchAsPrefix(data, match.end + i);
          if (match.group(1) != null) {
            s.write("'${_list.join(match.group(1))}',");
          } else {
            s.write('$_list');
          }
        } else {
          s.write(
            '$_value,',
          );
        }
      } else if (match.has(_Enum.constIdent)) {
        final _ident = match.get(_Enum.constIdent);
        iBracketsList.add('const:$_ident');
        s.write('const $_ident = {');
      } else if (match.has(_Enum.whiteSapce)) {
        s.write(match.get(_Enum.whiteSapce));
      } else if (match.has(_Enum.comment)) {
        final _comment = match.get(_Enum.comment);
        s.write(_comment);
        if (_comment.startsWith('//')) {
          s.writeln();
        }
      } else if (match.has(_Enum.importType)) {
        final _type = match.get(_Enum.importType);
        final _entity = match.get(_Enum.importObj) != null
            ? match
                .get(_Enum.importObj)
                .replaceFirst('{', '')
                .replaceFirst('}', '')
                .trim()
            : null;
        final _as = match.get(_Enum.importAs);
        final _from = match
            .get(_Enum.importFrom)
            ?.replaceAll('@material/', 'package:mdc_dart/src/mdc-');
        String getEntity() =>
            _entity == '*' || _entity == null ? '' : ' show $_entity';
        String getAs() => _as != null ? ' as $_as' : '';
        if (_from != null) {
          s.write("$_type '$_from.dart'${getEntity()}${getAs()};");
        } else {
          s.write('/* ${match.get(_Enum.full)} */');
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
      } else if (match.has(_Enum.closeBreket)) {
        final _match = match.get(_Enum.closeBreket);
        if (iBracketsList.isEmpty) {
          s.write('@Error{$_match}');
        } else {
          final _l = iBracketsList.removeLast();
          s.write('$_match /* $_l */');
        }
      } else if (match.has(_Enum.classIdent)) {
        final _type = match.get(_Enum.classType);
        final _ident = match.get(_Enum.classIdent);
        final _extends = match.get(_Enum.classExtends);
        iBracketsList.add('$_type:$_ident');
        if (_type == 'interface') {
          s.write('abstract ');
        }
        s.write('class $_ident');
        if (_extends == null) {
          s.write(' {');
        } else {
          s.writeln();
          s.write('    implements $_extends {');
        }
      } else if (match.has(_Enum.functionIdent)) {
        final _retType = match.get(_Enum.functionType);
        final _ident = match.get(_Enum.functionIdent);
        final _args = match.get(_Enum.functionArgs);

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
      } else if (match.has(_Enum.unknownSymbol)) {
        s.write(match.get(_Enum.unknownSymbol));
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
        } else if (file is Directory) {
          final fileName = p.basename(file.path);
          final _libScss = Directory(p.join(libScss.path, fileName))
            ..createSync(recursive: false);
          file.listSync(recursive: false).forEach((_file) {
            if (_file is File) {
              final _fileName = p.basename(_file.path);
              final _fileExt = p.extension(_fileName);
              if (_fileExt == '.scss') {
                File(p.join(_libScss.path, _fileName)).writeAsStringSync(_file
                    .readAsStringSync()
                    .replaceAll('@material/', 'package:mdc_dart/scss/mdc-'));
              }
            }
          });
        }
      });
    } else {
      print('Unknown: $dirPack');
    }
  });

  File(p.join(pathOut, '_index.ts')).writeAsStringSync(_dbIndex.toString());
}
