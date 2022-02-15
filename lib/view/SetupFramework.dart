import 'package:execute_command/controller/SetupFrameworkController.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:process_run/shell.dart';

import '../controller/Components.dart';

class SetupFramework extends StatefulWidget {
  const SetupFramework({Key? key}) : super(key: key);

  @override
  _SetupFrameworkState createState() => _SetupFrameworkState();
}

class _SetupFrameworkState extends State<SetupFramework> {

  Shell shell = Shell();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Setup Framework',
              style: TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Setup Laravel'),
              trailing: Button(
                child: const Text('Setup'),
                onPressed: () {
                  SetupFrameworkController.setupLaravel(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Setup Vue JS'),
              trailing: Button(
                child: const Text('Setup'),
                onPressed: () {
                  SetupFrameworkController.setupVue(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
