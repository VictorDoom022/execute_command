import 'package:fluent_ui/fluent_ui.dart';
import 'package:process_run/shell.dart';

class RunCommand extends StatefulWidget {
  const RunCommand({Key? key}) : super(key: key);

  @override
  _RunCommandState createState() => _RunCommandState();
}

class _RunCommandState extends State<RunCommand> {

  Shell shell = Shell();
  ScrollController commandOutputScrollController = ScrollController();
  TextEditingController commandTextEditingController = TextEditingController();
  TextEditingController commandOutputTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Run Command',
              style: TextStyle(
                  fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextBox(
            controller: commandTextEditingController,
            header: 'Command',
            textInputAction: TextInputAction.go,
            onSubmitted: (value){
              executeCommand();
            },
          ),
          const SizedBox(height: 10),
          Button(
            child: const Text('Execute'),
            onPressed: () async {
              executeCommand();
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TextBox(
              readOnly: true,
              scrollController: commandOutputScrollController,
              controller: commandOutputTextEditingController,
              maxLines: null,
            ),
          )
        ],
      ),
    );
  }

  void executeCommand() async {
    var executeResult = await shell.run(
        commandTextEditingController.text,
        onProcess: (value) async {
          commandOutputTextEditingController.text += 'Executing... \n';
        }
    ).catchError((errorValue) async {
      Future.error(commandOutputTextEditingController.text += errorValue.toString() + '\n');
    });

    commandOutputTextEditingController.text += executeResult.errText + '\n';
    commandOutputTextEditingController.text += executeResult.outText + '\n';
    commandOutputScrollController.jumpTo(commandOutputScrollController.position.maxScrollExtent);
    commandTextEditingController.clear();
  }
}

