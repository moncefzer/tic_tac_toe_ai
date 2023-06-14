import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/ai_player.dart';
import '../entities/entities.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState());

  static GameCubit get(context) => BlocProvider.of(context);
  Game game = Game();
  bool loading = false;

  void makeMove(Move move) async {
    if (state.isGameOver || loading) return;

    await _playerTurn(move);

    await _aiTurn();
  }

  void _updateUI() {
    if (state.isGameOver) return;
    final currentPlayer = game.player;
    emit(state.copyWith(player: currentPlayer));
  }

  Future<void> _playerTurn(Move move) async {
    game.moveWithoutToggle(move);
    _checkWin(move);
  }

  Future<void> _aiTurn() async {
    final currentPlayer = game.player;
    if (currentPlayer is AIPlayer) {
      loading = true;
      await Future.delayed(const Duration(milliseconds: 500));
      final bestMove = await currentPlayer.getBestMove(game);
      game.moveWithoutToggle(bestMove);
      _checkWin(bestMove);
      loading = false;
    }
  }

  void _checkWin(Move move) {
    var gameResult = game.checkWin(move);
    if (gameResult == GameStatus.draw || gameResult == GameStatus.win) {
      final currentPlayer = game.player;
      emit(state.copyWith(
        isGameOver: true,
        status: gameResult,
        player: currentPlayer,
      ));
    } else {
      game.togglePlayer();
      _updateUI();
    }
  }

  repeatGame() {
    game = Game();
    loading = false;
    emit(GameState());
  }
}
