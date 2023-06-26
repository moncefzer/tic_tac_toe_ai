# Tic Tac Toe with Minimax Algorithm

This is a Tic Tac Toe game implemented in Flutter, featuring an AI opponent powered by the Minimax algorithm. The Minimax algorithm is used to determine the optimal moves for the AI player, making it a challenging opponent to beat.

## Game Description

Tic Tac Toe is a classic two-player game played on a 3x3 grid. The players take turns marking X or O in empty cells, with the goal of getting three of their marks in a row, column, or diagonal. The first player to achieve this wins the game. If all cells are filled without a winner, the game ends in a draw.

## Demo

## Minimax Algorithm

The Minimax algorithm is a decision-making algorithm used in two-player games with perfect information. In our Tic Tac Toe game, it is employed by the AI opponent to determine the optimal moves.

The basic principle of the Minimax algorithm is as follows:

1. The algorithm explores all possible moves and evaluates the resulting game states.
2. Each game state is assigned a score, representing how favorable or unfavorable it is for the AI player.
3. The algorithm assumes that the opponent plays optimally and selects the move that minimizes the AI player's score (worst outcome).
4. It recursively explores deeper by simulating the opponent's moves and backtracks to assign scores.
5. Finally, it selects the move with the highest score as the optimal move for the AI player.

By employing the Minimax algorithm, the AI opponent in our Tic Tac Toe game becomes more challenging, as it strives to make the best possible moves and maximize its chances of winning.

![MinMax demo](demo/minmax.png)

## Installation

1. Clone the repository:

   ```
   git clone https://github.com/your-username/tic_tac_toe.git
   ```

2. Navigate to the project directory:

   ```
   cd tic_tac_toe
   ```

3. Install the required dependencies:

   ```
   flutter pub get
   ```

4. Run the app:

   ```
   flutter run
   ```

## License

This project is licensed under the MIT License
