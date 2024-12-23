import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constant/colorclass.dart';


class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final box = Hive.box("history");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.scaffoldBack,
        appBar: AppBar(
          backgroundColor: MyColors.theme,
          title: const Text("history"),
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, box, widget) {
            if (box.isEmpty) {
              return const Center(
                child: Text("Empty"),
              );
            } else {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final key = box.keyAt(index);
                  final info = box.get(key);
                  // Parse the time field
                  final DateTime time = info["time"];
                  final String formattedTime =
                      "${time.day}-${time.month}-${time.year} ${time.hour}:${time.minute}";

                  return Dismissible(
                    key: Key(key.toString()), // Unique key for each item
                    direction:
                        DismissDirection.endToStart, // Swipe left to right
                    onDismissed: (direction) {
                      // Delete the item from Hive
                      box.delete(key);

                      // Optionally, show a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleted ${info["class"]}'),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: ListTile(
                      leading: info["image"] != null
                          ? CircleAvatar(
                              radius: 25,
                              backgroundImage: MemoryImage(
                                  info["image"]), // Load the image bytes
                            )
                          : const CircleAvatar(
                              radius: 25,
                              child:
                                  Icon(Icons.person), // Placeholder if no image
                            ),
                      title: Text(
                        info["class"],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${info["confidence"]}",
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("Time: $formattedTime"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
