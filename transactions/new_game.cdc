import FlowSnake from "../contracts/FlowSnake.cdc"
import SimpleSnake from "../contracts/SimpleSnake.cdc"

transaction {
    prepare(gamer: AuthAccount) {

        let game <- FlowSnake.createGame(boardSize: 3)

        let snake1 <- SimpleSnake.createSnake()
        let snake2 <- SimpleSnake.createSnake()

        game.addSnake(<-snake1)
        game.addSnake(<-snake2)

        game.start()

        destroy game

    }
}