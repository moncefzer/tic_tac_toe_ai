import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tact_toe_ai/cubit/game_cubit.dart';

import 'entities/entities.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          GameCubit.get(context).repeatGame();
        },
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          BlocConsumer<GameCubit, GameState>(
            listener: (context, state) {
              if (state.isGameOver == true && state.status == GameStatus.win) {
                final snackBar = SnackBar(
                  content: Text('Player ${state.player} Win'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state.isGameOver == true && state.status == GameStatus.draw) {
                const snackBar = SnackBar(
                  content: Text('Draw game'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              final cubit = GameCubit.get(context);
              var board = cubit.game.board;
              return Column(
                children: [
                  Text(
                    'Current player : ${state.player}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  BoardWidget(board: board),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Tic Tac Toe'),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    super.key,
    required this.board,
  });

  final List<List<Cell>> board;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < board.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int j = 0; j < board[i].length; j++)
                CellWidget(row: i, col: j, cellValue: board[i][j]),
            ],
          )
      ],
    );
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget({
    super.key,
    required this.row,
    required this.col,
    required this.cellValue,
  });
  final int row;
  final int col;
  final Cell cellValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cellValue != Cell.empty) return;
        GameCubit.get(context).makeMove(Move(row, col));
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        color: cellValue == Cell.empty ? Colors.grey : Colors.redAccent,
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: Text(
          cellValue != Cell.empty ? cellValue.name : ' ',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
