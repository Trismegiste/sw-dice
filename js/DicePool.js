// dice roler library

var DicePool = function () {
    this.random = new Random(Random.engines.mt19937().autoSeed())
    this.container = [] // FIFO
    this.diceCount = 4
}

DicePool.prototype.rollOne = function (side) {
    var self = this

    if (this.container.length === 0) {
        return new Promise(function (fulfill, reject) {
            fetch('https://www.random.org/integers/?num='
                    + self.diceCount
                    + '&min=1&max=120&col='
                    + self.diceCount
                    + '&base=10&format=plain&rnd=new').then(function (response) {
                return response.text()
            }).then(function (content) {
                var extracted = content.split("\t");
                for (var k = 0; k < self.diceCount; k++) {
                    self.container[k] = parseInt(extracted[k]);
                }

                self.rollOne(side).then(function (r) {
                    fulfill(r)
                })
            })
        })
    } else {
        return new Promise(function (fulfill, reject) {
            var r = self.container.shift()
            fulfill(1 + r % side)
        })

    }
}














DicePool.prototype.roll = function (side) {
    var self = this

    if (this.container.length === 0) {
        this.container = fetch('https://www.random.org/integers/?num='
                + this.diceCount
                + '&min=1&max=120&col='
                + this.diceCount
                + '&base=10&format=plain&rnd=new').then(function (response) {
            return response.blob()
        }).then(function (content) {
            var res
            var extracted = content.split("\t");
            for (var k = 0; k < self.diceCount; k++) {
                res[k] = parseInt(extracted[k]);
            }

            return res
        })
    }

    console.log(this.container)

    var r = this.container.shift()

    return 1 + r % side
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

DicePool.prototype.rollPool = function (pool) {
    var self = this

    if (pool.length === 0) {
        return new Promise(function (fulfill, reject) {
            fulfill([])
        })
    } else {
        return new Promise(function (fulfill, reject) {

        })
    }

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