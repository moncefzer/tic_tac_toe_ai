import 'dart:math';

import 'entities.dart';

class MinMax {
  static int evaluate(Game game, Move move) {
    if (game.isWinner(playerO, move)) return 1;

    if (game.isWinner(playerX, move)) return -1;

    return 0;
  }

  static int search(Game game, bool maximizingPlayer, Move move) {
    final eval = evaluate(game, move);

    if (eval == -1 || eval == 1 || eval == 0 && game.isFinished()) return eval;

    if (maximizingPlayer) {
      int maxEval = -1000;
      for (Move move in game.getAvailableMoves()) {
        Game newGame = Game.clone(game);
        newGame.moveWithToggle(move);
        int eval = search(newGame, false, move);
        maxEval = max(maxEval, eval);
      }
      return maxEval;
    } else {
      int minEval = 1000;
      for (Move move in game.getAvailableMoves()) {
        Game newGame = Game.clone(game);
        newGame.moveWithToggle(move);
        int eval = search(newGame, true, move);
        minEval = min(minEval, eval);
      }
      return minEval;
    }
  }
}
