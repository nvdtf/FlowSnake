import FlowSnake from "../contracts/engine/FlowSnake.cdc"
import SimpleSnake from "../contracts/SimpleSnake.cdc"
import SimpleBoardMap10 from "../contracts/map/SimpleBoardMap10.cdc"

transaction(snakeCount: UInt8) {
    prepare(gamer: AuthAccount) {

        let board = SimpleBoardMap10.Board()

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