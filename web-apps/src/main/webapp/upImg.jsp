
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
            //update: update,
            //render: render
        }
    };
    let game = new Phaser.Game(config) ;
    let holdImgCards = [];
    let newNameArray = [];
    newNameArray.push({
        topImg : 'top',
        btnImg : 'btn'
    });
    let newNameObj = Object.assign({topImg: null, btnImg: null});
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
    //holdTopImgs
    let holdTopImgs = [];
    let holdTween = null;
    let cardInex = 0;
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
        this.load.image('backCard', 'images/cards/back.jpg');
    }
    class Card {
        constructor(scene) {
            this.card = null;
            this.render = (x, y, sprite) => {
                this.card = scene.add.image(x, y, sprite)
                    .setScale(0.3, 0.3).setInteractive();
                scene.input.setDraggable(this.card);
                return this.card;
            }
            return this.card;
        }
    }

    function create () {  //floor = this.add.rectangle(520, 700, 700, 450, 0x6666ff);
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
                lowChanceWin(this);
                displayBackCards(this);
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
                    if (!isSelected) {
                        console.log("array of images " + copyFourItems);
                        console.log("firstIsSelected " + isSelected );
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[0]).setScale(0.3, 0.3);
                        isSelected = true;
                        findCardsName();
                    } else if(isSelected && !isSelected2 && !isSelected3 && !isSelected4 && !isSelected5){
                        console.log("secondIsSelected " + isSelected );
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[1]).setScale(0.3, 0.3);
                        isSelected2 = true;
                        findCardsName();
                    } else if (isSelected2 && isSelected && !isSelected3 && !isSelected4 && !isSelected5) {
                        console.log("thirdIsSelected " + isSelected + isSelected2 );
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[2]).setScale(0.3, 0.3);
                        isSelected3 = true;
                        findCardsName();
                    } else if (isSelected2 && isSelected && isSelected3 && !isSelected4 && !isSelected5) {
                        console.log("fouthIsSelected " + isSelected + isSelected2 + isSelected3 );
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[3]).setScale(0.3, 0.3);
                        isSelected4 = true;
                        findCardsName();
                    } else if (isSelected2 && isSelected && isSelected3 && isSelected4 && !isSelected5 ) {
                        console.log("fifthIsSelected " + isSelected + isSelected2 + isSelected4 + isSelected3);
                        ev.add.image(parseInt(scX), parseInt(scY), copyFourItems[4]).setScale(0.3, 0.3);
                        isSelected5 = true;
                        findCardsName();
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
            gameObject.x = dragX;
            gameObject.y = dragY;
            let addTextureKey = [];
            addTextureKey.push(gameObject);
            let stTextureKey = addTextureKey.map(ef => ef.texture.key);
            let strTextureKey = JSON.stringify(stTextureKey[0]).slice(1,JSON.stringify(stTextureKey[0]).length -1);
            if(strTextureKey === "backCard" && !isDraggedItem) {
                highChanceWin(self);
                isDraggedItem = true;
            }
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
            if(strTextureKey === "backCard") {
                self.createTweens(self, gameObject.x, gameObject.y);
                gameObject.input.enabled = false;
            }else {
                console.log("holdTopImgCards is " + holdTopImgs);
                if(strTextureKey === holdTopImgs[0]){
                            isTopSelected = true;
                            findCardsName();
                        }else if(strTextureKey === holdTopImgs[1]){
                            isTopSelected2 = true;
                            findCardsName();
                        }else if(strTextureKey === holdTopImgs[2]){
                            isTopSelected3 = true;
                            findCardsName();
                        }else if (strTextureKey === holdTopImgs[3]){
                            isTopSelected4 = true;
                            findCardsName();
                        }else if(strTextureKey === holdTopImgs[4]){
                            isTopSelected5 = true;
                            findCardsName();
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
        //push images into a new array
            holdTopImgs.push(result);
            playerCard.render(320 + (i * 100), 300, result);
        }
    }
    function findCardsName(){
        console.log("findCardName is called ");
        let nameTopImg = null;
        let nameBtnImg = null;

        if(isTopSelected){
            console.log("inside the isTopSelecte");
            hasItemsSearch(nameTopImg, 'top');
            isTopSelected = false;
        }
        if(isTopSelected2){
            console.log("inside the isTopSelected2");
            hasItemsSearch(nameTopImg, 'top');
            isTopSelected2 = false;
        }
        if(isTopSelected3){
            console.log("inside the isTopSelected3");
            hasItemsSearch(nameTopImg, 'top');
            isTopSelected3 = false;
        }
        if(isTopSelected4){
            console.log("inside the isTopSelected4");
            hasItemsSearch(nameTopImg ,'top');
            isTopSelected4 = false;
        }
        if(isTopSelected5){
            console.log("inside the isTopSelected5");
            hasItemsSearch(nameTopImg, 'top');
            isTopSelected5 = false;
        }
        //back cards names
        if(isSelected){
            console.log("inside the isSelected");
            hasItemsSearch(nameBtnImg, 'btn');
            isSelected = false;
        }
        if(isSelected2){
            console.log("inside the isSelected2");
            hasItemsSearch(nameTopImg, 'btn');
            isSelected2 = false;
        }
        if(isSelected3){
            console.log("inside the isSelected3");
            hasItemsSearch(nameBtnImg, 'btn');
            isSelected3 = false;
        }
        if(isSelected4){
            console.log("inside the isSelected4");
            hasItemsSearch(nameBtnImg, 'btn');
            isSelected4 = false;
        }
        if(isSelected5){
            console.log("inside the isSelected5");
            hasItemsSearch(nameBtnImg, 'btn');
            isSelected5 = false;
        }
        if(newNameArray !== null){
            newNameArray.forEach(el => console.log("newNameArrayOne" + el.topImg + " " + el.btnImg))
        }
    }
    function hasItemsSearch(nameImg, sectionPrt){
        let hasItem = false;
        let hasItem2 = false;
        let hasItem3 = false;
        nameImg = holdTopImgs[0];
        console.log(holdTopImgs[0]);
        if(sectionPrt === 'top') {
            if (newNameArray[0].topImg === sectionPrt) {
                newNameArray[0].topImg = nameImg;
            } else if (newNameArray[0].topImg !== sectionPrt && !hasItem && !hasItem2 && !hasItem3) {
                newNameArray[1].topImg = nameImg;
                hasItem = true;
            }
            if (hasItem) {
                newNameArray[2].topImg = nameImg;
                hasItem2 = true;
                hasItem = false;
            }
            if (hasItem2 && !hasItem) {
                newNameArray[3].topImg = nameImg;
                hasItem2 = false;
                hasItem3 = true;
            }
            if (!hasItem2 && !hasItem && hasItem3) {
                newNameArray[4].topImg = nameImg;
            }
            console.log("newArrayItems is " + JSON.stringify(newNameArray));
            return newNameArray;
        }else if (sectionPrt === 'btn'){
            if (newNameArray[0].btnImg === sectionPrt) {
                newNameArray[0].btnImg = nameImg;
            } else if (newNameArray[0].btnImg !== sectionPrt && !hasItem && !hasItem2 && !hasItem3) {
                newNameArray[1].btnImg = nameImg;
                hasItem = true;
            }
            if (hasItem) {
                newNameArray[2].btnImg = nameImg;
                hasItem2 = true;
                hasItem = false;
            }
            if (hasItem2 && !hasItem) {
                newNameArray[3].btnImg = nameImg;
                hasItem2 = false;
                hasItem3 = true;
            }
            if (!hasItem2 && !hasItem && hasItem3) {
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
        let pd3 = new Card(gy);
        for(let i =0; i < 5; i++){
            cardInex = i;
            pd3.render(320 + (i * 100), 1200, 'backCard');
        }
    }
/*    function update (){
    }
    function render() {
    }*/
</script>
</body>
</html>
