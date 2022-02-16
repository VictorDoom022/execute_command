import 'dart:io';
import 'package:execute_command/controller/Components.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:process_run/shell.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SetupFrameworkController.dart';

class InstallDependencyController {
  static Shell shell = Shell();

  static void installFlutter(BuildContext context) async {
    String windowsScript = '''
      echo "Downloading Flutter SDK for Windows... (This may take a while)"
      curl https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_2.10.1-stable.zip --output flutter.zip
      echo "Unzipping Flutter SDK... (This may take a while)"
      tar -xf flutter.zip
      echo "Now you have to add the Flutter SDK to the PATH variable:"
      explorer flutter
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

    installDialog(context, Platform.isWindows ? windowsScript : Platform.isLinux ?  linuxScript : Platform.isMacOS ? macScript : '');
  }

  static void installJava(BuildContext context){
    if(Platform.isWindows || Platform.isMacOS){
      launch('https://www.oracle.com/java/technologies/downloads/');
    }else if(Platform.isLinux){
      copyOrRunCommandDialog(context, 'sudo apt install default-jdk');
    }
  }

  static void installPython(BuildContext context){
    if(Platform.isWindows || Platform.isMacOS){
      launch('https://www.python.org/downloads/');
    }else if(Platform.isLinux){
      copyOrRunCommandDialog(context, 'sudo apt install python');
    }
  }

  static void installPHP() {
    launch('https://www.apachefriends.org/download.html');
  }

  static void installComposer(BuildContext context) {
    if(Platform.isWindows){
      launch('https://nodejs.org/en/download/');
    }else if(Platform.isLinux){
      copyOrRunCommandDialog(context, 'sudo apt install composer');
    }else if(Platform.isMacOS){
      copyOrRunCommandDialog(context, 'brew install composer');
    }
  }

  static void installNode(BuildContext context) {
    if(Platform.isWindows || Platform.isMacOS){
      launch('https://nodejs.org/en/download/');
    }else if(Platform.isLinux){
      copyOrRunCommandDialog(context, 'sudo apt install nodejs');
    }
  }

  static void installYarn(BuildContext context, String npmInstallPath) {
    if(npmInstallPath != 'null'){
      copyOrRunCommandDialog(context, 'npm install --global yarn');
    }else{
      Components.resultDialog(context, 'You have to install npm first');
    }
  }

  static void installNPM(BuildContext context) {
    if(Platform.isWindows || Platform.isMacOS){
      launch('https://nodejs.org/en/download/');
    }else if(Platform.isLinux){
      copyOrRunCommandDialog(context, 'sudo apt install npm');
    }
  }

  static void installVueJS(BuildContext context) {
    SetupFrameworkController.setupVue(context);
  }

  static void installGit(BuildContext context) {
    if(Platform.isWindows){
      launch('https://nodejs.org/en/download/');
    }else if(Platform.isLinux){
      copyOrRunCommandDialog(context, 'sudo apt install git');
    }else if(Platform.isMacOS){
      copyOrRunCommandDialog(context, 'brew install git');
    }
  }

  static void installVSCode() {
    launch('https://code.visualstudio.com/');
  }

  static void installCustomRomDependencies(BuildContext context) {
    String installScript = ''' 
      sudo apt install git-core gperf bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc libc6-dev-i386 x11proto-core-dev libx11-dev libgl1-mesa-dev  zip unzip zlib1g-dev -y
      sudo add-apt-repository universe
      sudo apt-get install libncurses5 libncurses5:i386
    ''';

    copyOrRunCommandDialog(context, installScript);
  }

  static void installGappsDependencies(BuildContext context) {
    String installScript = ''' 
      sudo apt install git-lfs aapt apksigner zipalign default-jdk lzip zip
     ''';

    copyOrRunCommandDialog(context, installScript);
  }

  static Future<void> copyOrRunCommandDialog(BuildContext context, String installScript) async {
    showDialog(
        context: context,
        builder: (_){
          return ContentDialog(
            title: const Text('Select Option'),
            actions: [
              Button(
                child: const Text('Run Script'),
                onPressed: (){
                  installDialog(context, installScript);
                },
              ),
              Button(
                  child: const Text('Copy Script'),
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: installScript)).then((value) {
                      showSnackbar(
                        context,
                        const Snackbar(
                          content: Text('Copied!'),
                        ),
                      );
                    });
                  }
              ),
              Button(
                child: const Text('Close'),
                onPressed: ()=> Navigator.of(context).pop(),
              )
            ],
          );
        }
    );
  }

  static void installDialog(BuildContext context, String command) async {
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

      Components.resultDialog(context, outputString);
    }on ShellException catch (_){
      Navigator.of(context).pop();
      Components.resultDialog(context, _.message);
    }
  }
}