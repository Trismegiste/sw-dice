// dice roler library

var DicePool = function () {
    this.random = new Random(Random.engines.mt19937().autoSeed())
    this.container = [] // FIFO
}

DicePool.prototype.roll = function (side) {
    return  this.random.integer(1, side)
}

DicePool.prototype.unlimitRoll = function (side) {
    var dice = 0
    do {
        var roll = this.roll(side)
        dice += roll
    } while (roll === side)

    return dice
}

DicePool.prototype.jokerRoll = function (side) {
    return Math.max(this.unlimitRoll(side), this.unlimitRoll(6))
}

DicePool.prototype.getPromise = function (param) {
    var self = this
    return new Promise(function (fulfill, reject) {
        if (self.container.length > 0) {
            var extract = self.container.shift()
            param.roll = Math.ceil(extract * param.side / 120)
            fulfill(param)
        } else {

        }
    })
}

DicePool.prototype.rollPool = function (pool) {
    var self = this
    return new Promise(function (fulfill, reject) {
        for (var idx in pool) {
            var r = pool[idx]
            r.value = self.unlimitRoll(r.side)
            if (r.value > r.side) {
                r.ace = true
            }
        }
        fulfill(pool)
    })
}