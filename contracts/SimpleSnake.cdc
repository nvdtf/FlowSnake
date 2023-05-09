import SimpleBoard from "./SimpleBoard.cdc"

pub contract SimpleSnake {

    pub resource Snake {

        pub var posX: UInt8
        pub var posY: UInt8

        init(posX: UInt8, posY: UInt8) {
            self.posX = posX
            self.posY = posY
        }

        pub fun move(board: &SimpleBoard.Board): String {
            return "R"
        }

    }

    pub fun createSnake(): @Snake {
        return <- create Snake(posX: 0, posY: 0)
    }

}