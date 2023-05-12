import SimpleSnake from "../SimpleSnake.cdc"
import SimpleRules from "./SimpleRules.cdc"
import SimpleModels from "./SimpleModels.cdc"
import Util from "./Util.cdc"

pub contract FlowSnake {

    pub event GameResult(numPlayers: UInt8, turns: UInt, moves: String)

    pub event DebugBoard(turn: UInt, board: [[UInt8]])

    pub resource Game {

        pub var rules: @SimpleRules.Rules
        pub var snakes: @[SimpleSnake.Snake]

        init(board: {SimpleModels.Board}) {
            self.rules <- SimpleRules.createRules(board: board)
            self.snakes <- []
        }

        pub fun addSnake(_ snake: @SimpleSnake.Snake) {
            self.rules.registerPlayer(index: UInt8(self.snakes.length))
            self.snakes.append(<-snake)
        }

        pub fun start() {

            var currentPlayer: UInt8 = 0

            var finished = false

            var i: UInt = 0

            var moves = ""

            // emit DebugBoard(turn: i, board: self.rules.debugPrintBoard())

            while(!finished) {

                let move = self.snakes[currentPlayer].move(playerIndex: currentPlayer, game: &self.rules as &SimpleRules.Rules)

                moves = moves.concat(move)

                let moveResult = self.rules.processMove(currentPlayer, move)

                // if i% 10 == 0 {
                //     emit DebugBoard(turn: i, board: self.rules.debugPrintBoard())
                // }

                finished = moveResult == "E"
                // if i == 100 {
                //     break
                // }

                i = i + 1

                currentPlayer=currentPlayer+1
                if Int(currentPlayer)==self.snakes.length {
                    currentPlayer=0
                }
            }

            // emit DebugBoard(turn: i, board: self.rules.debugPrintBoard())

            emit GameResult(numPlayers: UInt8(self.snakes.length), turns: i, moves: moves)

        }

        destroy() {
            destroy self.snakes
            destroy self.rules
        }

    }

    pub fun createGame(board: {SimpleModels.Board}): @Game {
        return <- create Game(board: board)
    }

}