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
            <div class="pure-u-1-{ detail.length }" each="{oneDie in detail}">
                <label>{oneDie}</label>
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
            // standard dices
            for(var k = 0; k < self.model.number; k++) {
                var roll = dicePoolService.unlimitRoll(self.model.face)
                self.detail.push(roll)
                if (roll > self.model.face) {
                    aceCount++
                }
            }
            // joker die
            if (self.model.joker !== 'x') {
                var roll = dicePoolService.unlimitRoll(self.model.joker)
                self.detail.push(roll)
                if (roll > self.model.joker) {
                    aceCount++
                }
            }
            // result
            self.result = Math.max.apply(null, self.detail)
            // emoticon
            if (aceCount === self.detail.length) {
                self.emoticon = 'laugh'
            } else if (self.result === 1) {
                self.emoticon = 'cry'
            } else {
                self.emoticon = false
            }
        }

    </script>
</spa>
