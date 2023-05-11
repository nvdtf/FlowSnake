import SimpleModels from "../engine/SimpleModels.cdc"
import Util from "../engine/Util.cdc"

pub contract SimpleBoardMap25 {

    pub struct Board: SimpleModels.Board {

        pub let size: UInt8
        pub let playerSpawn: {UInt8: [Util.Coordination]}
        pub let fruits: {UInt8: Util.Coordination}

        init() {
            self.size = 25
            self.playerSpawn = {
                0: [Util.Coordination(X: 1, Y: 1)],
                1: [Util.Coordination(X: self.size - 2, Y: 1)],
                2: [Util.Coordination(X: 1, Y: self.size - 2)],
                3: [Util.Coordination(X: self.size - 2, Y: self.size - 2)]
            }
            self.fruits = {
                0: Util.Coordination(X: 0, Y: 0),
                1: Util.Coordination(X: 2, Y: 2),
                2: Util.Coordination(X: 5, Y: 5),
                3: Util.Coordination(X: 3, Y: 2),
                4: Util.Coordination(X: 7, Y: 1),
                5: Util.Coordination(X: 7, Y: 8),
                6: Util.Coordination(X: 17, Y: 11),
                7: Util.Coordination(X: 21, Y: 3),
                8: Util.Coordination(X: 14, Y: 6),
                9: Util.Coordination(X: 3, Y: 20),
                10: Util.Coordination(X: 13, Y: 22),
                11: Util.Coordination(X: 23, Y: 5),
                12: Util.Coordination(X: 9, Y: 8),
                13: Util.Coordination(X: 11, Y: 6),
                14: Util.Coordination(X: 21, Y: 21)
            }
        }

        pub fun getSize(): UInt8 {
            return self.size
        }

        pub fun getPlayerSpawns(): {UInt8: [Util.Coordination]} {
            return self.playerSpawn
        }

        pub fun getFruits(): {UInt8: Util.Coordination} {
            return self.fruits
        }

    }

}