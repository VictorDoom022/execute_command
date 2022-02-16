import 'dart:io';

import 'package:execute_command/controller/SetupFrameworkController.dart';
import 'package:execute_command/view/SetupFramework.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:process_run/shell.dart';
import 'package:process_run/which.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      onPressed: ()=> installFlutter(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Flutter',
                      path: flutterInstalledMsg,
                      isInstalled: resultReturn(flutterInstalledMsg),
                      onPressed: ()=> installFlutter(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Java',
                      path: javaInstalledMsg,
                      isInstalled: resultReturn(javaInstalledMsg),
                      onPressed: ()=> installJava(),
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
                      onPressed: ()=> installPHP(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Composer',
                      path: composerInstalledMsg,
                      isInstalled: resultReturn(composerInstalledMsg),
                      onPressed: ()=> installComposer(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Node JS',
                      path: nodeInstalledMsg,
                      isInstalled: resultReturn(nodeInstalledMsg),
                      onPressed: ()=> installNode(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'NPM Package Manager',
                      path: npmInstalledMsg,
                      isInstalled: resultReturn(npmInstalledMsg),
                      onPressed: ()=> installNPM(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Vue JS',
                      path: vueInstalledMsg,
                      isInstalled: resultReturn(vueInstalledMsg),
                      onPressed: ()=> installVueJS(),
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
                header: const Text('Others'),
                content: Column(
                  children: [
                    ExpandedItem(
                      title: 'Python',
                      path: pythonInstalledMsg,
                      isInstalled: resultReturn(pythonInstalledMsg),
                      onPressed: ()=> installPython(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'YARN Package Manager',
                      path: yarnInstalledMsg,
                      isInstalled: resultReturn(yarnInstalledMsg),
                      onPressed: ()=> installYarn(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'Visual Studio Code',
                      path: vscodeInstalledMsg,
                      isInstalled: resultReturn(vscodeInstalledMsg),
                      onPressed: ()=> installVSCode(),
                    ),
                    const SizedBox(height: 10),
                    ExpandedItem(
                      title: 'GIT',
                      path: gitInstalledMsg,
                      isInstalled: resultReturn(gitInstalledMsg),
                      onPressed: ()=> installGit(),
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

  void installFlutter() async {
    String windowsScript = '''
      echo "Downloading Flutter SDK for Windows... (This may take a while)"
      curl https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_2.10.1-stable.zip --output flutter.zip
      echo "Unzipping Flutter SDK... (This may take a while)"
      tar -xf flutter.zip
      echo "Now you have to add the Flutter SDK to the PATH variable:"
      move flutter C:/src/test
      echo "Please setup your env"
    ''';

    String linuxScript = 'sudo snap install flutter --classic';

    String macScript = ''' 
      curl https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_2.10.1-stable.zip --output flutter.zip
      unzip flutter.zip
      mkdir ~/development
      cp -R /flutter ~/development
      echo "Please setup your env"
     ''';

    installDialog(Platform.isWindows ? windowsScript : Platform.isLinux ?  linuxScript : Platform.isMacOS ? macScript : '');
  }

  void installJava(){
    if(Platform.isWindows || Platform.isMacOS){
      launch('https://www.oracle.com/java/technologies/downloads/');
    }else if(Platform.isLinux){
      installDialog('sudo apt install default-jdk');
    }
  }

  void installPython(){
    if(Platform.isWindows || Platform.isMacOS){
      launch('https://www.python.org/downloads/');
    }else if(Platform.isLinux){
      installDialog('sudo apt install python');
    }
  }

  void installPHP() {
    launch('https://www.apachefriends.org/download.html');
  }

  void installComposer() {
    if(Platform.isWindows){
      launch('https://nodejs.org/en/download/');
    }else if(Platform.isLinux){
      installDialog('sudo apt install composer');
    }else if(Platform.isMacOS){
      installDialog('brew install composer');
    }
  }

  void installNode() {
    if(Platform.isWindows || Platform.isMacOS){
      launch('https://nodejs.org/en/download/');
    }else if(Platform.isLinux){
      installDialog('sudo apt install nodejs');
    }
  }

  void installYarn() {
    if(npmInstalledMsg != 'null'){
      installDialog('npm install --global yarn');
    }else{
      resultDialog('You have to install npm first');
    }
  }

  void installNPM() {
    if(Platform.isWindows || Platform.isMacOS){
      launch('https://nodejs.org/en/download/');
    }else if(Platform.isLinux){
      installDialog('sudo apt install npm');
    }
  }

  void installVueJS() {
    SetupFrameworkController.setupVue(context);
  }

  void installGit() {
    if(Platform.isWindows){
      launch('https://nodejs.org/en/download/');
    }else if(Platform.isLinux){
      installDialog('sudo apt install git');
    }else if(Platform.isMacOS){
      installDialog('brew install git');
    }
  }

  void installVSCode() {
    launch('https://code.visualstudio.com/');
  }

  void installDialog(String command) async {
    String outputString = '';
    try{
      var shellResult = await shell.run(
          command,
          onProcess: (value) async {
            showDialog(
                context: context,
                builder: (_){
                  return const ContentDialog(
                    backgroundDismiss: false,
                    title: Text('Installing...'),
                    content: Align(
                        alignment: Alignment.center,
                        child: ProgressBar()
                    ),
                  );
                }
            );
          }
      );
      Navigator.of(context).pop();
      outputString += shellResult.outText;

      resultDialog(outputString);
    }on ShellException catch (_){
      Navigator.of(context).pop();
      resultDialog(_.message);
    }
  }

  Future resultDialog(String outputString) async {
    showDialog(
        context: context,
        builder: (_){
          return ContentDialog(
            title: const Text('Result'),
            content: Align(
                alignment: Alignment.center,
                child: Text(outputString)
            ),
            actions: [
              Button(
                child: const Text('OK'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
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

  const ExpandedItem({Key? key,required this.title, required this.path, required this.isInstalled, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expander(
      headerBackgroundColor: ButtonState.all(isInstalled ? Colors.blue.lighter : Colors.red),
      header: Text(
        title,
        style: const TextStyle(
            color: Colors.white
        ),
      ),
      content: InfoBar(
        severity: isInstalled ? InfoBarSeverity.success : InfoBarSeverity.error,
        title: Row(
          children: [
            Text(
                isInstalled ? path : 'Not installed'
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

