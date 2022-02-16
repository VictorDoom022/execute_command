import 'dart:io';

import 'package:execute_command/controller/SetupFrameworkController.dart';
import 'package:execute_command/view/SetupFramework.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:process_run/shell.dart';
import 'package:process_run/which.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/InstallDependencyController.dart';

class InstallDependency extends StatefulWidget {
  const InstallDependency({Key? key}) : super(key: key);

  @override
  _InstallDependencyState createState() => _InstallDependencyState();
}

class _InstallDependencyState extends State<InstallDependency> {

  Shell shell = Shell();

  String dartInstalledMsg = '';
  String flutterInstalledMsg = '';
  String javaInstalledMsg = '';
  String pythonInstalledMsg = '';
  String phpInstalledMsg = '';
  String composerInstalledMsg = '';
  String nodeInstalledMsg = '';
  String npmInstalledMsg = '';
  String vueInstalledMsg = '';
  String yarnInstalledMsg = '';
  String gitInstalledMsg = '';
  String vscodeInstalledMsg = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfDependenciesInstalled();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Dependencies',
              style: TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 20),
            Mica(
              child: Expander(
                initiallyExpanded: true,
                contentBackgroundColor: Colors.grey[30],
                header: const Text('Flutter Framework'),
                content: Column(
                  children: [
                    ExpandedItem(
                      title: 'Dart',
                      path: dartInstalledMsg,
                      isInstalled: resultReturn(dartInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installFlutter(context),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Flutter',
                      path: flutterInstalledMsg,
                      isInstalled: resultReturn(flutterInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installFlutter(context),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Java',
                      path: javaInstalledMsg,
                      isInstalled: resultReturn(javaInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installJava(context),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Mica(
              child: Expander(
                initiallyExpanded: true,
                contentBackgroundColor: Colors.grey[30],
                header: const Text('Web Development'),
                content: Column(
                  children: [
                    ExpandedItem(
                      title: 'PHP',
                      path: phpInstalledMsg,
                      isInstalled: resultReturn(phpInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installPHP(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Composer',
                      path: composerInstalledMsg,
                      isInstalled: resultReturn(composerInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installComposer(context),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Node JS',
                      path: nodeInstalledMsg,
                      isInstalled: resultReturn(nodeInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installNode(context),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'NPM Package Manager',
                      path: npmInstalledMsg,
                      isInstalled: resultReturn(npmInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installNPM(context),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Vue JS',
                      path: vueInstalledMsg,
                      isInstalled: resultReturn(vueInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installVueJS(context),
                    ),
                  ],
                ),
              ),
            ),
            Platform.isLinux ? const SizedBox(height: 10) : Container(),
            Platform.isLinux ? Mica(
              child: Expander(
                initiallyExpanded: true,
                contentBackgroundColor: Colors.grey[30],
                header: const Text('AOSP Development'),
                content: Column(
                  children: [
                    ExpandedItem(
                      title: 'Custom ROM dependencies',
                      onPressed: ()=> InstallDependencyController.installCustomRomDependencies(context),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'GAPPS dependencies',
                      onPressed: ()=> InstallDependencyController.installGappsDependencies(context),
                    ),
                  ],
                ),
              ),
            ) : Container(),
            const SizedBox(height: 10),
            Mica(
              child: Expander(
                initiallyExpanded: true,
                contentBackgroundColor: Colors.grey[30],
                header: const Text('Others'),
                content: Column(
                  children: [
                    ExpandedItem(
                      title: 'Python',
                      path: pythonInstalledMsg,
                      isInstalled: resultReturn(pythonInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installPython(context),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'YARN Package Manager',
                      path: yarnInstalledMsg,
                      isInstalled: resultReturn(yarnInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installYarn(context, npmInstalledMsg),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Visual Studio Code',
                      path: vscodeInstalledMsg,
                      isInstalled: resultReturn(vscodeInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installVSCode(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'GIT',
                      path: gitInstalledMsg,
                      isInstalled: resultReturn(gitInstalledMsg),
                      onPressed: ()=> InstallDependencyController.installGit(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkIfDependenciesInstalled() async {
    var dartExecutable = whichSync('dart');
    var flutterExecutable = whichSync('flutter');
    var javaExecutable = whichSync('java');
    var pythonExecutable = whichSync('python');
    var phpExecutable = whichSync('php');
    var composerExecutable = whichSync('composer');
    var nodeExecutable = whichSync('node');
    var npmExecutable = whichSync('npm');
    var vueExecutable = whichSync('vue');
    var yarnExecutable = whichSync('yarn');
    var gitExecutable = whichSync('git');
    var vscodeExecutable = whichSync('code');

    setState(() {
      dartInstalledMsg = dartExecutable.toString();
      flutterInstalledMsg = flutterExecutable.toString();
      javaInstalledMsg = javaExecutable.toString();
      pythonInstalledMsg = pythonExecutable.toString();
      phpInstalledMsg = phpExecutable.toString();
      composerInstalledMsg = composerExecutable.toString();
      nodeInstalledMsg = nodeExecutable.toString();
      npmInstalledMsg = npmExecutable.toString();
      vueInstalledMsg = vueExecutable.toString();
      yarnInstalledMsg = yarnExecutable.toString();
      gitInstalledMsg = gitExecutable.toString();
      vscodeInstalledMsg = vscodeExecutable.toString();
    });
  }

  bool resultReturn(String result){
    if(result == 'null'){
      return false;
    }else{
      return true;
    }
  }
}

class ExpandedItem extends StatelessWidget {

  final String title;
  final String path;
  final bool isInstalled;
  final VoidCallback onPressed;

  const ExpandedItem({Key? key,required this.title, this.path = '', this.isInstalled = false, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expander(
      headerBackgroundColor: ButtonState.all(!isInstalled && path == '' ? Colors.yellow.darkest : isInstalled ? Colors.blue.lighter : Colors.red),
      header: Text(
        title,
        style: const TextStyle(
            color: Colors.white
        ),
      ),
      content: InfoBar(
        severity: !isInstalled && path == '' ? InfoBarSeverity.warning : isInstalled ? InfoBarSeverity.success : InfoBarSeverity.error,
        title: Row(
          children: [
            Text(
                !isInstalled && path == '' ? 'Unknown' : isInstalled ? path : 'Not installed'
            ),
            const SizedBox(width: 20),
            isInstalled ? Container()
                : Button(
              child: const Text('Install'),
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}

