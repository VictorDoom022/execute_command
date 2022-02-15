import 'package:execute_command/controller/Components.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:process_run/shell.dart';

class SetupFrameworkController{

  static Shell shell = Shell();

  static void setupLaravel(BuildContext context) async {
    var composerExecutable = whichSync('composer');
    if(composerExecutable == 'null'){
      showDialog(
          context: context,
          builder: (_){
            return ContentDialog(
              title: const Text('Error'),
              content: const Text('Composer is required to setup Laravel'),
              actions: [
                Button(
                  child: const Text('OK'),
                  onPressed: ()=> Navigator.of(context).pop(),
                )
              ],
            );
          }
      );
    }else{
      var shellResult = await shell.run(
          'composer global require laravel/installer',
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
      Components.resultDialog(context, shellResult.outText);
    }
  }

  static void setupVue(BuildContext context) async {
    var npmExecutable = whichSync('npm');
    if(npmExecutable == 'null'){
      showDialog(
          context: context,
          builder: (_){
            return ContentDialog(
              title: const Text('Error'),
              content: const Text('NPM is required to setup Laravel'),
              actions: [
                Button(
                  child: const Text('OK'),
                  onPressed: ()=> Navigator.of(context).pop(),
                )
              ],
            );
          }
      );
    }else{
      var shellResult = await shell.run(
          'npm install -g @vue/cli',
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
      Components.resultDialog(context, shellResult.outText);
    }
  }
}