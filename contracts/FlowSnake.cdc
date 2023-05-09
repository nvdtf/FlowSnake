import SimpleSnake from "./SimpleSnake.cdc"
import SimpleBoard from "./SimpleBoard.cdc"

pub contract FlowSnake {

    pub event BoardUpdate(turn: UInt, board: [[UInt8]])

    pub resource Game {

        pub var board: @SimpleBoard.Board
        pub var snakes: @[SimpleSnake.Snake]

        init(boardSize: UInt8) {
            self.board <- SimpleBoard.createBoard(size: boardSize)
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

            while(!finished) {

                let move = self.snakes[currentPlayer].move(board: &self.board as &SimpleBoard.Board)

                self.board.processMove(currentPlayer, move)

                emit BoardUpdate(turn: i, board: self.board.printBoard())

                //finished = self.checkWin()
                if i == 3 {
                    break
                }

                i = i + 1

                currentPlayer=currentPlayer+1
                if Int(currentPlayer)==self.snakes.length {
                    currentPlayer=0
                }
            }

        }

        pub fun checkWin(): Bool {
            return self.snakes.length == 1
        }

        destroy() {
            destroy self.snakes
            destroy self.board
        }

    }

    pub fun createGame(boardSize: UInt8): @Game {
        return <- create Game(boardSize: boardSize)
    }

}