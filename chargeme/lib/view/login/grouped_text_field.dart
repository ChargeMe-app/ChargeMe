import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupedTextFieldManager {
  int get count => "*".allMatches(format).length;
  final String format; // ex: (***)***-**-** or ****
  final Function(String)? onEndEditing;
  final Function(String)? onChanged;

  final List<FocusNode> focusNodes = [];
  final List<TextEditingController> controllers = [];

  GroupedTextFieldManager({required this.format, this.onEndEditing, this.onChanged}) {
    for (var i = 0; i < count; i++) {
      final focusNode = FocusNode();
      final controller = TextEditingController();
      focusNodes.add(focusNode);
      controllers.add(controller);
    }
    focusNodes[0].requestFocus();
  }

  String getText() {
    return controllers.map((e) => e.text).join("");
  }
}

class GroupedTextField extends StatelessWidget {
  final GroupedTextFieldManager manager;

  const GroupedTextField({required this.manager, super.key});

  @override
  Widget build(BuildContext context) {
    var textFieldIndex = -1;
    return Row(
        children: List.generate(manager.format.length, (i) {
      final symbol = manager.format[i];
      if (symbol == "*") {
        textFieldIndex += 1;
        return textField(textFieldIndex);
      }
      return Row(children: [text(symbol), const SizedBox(width: 6)]);
    }));
  }

  Widget text(String data) {
    return Text(data, style: TextStyle(fontSize: 26));
  }

  Widget textField(int i) {
    final focusNodes = manager.focusNodes;
    final controllers = manager.controllers;
    final focusNode = focusNodes[i];
    final controller = controllers[i];
    return Container(
        constraints: BoxConstraints(maxWidth: 24),
        child: TextFormField(
            keyboardType: TextInputType.number,
            focusNode: focusNode,
            controller: controller,
            inputFormatters: [LengthLimitingTextInputFormatter(2)],
            style: TextStyle(fontSize: 26),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '•',
            ),
            onChanged: (str) {
              if (str.isEmpty) {
                if (i - 1 >= 0) {
                  focusNodes[i - 1].requestFocus();
                }
              } else {
                if (i + 1 < focusNodes.length) {
                  if (controller.text.length > 1) {
                    focusNodes[i + 1].requestFocus();
                    controller.text = controller.text.substring(0, 1);
                    if (i + 1 < controllers.length) {
                      controllers[i + 1].text = str.substring(1, 2);
                    }

                    if (i + 2 >= focusNodes.length) {
                      focusNodes[i + 1].unfocus();
                      if (manager.onEndEditing != null) {
                        manager.onEndEditing!(manager.getText());
                      }
                    }
                  }
                } else {
                  if (controller.text.length > 1) {
                    controller.text = str.substring(1, 2);
                  }
                }
              }
              if (manager.onEndEditing != null) {
                manager.onChanged!(manager.getText());
              }
            }));
  }
}
