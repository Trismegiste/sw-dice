<spa>
    <form class="pure-form" onsubmit="{onRoll}">
        <div class="pure-g">
            <div class="pure-u-1-3 number-column">
                <label each="{ number in [1,2,3,4,5] }"
                       onclick="{ parent.onChangeNumber }"
                       class="{ model.number == number ? 'selected' : false }">
                    {number}
                </label>
            </div>
            <div class="pure-u-1-3 face-column">
                <label each="{ face in [4,6,8,10,12] }"
                       onclick="{ parent.onChangeFace }"
                       class="{ model.face == face ? 'selected' : false }">
                    <i class="icon-d{face}"></i>
                </label>
            </div>
            <div class="pure-u-1-3 joker-column">
                <label each="{ joker in ['x', 6, 10] }"
                       onclick="{ parent.onChangeJoker }"
                       class="{ model.joker == joker ? 'selected' : false }">
                    <i class="icon-d{joker}"></i>
                </label>
            </div>
        </div>
        <div class="pure-g">
            <div class="pure-u-1-1 validate">
                <button class="pure-button button-primary pure-input-1">Roll</button>
            </div>
        </div>
        <div class="pure-g result">
            <div class="pure-u-1-2">
                <label>{result}</label>
            </div>
            <div class="pure-u-1-2">
                <label if="{emoticon}"><i class="icon-emo-{ emoticon }"></i></label>
            </div>
        </div>
        <div class="pure-g detail-result">
            <div class="pure-u-1-{ detail.length }" each="{detail}">
                <label>{value}</label>
            </div>
        </div>
    </form>
    <script>
        this.model = {
            number: 1,
            face: 8,
            joker: 6
        }
        this.detail = []
        this.result = '';
        this.emoticon = false

        var self = this

        onChangeNumber(e) {
            self.model.number = e.item.number
        }

        onChangeFace(e) {
            self.model.face = e.item.face
        }

        onChangeJoker(e) {
            self.model.joker = e.item.joker
        }

        onRoll() {
            self.detail = []
            self.result = 0
            var aceCount = 0
            // preparing dice pool : standard dices
            var pool = []
            for(var k = 0; k < self.model.number; k++) {
                pool.push({side: self.model.face})
            }
            // joker die
            if (self.model.joker !== 'x') {
                pool.push({side: self.model.joker})
            }
            // make roll
            dicePoolService.rollPool(pool).then(function(pool){
                for(var idx in pool) {
                    var p = pool[idx]
                    if (p.ace) {
                        aceCount++
                    }
                    if (p.value > self.result) {
                        self.result = p.value
                    }
                }
                self.detail = pool
                // emoticon
                if (aceCount === self.detail.length) {
                    self.emoticon = 'laugh'
                } else if (self.result === 1) {
                    self.emoticon = 'cry'
                } else {
                    self.emoticon = false
                }
                self.update()
            })
        }

    </script>
</spa>
