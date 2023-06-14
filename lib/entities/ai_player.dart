import 'package:tic_tact_toe_ai/entities/minmax.dart';

import 'entities.dart';

class AIPlayer extends Player {
  const AIPlayer({required super.value});

  Future<Move> getBestMove(Game game) async {
    Move bestMove = game.getAvailableMoves()[0];
    int bestScore = -1000;
    for (Move move in game.getAvailableMoves()) {
      Game newGame = Game.clone(game);
      newGame.moveWithToggle(move);
      int score = MinMax.search(newGame, false, move);
      if (score > bestScore) {
        bestScore = score;
        bestMove = move;
      }
    }
    return bestMove;
  }
}
