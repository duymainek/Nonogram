import 'package:flutter/material.dart';

void main() {
  runApp(const NonogramApp());
}

class NonogramApp extends StatelessWidget {
  const NonogramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nonogram Puzzle (Heart)',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const NonogramPuzzle(),
    );
  }
}

class NonogramPuzzle extends StatefulWidget {
  const NonogramPuzzle({super.key});

  @override
  State<NonogramPuzzle> createState() => _NonogramPuzzleState();
}

class _NonogramPuzzleState extends State<NonogramPuzzle> {
  // Mảng 2D biểu thị trạng thái của lưới (false = đen, false = trắng)
  List<List<bool>> grid = List.generate(10, (_) => List.filled(10, false));

  // Gợi ý cho hàng (rows) và cột (columns) của hình trái tim
  final List<List<String>> rowClues = [
    [' ','1','1'],      // Hàng 1: 1 ô đen
    [' ','3','3'],      // Hàng 2: 3 ô đen
    [' ',' ','10'],      // Hàng 3: 5 ô đen
    ['2','4','2'],      // Hàng 4: 7 ô đen
    [' ',' ','10'],         // Hàng 5: 9 ô đen
    [' ',' ','10'],         // Hàng 6: 7 ô đen
    ['2','2','2'],       // Hàng 7: 5 ô đen
  [' ','2','2'],  // Hàng 8: 3 ô đen
  [' ',' ','4'],     // Hàng 9: 1 ô đen
    [' ',' ','2'],      // Hàng 10: 1 ô đen
  ];

  final List<List<int>> colClues = [
    [4],      // Cột 1: 4 ô đen
    [6],      // Cột 2: 6 ô đen
    [8],      // Cột 3: 8 ô đen
    [9],      // Cột 4: 9 ô đen
    [10],     // Cột 5: 10 ô đen
    [9],      // Cột 6: 9 ô đen
    [8],      // Cột 7: 8 ô đen
    [6],      // Cột 8: 6 ô đen
    [4],      // Cột 9: 4 ô đen
    [2],      // Cột 10: 2 ô đen
  ];

  // Giải pháp đúng (hình trái tim)
  final List<List<bool>> solution = [
    [false, false, true, false, false, false, false, true, false, false],   // Hàng 1
    [false, true, true, true, false, false, true, true, true, false],       // Hàng 2
    [true, true, true, true, true, true, true, true, true, true],           // Hàng 3
    [true, true, false, true, true, true, true, false, true, true],           // Hàng 4
    [true, true, true, true, true, true, true, true, true, true],
    [true, true, true, true, true, true, true, true, true, true],
    [false, true, true, false, true, true, false, true, true, false],           // Hàng 6
    [false, false, true, true, false, false, true, true, false, false],         // Hàng 7
    [false, false, false, true, true, true, true, false, false, false],       // Hàng 8
    [false, false, false, false, true, true, false, false, false, false],     // Hàng 9
  ];

  void toggleCell(int row, int col) {
    setState(() {
      grid[row][col] = !grid[row][col];
    });
  }

  bool isSolved() {
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        if (grid[i][j] != solution[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  List<int> hang1 = [4,6,4,2,2,2,2,4,6,4];
  List<String> hang2 = ['','','3','5','5','5','5','3','',''];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width/1.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int j = 0; j < 10; j++)
                    Container(
                      width: 25,
                      height: 25,
                      child: Text(hang2[j].toString(),textAlign: TextAlign.center,),
                    ),
                ]
            ),
            // Hiển thị gợi ý cột
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int j = 0; j < 10; j++)
                  Container(
                    width: 25,
                    height: 25,
                    child: Text(hang1[j].toString(),textAlign: TextAlign.center,),
                  ),
              ]
            ),
            for (int i = 0; i < 10; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Gợi ý hàng
                  Text(rowClues[i].join(' '), style: const TextStyle(fontSize: 14)),
                  // Lưới 10x10
                  SizedBox(width: 8,),
                  for (int j = 0; j < 10; j++)
                    GestureDetector(
                      onTap: () => toggleCell(i, j),
                      child: Container(
                        width: 25,
                        height: 25,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: grid[i][j] ? Colors.pink : Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 20),
            // Kiểm tra xem đã giải đúng chưa
            if (!isSolved())
              Container(
                  width: MediaQuery.of(context).size.width/1.6,
                child: const Text('Congratulations! You solved the heart puzzle!', style: TextStyle(fontSize: 20, color: Colors.pink)),
              )
          ],
        ),
      ),
    );
  }
}