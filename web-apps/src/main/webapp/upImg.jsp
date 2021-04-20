
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>game</title>
    <script src="https://cdn.jsdelivr.net/npm/phaser@3.15.1/dist/phaser.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="./index.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
    <script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #c6cece; height: 2200px;">
<h2>Game Page</h2>
<div id="gameDisplay" class="container btn-info text-center"></div>
<script>
    let goodItems = [];
    goodItems.push('glfCard39');
    goodItems.push('glfCard40');
    goodItems.push('glfCard41');
    let gameDisp = document.getElementById("gameDisplay");
    let config = {
        type: Phaser.AUTO,
        width: 1000,
        height: 1600,
        scale:{
            parent: gameDisp
        },
        physics: {
            default: 'arcade',
            arcade: {
                gravity: { y: 200 }
            }
        },
        scene: {
            preload: preload,
            create: create
        }
    };
    let game = new Phaser.Game(config) ;
    let holdImgCards = [];
    let floor;
    function toStoreImgCards(){
        for(let i = 0; i < 54; i++) {
            holdImgCards.push( "glfCard" + i);
        }
        return holdImgCards;
    }
    function preload () {
        let getImgsCards = toStoreImgCards();
            if(getImgsCards !== null) {
                console.log("inside getImgCardsUpdated..");
                for (let i = 0; i < holdImgCards.length; i++) {
                    this.load.image("glfCard" + i, "images/cards/" + i + ".png");
                }
            }
    }
    class Card {
        constructor(scene) {
            this.render = (x, y, sprite) => {
                let card = scene.add.image(x, y, sprite)
                    .setScale(0.3, 0.3).setInteractive();
                scene.input.setDraggable(card);
                return card;
            }
        }
    }
    function create ()
    {
        //floor = this.add.rectangle(520, 700, 700, 450, 0x6666ff);
        let graphics = this.add.graphics();
        graphics.lineStyle(2, 0xffff00, 1);
        graphics.strokeRoundedRect(150, 530, 700, 450, 32);
        this.dealText = this.add.text(25, 720, ['PLAY CARDS'])
            .setFontSize(18).setFontFamily('Trebuchet MS')
            .setColor('#00ffff').setInteractive();
        let self = this;
        this.dealCards = () => {
            console.log("inside dealCards...");
            let playerCard = new Card(this);
            if(holdImgCards !== null) {
            lowChanceWin(this);
            highChanceWin(this);
        }}
     this.dealCards();
        this.dealText.on('pointerdown', function () {
            self.dealCards();
        })

        this.dealText.on('pointerover', function () {
            self.dealText.setColor('#ff69b4');
        })

        this.dealText.on('pointerout', function () {
            self.dealText.setColor('#00ffff');
        })

       this.input.on('drag', function (pointer, gameObject, dragX, dragY) {
            console.log("inside input on");
            gameObject.x = dragX;
            gameObject.y = dragY;
        })
    }
    function lowChanceWin(ev){
        let result;
        let playerCard = new Card(ev);
        for (let i = 0; i < 5; i++){
        result = holdImgCards[Math.floor(Math.random() * holdImgCards.length)];
        while(goodItems.includes(result)) {
            result = holdImgCards[Math.floor(Math.random() * holdImgCards.length)];
        }
            playerCard.render(320 + (i * 100), 300, result);
        }
    }
    function highChanceWin(tf){
        let rt2;
        let pd2 = new Card(tf);
        let fourItems = [];
        while (!goodItems.includes(rt2)) {
            rt2 = goodItems[Math.floor(Math.random() * goodItems.length)];
        }
        fourItems.push(rt2);
        for (let i = 0; i < 4; i++) {
            let rt3 = holdImgCards[Math.floor(Math.random() * holdImgCards.length)];
            fourItems.push(rt3);
        }
        let copyFourItems = [].concat(fourItems);
        let stCopyFour = copyFourItems.sort(() => 0.5 - Math.random());
        for(let i =0; i < 5; i++){
            pd2.render(320 + (i * 100), 1200, stCopyFour[i]);
        }
    }
</script>
</body>
</html>
