import SimpleModels from "../engine/SimpleModels.cdc"
import Util from "../engine/Util.cdc"

pub contract SimpleBoardMap10 {

    pub struct Board: SimpleModels.Board {

        pub let size: UInt8
        pub let playerSpawn: {UInt8: [Util.Coordination]}
        pub let fruits: {UInt8: Util.Coordination}

        init() {
            self.size = 10
            self.playerSpawn = {
                0: [Util.Coordination(X: 1, Y: 1)],
                1: [Util.Coordination(X: 8, Y: 1)],
                2: [Util.Coordination(X: 1, Y: 8)],
                3: [Util.Coordination(X: 8, Y: 8)]
            }
            self.fruits = {
                0: Util.Coordination(X: 0, Y: 0),
                1: Util.Coordination(X: 2, Y: 2),
                2: Util.Coordination(X: 5, Y: 5),
                3: Util.Coordination(X: 3, Y: 2),
                4: Util.Coordination(X: 7, Y: 1),
                5: Util.Coordination(X: 7, Y: 8)
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