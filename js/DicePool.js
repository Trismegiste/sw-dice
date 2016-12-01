// dice roler library

var DicePool = function () {
    this.random = new Random(Random.engines.mt19937().autoSeed())
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
