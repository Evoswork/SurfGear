//import 'package:shell/shell.dart';

//import 'package:process_run/shell.dart';

import 'package:shell/shell.dart';

/// Проверяем, установлен ли git
class CheckInstallGit {
  Future<void> check() async {
    var shell = new Shell();

    var processResult = await shell.start('git', ['--help']);
//    print(await processResult.stdout.readAsString());
//    if (processResult.stderr. != 0) {
//      return Future.error('git not found, install git of https://git-scm.com');
//    }
  }
}
