import FlowSnake from "../contracts/engine/FlowSnake.cdc"
import SimpleSnake from "../contracts/SimpleSnake.cdc"
import SimpleBoardMap50 from "../contracts/map/SimpleBoardMap50.cdc"

transaction(snakeCount: UInt8) {
    prepare(gamer: AuthAccount) {

        let board = SimpleBoardMap50.Board()

        let game <- FlowSnake.createGame(board: board)

        var i: UInt8 = 0
        while (i < snakeCount) {
            let snake <- SimpleSnake.createSnake()
            game.addSnake(<-snake)
            i = i + 1
        }

        game.start()

        destroy game

    }
}