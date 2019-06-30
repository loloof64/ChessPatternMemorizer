import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as chess;
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';

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
  final String fen;
  final chess.Chess _chessLogic = chess.Chess();

  ChessDiagram({@required this.size, @required this.fen}){
    _chessLogic.load(fen);
  }

  @override
  _ChessDiagramState createState() => _ChessDiagramState();

  _getPieceAt({file: int, rank: int})
  {
    assert(file >= 0 && file < 8);
    assert(rank >= 0 && rank < 8);

    final coordStr = "${String.fromCharCode(97+file)}${String.fromCharCode(49+rank)}";
    final piece = _chessLogic.get(coordStr);

    if (piece == null) return Container();
    else {
      var pieceStr = "${piece.color}${piece.type}";
      switch(pieceStr){
        case 'wp': return WhitePawn(size: size);
        case 'wn': return WhiteKnight(size: size);
        case 'wb': return WhiteBishop(size: size);
        case 'wr': return WhiteRook(size: size);
        case 'wq': return WhiteQueen(size: size);
        case 'wk': return WhiteKing(size: size);

        case 'bp': return BlackPawn(size: size);
        case 'bn': return BlackKnight(size: size);
        case 'bb': return BlackBishop(size: size);
        case 'br': return BlackRook(size: size);
        case 'bq': return BlackQueen(size: size);
        case 'bk': return BlackKing(size: size);

        default: throw "Unrecognized piece type !";
      }
    }
  }
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
        final isWhite = (row + col) % 2 == 0;
        cellsList.add(Stack(children: <Widget>[
          ChessDiagramCell(isWhite),
          widget._getPieceAt(file: col, rank: 7-row),
        ],));
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
