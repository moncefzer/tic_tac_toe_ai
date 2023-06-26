import 'package:tic_tact_toe_ai/entities/minmax.dart';

import 'entities.dart';

class AIPlayer extends Player {
  const AIPlayer({required super.value});

  Future<Move> getBestMove(Game game) async {
    return MinMax.getBestMoveWithMinMax(game);
  }
}
