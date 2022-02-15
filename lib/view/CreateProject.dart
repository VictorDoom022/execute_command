import 'dart:io';

import 'package:execute_command/controller/Components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:process_run/cmd_run.dart';
import 'package:process_run/shell.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {

  Shell shell = Shell();
  TextEditingController projectNameTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Project',
              style: TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Create new Laravel project'),
              trailing: Button(
                child: const Text('Create'),
                onPressed: () {
                  createLaravelProject();
                },
              ),
            ),
            ListTile(
              title: const Text('Create new Vue JS project'),
              trailing: Button(
                child: const Text('Create'),
                onPressed: () {
                  createVueProject();
                },
              ),
            ),
            ListTile(
              title: const Text('Create new Flutter project'),
              trailing: Button(
                child: const Text('Create'),
                onPressed: () {
                  createFlutterProject();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createLaravelProject() async {
    if(whichSync('laravel') != 'null'){
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if(selectedDirectory != null){
        showDialog(
            context: context,
            builder: (_){
              return ContentDialog(
                title: const Text('Project Name'),
                content: TextBox(
                  controller: projectNameTextEditingController,
                ),
                actions: [
                  Button(
                    child: const Text('Cancel'),
                    onPressed: ()=> Navigator.of(context).pop(),
                  ),
                  Button(
                    child: const Text('Create'),
                    onPressed: (){
                      if(projectNameTextEditingController.text.isNotEmpty){
                        String projectName = projectNameTextEditingController.text;
                        String createProjectScriptWindows = '''
                          laravel new $projectName
                          move $projectName $selectedDirectory
                        ''';
                        String createProjectScriptLinux = '''
                          laravel new $projectName
                          cp $projectName $selectedDirectory
                        ''';

                        String command = Platform.isWindows ? createProjectScriptWindows : createProjectScriptLinux;
                        String openVSCode = whichSync('code').toString() != 'null' ? 'code $selectedDirectory/$projectName ' : '';

                        installDialog(selectedDirectory, command + openVSCode);
                      }
                    },
                  )
                ],
              );
            }
        );
      }
    }else{
      Components.resultDialog(context, 'Laravel not installed');
    }
  }

  void createVueProject() async {
    if(whichSync('vue')!= 'null'){
      var shellResult = await shell.run(
          'vue ui',
          onProcess: (value) async {
            showDialog(
                context: context,
                builder: (_){
                  return ContentDialog(
                    title: const Text('Opening vue ui...'),
                    content: const Align(
                        alignment: Alignment.center,
                        child: ProgressBar()
                    ),
                    actions: [
                      Button(
                        child: const Text('Close'),
                        onPressed: ()=> Navigator.of(context).pop(),
                      )
                    ],
                  );
                }
            );
          }
      );
    }else{
      Components.resultDialog(context, 'Vue not installed');
    }
  }

  void createFlutterProject() async {
    if(whichSync('flutter') != 'null'){
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if(selectedDirectory != null){
        showDialog(
            context: context,
            builder: (_){
              return ContentDialog(
                title: const Text('Project Name'),
                content: TextBox(
                  controller: projectNameTextEditingController,
                ),
                actions: [
                  Button(
                    child: const Text('Cancel'),
                    onPressed: ()=> Navigator.of(context).pop(),
                  ),
                  Button(
                    child: const Text('Create'),
                    onPressed: (){
                      if(projectNameTextEditingController.text.isNotEmpty){

                        String projectName = projectNameTextEditingController.text;
                        String createProjectScriptWindows = '''
                          flutter create $projectName
                          move $projectName $selectedDirectory
                        ''';
                        String createProjectScriptLinux = '''
                          flutter create $projectName
                          cp $projectName $selectedDirectory
                        ''';

                        String command = Platform.isWindows ? createProjectScriptWindows : createProjectScriptLinux;
                        String openVSCode = whichSync('code').toString() != 'null' ? 'code $selectedDirectory/$projectName ' : '';

                        installDialog(selectedDirectory, command + openVSCode);
                      }
                    },
                  )
                ],
              );
            }
        );
      }
    }else{
      Components.resultDialog(context, 'Flutter not installed');
    }
  }

  void installDialog(String folderDirectory,String command) async {
    String outputString = '';
    try{
      var shellResult = await shell.run(
          command,
          onProcess: (value) async {
            showDialog(
                context: context,
                builder: (_){
                  return const ContentDialog(
                    title: Text('Creating...'),
                    content: Align(
                        alignment: Alignment.center,
                        child: ProgressBar()
                    ),
                  );
                }
            );
          }
      );
      outputString += shellResult.outText;

      resultDialog(outputString);
    }on ShellException catch (_){
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
                child: Text(
                    outputString,
                  maxLines: 5,
                )
            ),
            actions: [
              Button(
                child: const Text('OK'),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  projectNameTextEditingController.clear();
                },
              )
            ],
          );
        }
    );
  }

}
