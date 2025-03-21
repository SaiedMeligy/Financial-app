import 'package:flutter/material.dart';

// class TextFieldQuestionRow extends StatefulWidget {
//   final List<dynamic> items;
//   final String scenarioId;
//   final ValueChanged<List<Map<String, String>>>? onChanged;
//
//   const TextFieldQuestionRow({
//     super.key,
//     required this.items,
//     this.onChanged,
//     required this.scenarioId,
//   });
//
//   @override
//   State<TextFieldQuestionRow> createState() => _TextFieldQuestionRowState();
// }
//
// class _TextFieldQuestionRowState extends State<TextFieldQuestionRow> {
//   late List<TextEditingController> controllers;
//   late Map<String, String> storedValues; // Store entered values
//
//   @override
//   void initState() {
//     super.initState();
//     storedValues = {}; // Initialize the storage
//     controllers = List.generate(widget.items.length, (index) {
//       String pointerId = widget.items[index].id.toString();
//       return TextEditingController(text: storedValues[pointerId] ?? ""); // Retrieve stored value if exists
//     });
//   }
//
//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: widget.items.length,
//       itemBuilder: (context, index) {
//         String pointerId = widget.items[index].id.toString();
//
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 5,
//                 child: Text(widget.items[index].text),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: TextField(
//                   controller: controllers[index],
//                   decoration: const InputDecoration(border: OutlineInputBorder()),
//                   onChanged: (value) {
//                     storedValues[pointerId] = value; // Save value to map
//                     if (widget.onChanged != null) {
//                       widget.onChanged!(
//                         List.generate(widget.items.length, (i) => {
//                           "pointerId": widget.items[i].id.toString(),
//                           "evaluation": controllers[i].text,
//                           "scenarioNumber": widget.scenarioId
//                         }),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
class TextFieldQuestionRow extends StatelessWidget {
  final List<dynamic> items;
  final String scenarioId;
  final Map<String, TextEditingController> controllers;
  final ValueChanged<List<Map<String, String>>>? onChanged;

  const TextFieldQuestionRow({
    super.key,
    required this.items,
    required this.controllers,
    this.onChanged,
    required this.scenarioId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        String pointerId = items[index].id.toString();

        // Initialize controller if it doesn’t exist
        controllers.putIfAbsent(pointerId, () => TextEditingController());

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(items[index].text),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: controllers[pointerId], // Use persistent controller
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  onChanged: (value) {
                    if (onChanged != null) {
                      onChanged!(
                        List.generate(items.length, (i) => {
                          "pointerId": items[i].id.toString(),
                          "evaluation": controllers[items[i].id.toString()]?.text??'',
                          "scenarioNumber": scenarioId
                        }),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
