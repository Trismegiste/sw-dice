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
            <div class="pure-u-1-{ result.length }" each="{oneDie in result}">
                <label>{oneDie}</label>
            </div>
        </div>
    </form>
    <script>
        this.model = {
            number: 1,
            face: 4,
            joker: 6
        }
        this.result = [6,5,24,5,5,8]
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
            var nb
        }

    </script>
</spa>
