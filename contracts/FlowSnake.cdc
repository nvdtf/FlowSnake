import SimpleSnake from "./SimpleSnake.cdc"
import SimpleBoard from "./SimpleBoard.cdc"

pub contract FlowSnake {

    pub event BoardUpdate(turn: UInt, board: [[UInt8]])
    pub event GameResult(numPlayers: UInt8, moves: String)

    pub resource Game {

        pub var board: @SimpleBoard.Board
        pub var snakes: @[SimpleSnake.Snake]

        init(boardSize: UInt8, fruitCount: UInt8) {
            self.board <- SimpleBoard.createBoard(size: boardSize, fruitCount: fruitCount)
            self.snakes <- []
        }

        pub fun addSnake(_ snake: @SimpleSnake.Snake) {
            self.board.registerPlayer(index: UInt8(self.snakes.length))
            self.snakes.append(<-snake)
        }

        pub fun start() {

            var currentPlayer: UInt8 = 0

            var finished = false

            var i: UInt = 0

            var moves = ""

            while(!finished) {

                if i% 1 == 0 {
                    emit BoardUpdate(turn: i, board: self.board.printBoard())
                }

                let move = self.snakes[currentPlayer].move(playerIndex: currentPlayer, board: &self.board as &SimpleBoard.Board)

                moves = moves.concat(move)

                self.board.processMove(currentPlayer, move)

                // finished = self.checkWin()
                if i == 10 {
                    break
                }

                i = i + 1

                currentPlayer=currentPlayer+1
                if Int(currentPlayer)==self.snakes.length {
                    currentPlayer=0
                }
            }

            emit GameResult(numPlayers: UInt8(self.snakes.length), moves: moves)

        }

        pub fun checkWin(): Bool {
            return self.snakes.length == 1
        }

        destroy() {
            destroy self.snakes
            destroy self.board
        }

    }

    pub fun createGame(boardSize: UInt8, fruitCount: UInt8): @Game {
        return <- create Game(boardSize: boardSize, fruitCount: fruitCount)
    }

}