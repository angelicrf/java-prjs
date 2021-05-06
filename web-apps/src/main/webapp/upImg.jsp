
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
            //update: update
            //render: render
        }
    };
    let game = new Phaser.Game(config) ;
    let holdImgCards = [];
    let newNameArray = [];
    newNameArray.push({topImg : 'top', btnImg : 'btn'}, {topImg : 'tOne', btnImg : 'bOne'}, {topImg : 'tTwo', btnImg : 'bTwo'}, {topImg : 'tThree', btnImg : 'bThree'}, {topImg : 'tFour', btnImg : 'bFour'});
    let copyFourItems = null;
    let floor;
    let isFlipped = false;
    let isSelected = false;
    let isSelected2 = false;
    let isSelected3 = false;
    let isSelected4 = false;
    let isSelected5 = false;
    //
    let isTopSelected = false;
    let isTopSelected2 = false;
    let isTopSelected3 = false;
    let isTopSelected4 = false;
    let isTopSelected5 = false;
    let isDraggedItem = false;
    let countTop = 0;
    let countBtn = 0;
    let holdTopImgs = [];
    let holdTween = null;
    let cardInex = 0;
    let handScale = null;
    let bcCardScale = null;
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
            for(let i = 1; i < 5; i++) {
                this.load.image('player' + i, 'images/player_hand.jpg');
            }
        this.load.image('backCard', 'images/cards/back.jpg');
    }
    class Card {
        constructor(scene = {}) {
            this.card = null;
            this.render = (x, y, sprite) => {
                //{ cursor: 'url(/images/player_hand.jpg), pointer' }
               this.card = bcCardScale !== null ? scene.add.image(x, y, sprite).setScale(0.3, 0.3).setInteractive()
                           :  scene.add.image(x, y, 'player1').setScale(0.12, 0.12).setInteractive().setAngle(45) &&
                              scene.add.image(x, y, 'player2').setScale(0.12, 0.12).setInteractive().setAngle(45) &&
                              scene.add.image(x, y, 'player3').setScale(0.12, 0.12).setInteractive().setAngle(45) &&
                              scene.add.image(x, y, 'player4').setScale(0.12, 0.12).setInteractive().setAngle(45);
                scene.input.setDraggable(this.card);
                return this.card;
            }
            return this.card;
        }
    }

    function create () {  //floor = this.add.rectangle(520, 700, 700, 450, 0x6666ff);
        //this.input.setDefaultCursor('url(../images/player_hand.jpg), default');
        //let gameCursor = this.add.sprite(320, , 'player1').setInteractive({ cursor: 'url(images/player_hand.jpg), pointer' });

        let graphics = this.add.graphics();
        graphics.lineStyle(2, 0xffff00, 1);
        //graphics.strokeRoundedRect(520, 700, 700, 450, 32);
        let zone = this.add.zone(520, 700, 700, 450).setRectangleDropZone(700, 450);
        graphics.strokeRect(zone.x - zone.input.hitArea.width / 2, zone.y - zone.input.hitArea.height / 2, zone.input.hitArea.width, zone.input.hitArea.height);
        this.dealText = this.add.text(25, 720, ['PLAY CARDS'])
            .setFontSize(18).setFontFamily('Trebuchet MS')
            .setColor('#00ffff').setInteractive();
        let self = this;
        this.finalCoords = [];
        this.dealCards = () => {
            console.log("inside dealCards...");
            if (holdImgCards !== null) {
                handPlayers(this);
                displayBackCards(this);
                lowChanceWin(this);
                highChanceWin(this);
            }
        }
        this.createTweens = (ev, scX, scY) => {
            console.log(scX, scY);
            ev.backFace = ev.add.image(parseInt(scX), parseInt(scY), 'backCard').setScale(0.3, 0.3);
            holdTween = async () => {
                return await new Promise((resolve, reject) => {
                    ev.tweens.add({
                        targets: ev.backFace,
                        duration: 500,
                        scaleX: 0.3 * -0.5,
                        ease: "Linear",
                        repeat: 0,
                        onComplete: () => {
                            console.log("inside onComplete....");
                            ev.backFace.visible = false;
                            isFlipped = true;
                            return resolve(isFlipped);
                        }
                    });
                });
            }
            holdTween().then((rf) => {
                console.log(rf);
                if (rf) {
                    let nameBtnImg = null;
                    if (!isSelected && !isSelected2 && !isSelected3 && !isSelected4 && !isSelected5) {
                        console.log("firstIsSelected ");
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[0]).setScale(0.3, 0.3);
                        isSelected = true;
                        hasItemsSearch(nameBtnImg, 'btn');
                    }else if(isSelected && !isSelected2 && !isSelected3 && !isSelected4 && !isSelected5){
                        console.log("secondIsSelected ");
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[1]).setScale(0.3, 0.3);
                        isSelected = false;
                        isSelected2 = true;
                        hasItemsSearch(nameBtnImg, 'btn');
                    }else if (isSelected2 && !isSelected && !isSelected3 && !isSelected4 && !isSelected5) {
                        console.log("thirdIsSelected ");
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[2]).setScale(0.3, 0.3);
                        isSelected2 = false;
                        isSelected3 = true;
                        hasItemsSearch(nameBtnImg, 'btn');
                    }else if (isSelected3 && !isSelected2 && !isSelected && !isSelected4 && !isSelected5) {
                        console.log("fourthIsSelected ");
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[3]).setScale(0.3, 0.3);
                        isSelected3 = false;
                        isSelected4 = true;
                        console.log("is4" + isSelected4 + "is3" + isSelected3 + "is2" + isSelected2 + "is1" + isSelected)
                        hasItemsSearch(nameBtnImg, 'btn');
                    }else if (isSelected4 && !isSelected2 && !isSelected && !isSelected3 && !isSelected5 ) {
                        console.log("fifthIsSelected ");
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[4]).setScale(0.3, 0.3);
                        isSelected4 = false;
                        isSelected5 = true;
                        console.log("is5" + isSelected5 + "is4" + isSelected4 + "is3" + isSelected3 + "is2" + isSelected2 + "is1" + isSelected)
                        hasItemsSearch(nameBtnImg, 'btn');
                        isSelected5 = false;
                    }
                }
            })
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
        this.input.on('dragstart', function(pointer,gameObject){
            this.children.bringToTop(gameObject);
        },this)
        this.input.on('drag', function(pointer,gameObject,dragX,dragY){
            let addTextureKey = [];
            addTextureKey.push(gameObject);
            let stTextureKey = addTextureKey.map(ef => ef.texture.key);
            let strTextureKey = JSON.stringify(stTextureKey[0]).slice(1,JSON.stringify(stTextureKey[0]).length -1);
            console.log("dragItem is " + strTextureKey);
            if(strTextureKey !== "player1" || strTextureKey !== "player2" ||
               strTextureKey !== "player3" || strTextureKey !== "player4" || strTextureKey !== "player5"  ) {
                if ((countTop === 0 && countTop !== 1)) {
                    if (strTextureKey !== "backCard") {
                        gameObject.input.enabled = true;
                        gameObject.x = dragX;
                        gameObject.y = dragY;
                        gameObject.input.enabled = false;
                    } else if (strTextureKey === "backCard" && isDraggedItem) {
                        gameObject.input.enabled = false;
                    }
                } else if (countTop === 1 && countTop !== 0) {
                    if (strTextureKey === "backCard") {
                        if (countBtn === 0) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    } else if (strTextureKey !== "backCard") {
                        if (countBtn === 1) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    }
                } else if (countTop === 2 && countTop !== 0 && countTop !== 1) {
                    if (strTextureKey === "backCard") {
                        if (countBtn === 1) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    } else if (strTextureKey !== "backCard") {
                        if (countBtn === 2) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    }
                } else if (countTop === 3 && countTop !== 2 && countTop !== 0 && countTop !== 1) {
                    if (strTextureKey === "backCard") {
                        if (countBtn === 2) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    } else if (strTextureKey !== "backCard") {
                        if (countBtn === 3) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    }
                } else if (countTop === 4 && countTop !== 3 && countTop !== 2 && countTop !== 0 && countTop !== 1) {
                    if (strTextureKey === "backCard") {
                        if (countBtn === 3) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    } else if (strTextureKey !== "backCard") {
                        if (countBtn === 4) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    }
                } else if (countTop === 5 && countTop !== 4 && countTop !== 3 && countTop !== 2 && countTop !== 0 && countTop !== 1) {
                    if (strTextureKey === "backCard") {
                        if (countBtn === 4) {
                            gameObject.x = dragX;
                            gameObject.y = dragY;
                            isDraggedItem = true;
                        }
                    }
                }
            }//end players
        })
        this.input.on('dragenter', function(pointer,gameObject,dropZone){
            graphics.clear();
            graphics.lineStyle(2, 0xffff00, 1);
            graphics.strokeRect(zone.x - zone.input.hitArea.width / 2 , zone.y - zone.input.hitArea.height / 2, zone.input.hitArea.width, zone.input.hitArea.height);
        })
        this.input.on('dragleave', function(pointer,gameObject,dropZone){
            graphics.clear();
            graphics.lineStyle(2, 0xffff00, 1);
            graphics.strokeRect(zone.x - zone.input.hitArea.width / 2 , zone.y - zone.input.hitArea.height / 2 , zone.input.hitArea.width, zone.input.hitArea.height);
        })
        this.input.on('drop', function(pointer,gameObject,dropZone){
            console.log("inside dropZone..." );
            let addTextureKey = [];
            addTextureKey.push(gameObject);
            let stTextureKey = addTextureKey.map(ef => ef.texture.key);
            let strTextureKey = JSON.stringify(stTextureKey[0]).slice(1,JSON.stringify(stTextureKey[0]).length -1);
            if(strTextureKey === "backCard" && isDraggedItem) {
                if((countBtn === 0 && countTop === 1) || (countBtn === 1 && countTop === 2)
                    || (countBtn === 2 && countTop === 3) || (countBtn === 3 && countTop === 4)
                    || (countBtn === 4 && countTop === 5)
                ){
                    self.createTweens(self, gameObject.x, gameObject.y);
                    countBtn++;
                    isDraggedItem = false;
                }
                gameObject.input.enabled = false;
            }else if(strTextureKey !== "player1" || strTextureKey !== "player2" ||
                strTextureKey !== "player3" || strTextureKey !== "player4" || strTextureKey !== "player5" ){
                console.log("holdTopImgCards is " + holdTopImgs);
                let nameTopImg = null;
                    if (strTextureKey === holdTopImgs[0]) {
                        console.log("inTop0");
                        isTopSelected = true;
                        countTop++;
                        hasItemsSearch(nameTopImg, 'top');
                        isTopSelected = false;
                    } else if (strTextureKey === holdTopImgs[1]) {
                        console.log("inTop1");
                        isTopSelected2 = true;
                        countTop++;
                        hasItemsSearch(nameTopImg, 'top');
                        isTopSelected2 = false;
                    } else if (strTextureKey === holdTopImgs[2]) {
                        console.log("inTop2");
                        isTopSelected3 = true;
                        countTop++;
                        hasItemsSearch(nameTopImg, 'top');
                        isTopSelected3 = false;
                    } else if (strTextureKey === holdTopImgs[3]) {
                        console.log("inTop3");
                        isTopSelected4 = true;
                        countTop++;
                        hasItemsSearch(nameTopImg, 'top');
                        isTopSelected4 = false;
                    } else if (strTextureKey === holdTopImgs[4]) {
                        console.log("inTop4");
                        isTopSelected5 = true;
                        countTop++;
                        hasItemsSearch(nameTopImg, 'top');
                        isTopSelected5 = false;
                    }
                }
            })
        this.input.on('dragend',function(pointer,gameObject,dropped){
            if(!dropped){
                gameObject.x = gameObject.input.dragStartX;
                gameObject.y = gameObject.input.dragStartY;
            }
            graphics.clear();
            graphics.lineStyle(2, 0xffff00, 1);
            graphics.strokeRect(zone.x - zone.input.hitArea.width / 2, zone.y - zone.input.hitArea.height / 2, zone.input.hitArea.width, zone.input.hitArea.height);
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
            holdTopImgs.push(result);
            playerCard.render(320 + (i * 100), 300, result);
        }
    }
    function hasItemsSearch(nameImg, sectionPrt){
        if(sectionPrt === 'top') {
            if (isTopSelected && !isTopSelected5 && !isTopSelected3 && !isTopSelected2 && !isTopSelected4) {
                nameImg = holdTopImgs[0];
                //countTop++;
                newNameArray[0].topImg = nameImg;
            }else if (!isTopSelected && isTopSelected2) {
                nameImg = holdTopImgs[1];
                //countTop++;
                newNameArray[1].topImg = nameImg;
            }else if (isTopSelected3 && !isTopSelected && !isTopSelected2) {
                nameImg = holdTopImgs[2];
                //countTop++;
                newNameArray[2].topImg = nameImg;
            }else if (isTopSelected4 && !isTopSelected3 && !isTopSelected && !isTopSelected2) {
                nameImg = holdTopImgs[3];
                //countTop++;
                newNameArray[3].topImg = nameImg;
            }else if (isTopSelected5 && !isTopSelected4 && !isTopSelected3 && !isTopSelected && !isTopSelected2) {
                nameImg = holdTopImgs[4];
                //countTop++;
                newNameArray[4].topImg = nameImg;
            }
            console.log("newArrayItems is " + JSON.stringify(newNameArray));
            return newNameArray;
        }else if (sectionPrt === 'btn'){
            if (isSelected && !isSelected5 && !isSelected3 && !isSelected2 && !isSelected4) {
                nameImg = copyFourItems[0];
                newNameArray[0].btnImg = nameImg;
            } else if (!isSelected && isSelected2 ) {
                nameImg = copyFourItems[1];
                newNameArray[1].btnImg = nameImg;
            }else if (isSelected3 && !isSelected && !isSelected2) {
                nameImg = copyFourItems[2];
                newNameArray[2].btnImg = nameImg;
            }else if (isSelected4 && !isSelected3 && !isSelected2 && !isSelected) {
                console.log("isSelectedfourClicked");
                nameImg = copyFourItems[3];
                newNameArray[3].btnImg = nameImg;
            }else if (isSelected5 && !isSelected2 && !isSelected && !isSelected3 && !isSelected4) {
                console.log("isSelectedFiveClicked");
                nameImg = copyFourItems[4];
                newNameArray[4].btnImg = nameImg;
            }
            console.log("newArrayItems is " + JSON.stringify(newNameArray));
            return newNameArray;
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
        copyFourItems = [].concat(fourItems);
        return copyFourItems.sort(() => 0.5 - Math.random());
    }
    function displayBackCards(gy){
        bcCardScale = "bcCardScale";
        let pd3 = new Card(gy);
        for(let i =0; i < 5; i++){
            pd3.render(320 + (i * 100), 1100, 'backCard');
        }
        return bcCardScale;
    }
    function handPlayers(hd){
        handScale = "handScale";
        let pd4 = new Card(hd);
            pd4.render(320, 70, 'player1');
            pd4.render(320 + (350), 70, 'player2');
            pd4.render(320, 1350, 'player3');
            pd4.render(320 + 350, 1350, 'player4');
        return handScale;
    }
/*   function update (){
       let pd5 = new Card(this);
       //pd5.render(320, 1350, 'player');
    }*/
/*    function render() {
    }*/
</script>
</body>
</html>
