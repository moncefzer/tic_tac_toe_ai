import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tact_toe_ai/cubit/game_cubit.dart';
import 'package:tic_tact_toe_ai/res/app_colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'entities/entities.dart';
import 'widgets/borad_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocConsumer<GameCubit, GameState>(
          listener: (context, state) {
            if (state.isGameOver == true && state.status == GameStatus.win) {
              _windDialog(context, state).show();
            }
            if (state.isGameOver == true && state.status == GameStatus.draw) {
              _drawDialog(context).show();
            }
          },
          builder: (context, state) {
            final cubit = GameCubit.get(context);
            var board = cubit.game.board;
            return Column(
              children: [
                const Spacer(flex: 2),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Turn :',
                      ),
                      TextSpan(
                        text: ' player (${state.player})',
                        style: TextStyle(
                          color: state.player.value == Cell.X
                              ? AppColors.red
                              : AppColors.green,
                        ),
                      ),
                    ],
                  ),
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(flex: 2),
                BoardWidget(board: board),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: GameCubit.get(context).repeatGame,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Restart Game',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            );
          },
        ),
      ),
    );
  }

  AwesomeDialog _windDialog(BuildContext context, GameState state) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Win',
      titleTextStyle: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
      ),
      descTextStyle: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
      ),
      desc: 'Player ${state.player} Win',
      btnOkOnPress: () {},
    );
  }

  AwesomeDialog _drawDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Draw',
      titleTextStyle: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
      ),
      descTextStyle: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
      ),
      desc: 'This was a draw game',
      btnOkOnPress: () {},
    );
  }
}
