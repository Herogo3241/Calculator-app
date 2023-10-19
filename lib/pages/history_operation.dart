import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryPage extends StatefulWidget {
  final List<String> operationsHistory;

  HistoryPage({required this.operationsHistory});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  void clearHistory() {
    HapticFeedback.vibrate();
    setState(() {
      widget.operationsHistory.clear();
    });
  }

  int? tappedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.operationsHistory.length,
                itemBuilder: (context, index) {
                  Color backgroundColor = index % 2 == 0
                      ? const Color(0xffA8DF8E)
                      : const Color(0xffF3FDE8);
                  return GestureDetector(
                    onDoubleTap: () async {
                      setState(() {
                        tappedIndex = index;
                      });
                      await Future.delayed(const Duration(milliseconds: 200), () {
                        if (mounted) {
                          setState(() {
                            tappedIndex = null;
                            widget.operationsHistory.removeAt(index);
                          });
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color:
                              tappedIndex == index ? Colors.red : backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(widget.operationsHistory[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: clearHistory,
              child: const Text('Clear History'),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Operations History',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xff79AC78),
        ),
      ),
    );
  }
}
