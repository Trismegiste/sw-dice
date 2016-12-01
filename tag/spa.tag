<spa>
    <form class="pure-form">
        <div class="pure-g">
            <div class="pure-u-1-3">
                <label each="{ number in [1,2,3,4,5] }">
                    <input name="number" type="radio" value="{number}"/>{number}
                </label>
            </div>
            <div class="pure-u-1-3">
                <label each="{ face in [4,6,8,10,12] }">
                    <input name="dice" type="radio" value="{face}"/><i class="icon-d{face}"></i>
                </label>
            </div>
            <div class="pure-u-1-3">
                <label>
                    <input name="joker" type="radio" value="{face}"/> X
                </label>
                <label each="{ face in [6,10] }">
                    <input name="joker" type="radio" value="{face}"/><i class="icon-d{face}"></i>
                </label>
            </div>
        </div>
        <div class="pure-g">
            <div class="pure-u-1-1 centered">
                <button class="pure-button pure-button-primary">Roll</button>
            </div>
        </div>
    </form>
    <script>

    </script>
</spa>
