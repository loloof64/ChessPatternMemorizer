import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as chess;

class ChessDiagramCell extends StatelessWidget {
  final Color whiteColor = Color.fromARGB(255, 255, 206, 158);
  final Color blackColor = Color.fromARGB(255, 209, 139, 71);
  final bool cellColor;

  ChessDiagramCell([this.cellColor]);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => {},
      child: null,
      color: this.cellColor ? whiteColor : blackColor,
    );
  }
}

class ChessDiagram extends StatefulWidget {

  final double size;

  ChessDiagram([this.size]);

  @override
  _ChessDiagramState createState() => _ChessDiagramState();
}

class _ChessDiagramState extends State<ChessDiagram> {
  _buildCells() {
    var cellsList = <Widget>[];

    // first files coordinates line
    cellsList.add(Text(""));
    for (var file = 0; file < 8; file++) {
      final fileLetter = String.fromCharCode(file + 65);
      cellsList.add(Center(
        child: Text(
          fileLetter,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }
    cellsList.add(Text(""));

    // board with ranks coordinate
    for (var row = 0; row < 8; row++) {
      final rankDigit = String.fromCharCode(56 - row);
      final rankText = Center(
        child: Text(rankDigit,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      );
      cellsList.add(rankText);
      for (var col = 0; col < 8; col++) {
        cellsList.add(ChessDiagramCell((row + col) % 2 == 0));
      }
      cellsList.add(rankText);
    }

    // second files coordinates line
    cellsList.add(Text(""));
    for (var file = 0; file < 8; file++) {
      final fileLetter = String.fromCharCode(file + 65);
      cellsList.add(Center(
        child: Text(
          fileLetter,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }
    cellsList.add(Text(""));
    return cellsList;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Container(
          child: GridView.count(
            crossAxisCount: 10,
            children: _buildCells(),
          ),
          color: Colors.grey,
        ),
    );
  }
}
