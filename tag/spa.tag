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
        <div class="pure-g {hidden: !waiting}">
            <div class="pure-u-1-1 spinner-waiting">
                <label><i class="icon-spinner animate-spin"></i></label>
            </div>
        </div>
        <div class="{hidden: waiting}">
            <div class="pure-g">
                <div class="pure-u-1-1 validate">
                    <button class="pure-button button-primary pure-input-1">Roll</button>
                </div>
                <div class="pure-u-1-1">
                    <label if="{result > 1}">{result}</label>
                    <label if="{result == 1}"><i class="icon-emo-cry"></i></label>
                </div>
            </div>
            <div class="pure-g detail-result">
                <div class="pure-u-1-{ detail.length }" each="{rolled in detail}">
                    <label>{rolled}</label>
                </div>
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
            self.waiting = true
            self.detail = []
            self.result = 0
            // preparing dice pool : standard dices
            var pool = []
            for(var k = 0; k < self.model.number; k++) {
                pool.push(self.model.face)
            }
            // joker die
            if (self.model.joker !== 'x') {
                pool.push(self.model.joker)
            }
            // make roll
            dicePoolService.rollPool(pool).then(function(rolled){
                setTimeout(function () {
                    self.result = Math.max.apply(null, rolled)
                    self.detail = rolled
                    self.waiting = false;
                    // sound
                    if (self.result == 1) {
                        inceptionSound.seek(0.8)
                        inceptionSound.play();
                    } else {
                        rollSound.play()
                    }
                    // udpate when the promise is fulfill
                    self.update()
                }, 300)
            })
        }

    </script>
</spa>
