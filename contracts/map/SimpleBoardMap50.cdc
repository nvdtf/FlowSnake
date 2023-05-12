import SimpleModels from "../engine/SimpleModels.cdc"
import Util from "../engine/Util.cdc"

pub contract SimpleBoardMap50 {

    pub struct Board: SimpleModels.Board {

        pub let size: UInt8
        pub let playerSpawn: {UInt8: [Util.Coordination]}
        pub let fruits: {UInt8: Util.Coordination}

        init() {
            self.size = 50
            self.playerSpawn = {
                0: [Util.Coordination(X: 1, Y: 1)],
                1: [Util.Coordination(X: self.size - 2, Y: 1)],
                2: [Util.Coordination(X: 1, Y: self.size - 2)],
                3: [Util.Coordination(X: self.size - 2, Y: self.size - 2)]
            }

            let fruitsX: [UInt8] = [45,7,32,8,49,24,11,18,36,26,49,3,4,32,18,29,36,14,16,47,47,6,24,28,45,46,10,15,24,5,7,37,1,24,0,27,26,37,24,45,1,12,23,33,19,31,33,4,2,23,28,35,38,16,27,4,18,34,39,8,39,32,13,7,1,25,32,16,15,43]
            let fruitsY: [UInt8] = [47,49,7,22,47,44,40,18,4,7,40,17,4,8,31,18,13,23,35,21,42,43,23,28,46,3,11,48,12,41,25,1,33,38,17,17,4,19,25,17,28,25,46,47,45,41,24,2,27,0,48,46,46,46,10,33,2,32,3,33,40,23,1,41,1,30,37,40,37,40]

            self.fruits = {}

            for i, x in fruitsX {
                self.fruits.insert(key: UInt8(i), Util.Coordination(X: x, Y: fruitsY[i]))
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