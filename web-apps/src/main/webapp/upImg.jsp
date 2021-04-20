
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
<body style="background-color: #c6cece; height: 1600px;">
<h2>Game Page</h2>
<div id="gameDisplay" class="container btn-info text-center"></div>
<script>
    let gameDisp = document.getElementById("gameDisplay");
    let config = {
        type: Phaser.AUTO,
        width: 1000,
        height: 800,
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
    function preload ()
    {
        this.load.image('glfCard', 'images/card.jpeg');
/*        this.load.image('cyanCardBack', 'images/card2.png');
        this.load.image('magentaCardFront', 'images/card3.png');
        this.load.image('magentaCardBack', 'images/card4.png');*/
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
        this.dealText = this.add.text(55, 350, ['PLAY CARDS'])
            .setFontSize(18).setFontFamily('Trebuchet MS')
            .setColor('#00ffff').setInteractive();
        let self = this;
        /*this.card = this.add.image(320, 300, 'glfCard')
                    .setScale(0.3, 0.3)
                    .setInteractive();*/
        //this.input.setDraggable(this.card);
        //this.input.setDraggable(new Card(this));
        this.dealCards = () => {
            console.log("inside dealCards...");
            let playerCard = new Card(this);
           for (let i = 0; i < 5; i++) {
                playerCard.render(320 + (i * 100), 300, 'glfCard');
                console.log("rendered...");
            }
        }
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
</script>
</body>
</html>
