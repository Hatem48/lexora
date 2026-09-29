List<List<String>> parseCsv(String raw) {
  final text = raw.startsWith('\uFEFF') ? raw.substring(1) : raw;
  final rows = <List<String>>[];
  final row = <String>[];
  final cell = StringBuffer();
  var inQuotes = false;

  for (var i = 0; i < text.length; i++) {
    final char = text[i];
    if (inQuotes) {
      if (char == '"') {
        final escaped = i + 1 < text.length && text[i + 1] == '"';
        if (escaped) {
          cell.write('"');
          i++;
        } else {
          inQuotes = false;
        }
      } else {
        cell.write(char);
      }
      continue;
    }
    if (char == '"') {
      inQuotes = true;
    } else if (char == ',') {
      row.add(cell.toString());
      cell.clear();
    } else if (char == '\n') {
      row.add(cell.toString());
      cell.clear();
      if (row.any((value) => value.trim().isNotEmpty)) rows.add(List.of(row));
      row.clear();
    } else if (char != '\r') {
      cell.write(char);
    }
  }
  if (cell.isNotEmpty || row.isNotEmpty) {
    row.add(cell.toString());
    if (row.any((value) => value.trim().isNotEmpty)) rows.add(row);
  }
  return rows;
}

int? columnIndex(List<String> header, List<String> names) {
  final normalized = [
    for (final cell in header) cell.trim().toLowerCase(),
  ];
  for (final name in names) {
    final index = normalized.indexOf(name.toLowerCase());
    if (index >= 0) return index;
  }
  return null;
}

class CsvTable {
  CsvTable(this.header, this.rows);

  final List<String> header;
  final List<List<String>> rows;

  static CsvTable parse(String raw, String fileName) {
    final rows = parseCsv(raw);
    if (rows.isEmpty) {
      throw FormatException('$fileName is empty.');
    }
    return CsvTable(rows.first, rows.skip(1).toList());
  }

  int requireColumn(List<String> names, String fileName) {
    final index = columnIndex(header, names);
    if (index == null) {
      throw FormatException(
        '$fileName is missing a column. Expected one of: ${names.join(', ')}.',
      );
    }
    return index;
  }

  String cell(List<String> row, int index) {
    if (index >= row.length) return '';
    return row[index].trim();
  }
}
