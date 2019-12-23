import 'dart:io';

import 'package:args/args.dart';

const String releaseBuildType = 'release';

String flavor = "dev";
String buildType;

void main(List<String> arguments) {
  exitCode = 0;
  final parser = ArgParser();

  var args = parser
      .parse(arguments)
      .arguments;
  if (args.length != 1) {
    exitCode = 1;
    Exception("You should pass build type.");
  } else {
    buildType = args[0];

    build();
  }
}

void build() async {
  resolveFlavor();
  await buildIpa();
}

void resolveFlavor() {
  if (buildType == releaseBuildType) {
    flavor = "prod";
  }
}

void buildIpa() async {
  print("Build type ${buildType}");

  var result = await Process.run('flutter', ['build', "ios", "-t", "lib/main-${buildType}.dart", "--flavor", "${flavor}", "--no-codesign", "--release"]);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}