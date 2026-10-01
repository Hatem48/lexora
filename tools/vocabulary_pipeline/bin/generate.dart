import 'dart:io';

import 'package:vocabulary_pipeline/vocabulary_pipeline.dart';

void main() {
  final script = File(Platform.script.toFilePath());
  final repoRoot = script.parent.parent.parent.parent;
  try {
    generateCatalog(PipelinePaths(repoRoot));
    stdout.writeln('Wrote assets/vocabulary/catalog.json');
    stdout.writeln('Reports: build/vocabulary/summary.json');
    stdout.writeln('Reports: build/vocabulary/statistics.json');
    stdout.writeln('Reports: build/vocabulary/conflicts.json');
    stdout.writeln('Reports: build/vocabulary/rejected.json');
  } on MissingSources catch (error) {
    stderr.writeln(error);
    stderr.writeln('catalog.json was not changed.');
    exitCode = 2;
  } on InvalidCatalog catch (error) {
    stderr.writeln(error);
    stderr.writeln('catalog.json was not changed.');
    exitCode = 1;
  } on FormatException catch (error) {
    stderr.writeln(error.message);
    stderr.writeln('catalog.json was not changed.');
    exitCode = 1;
  }
}
