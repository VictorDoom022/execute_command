import 'package:fluent_ui/fluent_ui.dart';

class Components{

  static Future resultDialog(BuildContext context, String outputString) async {
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
                },
              )
            ],
          );
        }
    );
  }

}