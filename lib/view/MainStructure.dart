import 'package:execute_command/view/Home.dart';
import 'package:execute_command/view/InstallDependency.dart';
import 'package:execute_command/view/RunCommand.dart';
import 'package:execute_command/view/SetupFramework.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'CreateProject.dart';

class MainStructure extends StatefulWidget {
  const MainStructure({Key? key}) : super(key: key);

  @override
  _MainStructureState createState() => _MainStructureState();
}

class _MainStructureState extends State<MainStructure> {

  int selectedSideNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationView(
        appBar: const NavigationAppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Execute Command',
              style: TextStyle(
                fontSize: 25
              ),
            ),
          )
        ),
        pane: NavigationPane(
          selected: selectedSideNavIndex,
          onChanged: (index) => setState(() { selectedSideNavIndex = index; }),
          displayMode: PaneDisplayMode.auto,
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.home),
              title: const Text('Home'),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.installation),
              title: const Text('Install Dependency'),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.settings_add),
              title: const Text('Setup Framework'),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.new_team_project),
              title: const Text('Create Project'),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.command_prompt),
              title: const Text('Run Command'),
            ),
          ]
        ),
        content: NavigationBody(
          index: selectedSideNavIndex,
          children: const [
            Home(),
            InstallDependency(),
            SetupFramework(),
            CreateProject(),
            RunCommand(),
          ],
        ),
      ),
    );
  }
}
