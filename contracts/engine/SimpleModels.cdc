import Util from "./Util.cdc"

pub contract SimpleModels {

    pub struct interface Board {
        pub fun getSize(): UInt8
        pub fun getPlayerSpawns(): {UInt8: [Util.Coordination]}
        pub fun getFruits(): {UInt8: Util.Coordination}
    }

}