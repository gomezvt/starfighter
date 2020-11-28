//
//  GameScene.swift
//  Echo-9
//
//  Created by Greg on 8/15/18.
//  Copyright © 2018 Greg Gomez. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import StoreKit
import GoogleMobileAds

enum WeaponType: Int {
    case Gun
    case Fireball
    case Lightning
    case Spread
}

struct Textures {
    static let shelltexture = SKTexture(imageNamed: "weaponShell")
    static let guntexture = SKTexture(imageNamed: "w-machinegun")
    static let fireballtexture = SKTexture(imageNamed: "w-fireball")
    static let lightningtexture = SKTexture(imageNamed: "w-lightning")
    static let sentineltexture = SKTexture(imageNamed: "w-sentinel")
    static let spreadtexture = SKTexture(imageNamed: "w-spread")
    static let tomahawktexture = SKTexture(imageNamed: "w-tomahawk")
    static let megabombtexture = SKTexture(imageNamed: "w-megabomb")
    static let tomahawkbackwardstexture = SKTexture(imageNamed: "tomahawk-backwards")
    static let pausetexture = SKTexture(imageNamed: "pause")
    static let unpausetexture = SKTexture(imageNamed: "unpause")
    static let lifetexture = SKTexture(imageNamed: "life")
    static let asteroidtexture = SKTexture(imageNamed: "asteroid")
    static let asteroid2texture = SKTexture(imageNamed: "asteroid2")
    static let asteroid3texture = SKTexture(imageNamed: "asteroid3")
    static let asteroid4texture = SKTexture(imageNamed: "asteroid4")
}

struct CollisionBitMask {
    static let shipCategory:UInt32 = 0x1 << 0
    static let shipFireCategory:UInt32 = 0x1 << 1
    static let enemyCategory:UInt32 = 0x1 << 2
    static let enemyFireCategory:UInt32 = 0x1 << 3
    static let weaponCategory:UInt32 = 0x1 << 4
    static let bossCategory:UInt32 = 0x1 << 5
    static let bossFireCategory:UInt32 = 0x1 << 6
    static let lifeCategory:UInt32 = 0x1 << 7
    static let coinCategory:UInt32 = 0x1 << 8
    static let shieldCategory:UInt32 = 0x1 << 9
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var isShipUp: Bool = false
    var isShipDown: Bool = false
    
    var boss1Array = Array<SKTexture>()
    let boss1Atlas = SKTextureAtlas(named:"boss1")
    
    var boss3Array = Array<SKTexture>()
    let boss3Atlas = SKTextureAtlas(named:"boss3")
    
    var lightningUpSprites = Array<SKTexture>()
    let lightningUpAtlas = SKTextureAtlas(named:"lightningUp")
    
    var lightningDownSprites = Array<SKTexture>()
    let lightningDownAtlas = SKTextureAtlas(named:"lightningDown")
    
    var playerArray = Array<SKTexture>()
    let playerAtlas = SKTextureAtlas(named:"player")
    
    var playerUpArray = Array<SKTexture>()
    let playerUpAtlas = SKTextureAtlas(named:"playerup")
    
    var playerDownArray = Array<SKTexture>()
    let playerDownAtlas = SKTextureAtlas(named:"playerdown")
    
    var brainBossNormArray = Array<SKTexture>()
    let brainBossNormAtlas = SKTextureAtlas(named:"brainBossNorm")
    
    var brainBossAttackArray = Array<SKTexture>()
    let brainBossAttackAtlas = SKTextureAtlas(named:"brainBossAttack")
    
    var buzzBossNormArray = Array<SKTexture>()
    let buzzBossNormAtlas = SKTextureAtlas(named:"buzzBossNorm")
    
    var buzzBossAttackArray = Array<SKTexture>()
    let buzzBossAttackAtlas = SKTextureAtlas(named:"buzzBossAttack")
    
    var expArray = Array<SKTexture>()
    let expAtlas = SKTextureAtlas(named:"explode")
    
    var enemy1Array = Array<SKTexture>()
    let enemy1Atlas = SKTextureAtlas(named:"enemy1")
    
    var enemy2Array = Array<SKTexture>()
    let enemy2Atlas = SKTextureAtlas(named:"enemy2")
    
    var enemy3Array = Array<SKTexture>()
    let enemy3Atlas = SKTextureAtlas(named:"enemy3")
    
    var enemy4Array = Array<SKTexture>()
    let enemy4Atlas = SKTextureAtlas(named:"enemy4")
    
    var enemy5Array = Array<SKTexture>()
    let enemy5Atlas = SKTextureAtlas(named:"enemy5")
    
    var enemy6Array = Array<SKTexture>()
    let enemy6Atlas = SKTextureAtlas(named:"enemy6")
    
    var enemy7Array = Array<SKTexture>()
    let enemy7Atlas = SKTextureAtlas(named:"enemy7")
    
    var enemy8Array = Array<SKTexture>()
    let enemy8Atlas = SKTextureAtlas(named:"enemy8")
    
    var enemy9Array = Array<SKTexture>()
    let enemy9Atlas = SKTextureAtlas(named:"enemy9")
    
    var shipExhaustArray = Array<SKTexture>()
    let shipAtlas = SKTextureAtlas(named:"shipexhaust")
    
    var missileExhaustArray = Array<SKTexture>()
    let missileExhaustAtlas = SKTextureAtlas(named:"missileExhaust")
    
    var enemyExhaustArray = Array<SKTexture>()
    let enemyExhaustAtlas = SKTextureAtlas(named:"enemyExhaust")
    
    var enemyExhaust2Array = Array<SKTexture>()
    let enemyExhaust2Atlas = SKTextureAtlas(named:"enemyExhaust2")
    
    var enemyExhaust3Array = Array<SKTexture>()
    let enemyExhaust3Atlas = SKTextureAtlas(named:"enemyExhaust3")
    
    var enemyExhaust4Array = Array<SKTexture>()
    let enemyExhaust4Atlas = SKTextureAtlas(named:"enemyExhaust4")
    
    var enemyExhaust5Array = Array<SKTexture>()
    let enemyExhaust5Atlas = SKTextureAtlas(named:"enemyExhaust5")
    
    var enemyExhaust6Array = Array<SKTexture>()
    let enemyExhaust6Atlas = SKTextureAtlas(named:"enemyExhaust6")
    
    var previousTranslateX: CGFloat = 0.0
    var previousTranslateY: CGFloat = 0.0
    
    var blobSprites = Array<SKTexture>()
    let blobAtlas = SKTextureAtlas(named:"blob")
    
    var greenBulletSprites = Array<SKTexture>()
    let greenBulletAtlas = SKTextureAtlas(named:"greenBullet")
    
    var blueBulletSprites = Array<SKTexture>()
    let blueBulletAtlas = SKTextureAtlas(named:"blueBullet")
    
    var redBulletSprites = Array<SKTexture>()
    let redBulletAtlas = SKTextureAtlas(named:"redBullet")
    
    var starSprites = Array<SKTexture>()
    let starAtlas = SKTextureAtlas(named:"star")
    
    var fireballSprites = Array<SKTexture>()
    let fireballAtlas = SKTextureAtlas(named:"fireballwep")
    
    var coinArray = Array<SKTexture>()
    let coinAtlas = SKTextureAtlas(named:"coins")
    
    var enemyLightningUpSprites = Array<SKTexture>()
    let enemyLightningUpAtlas = SKTextureAtlas(named:"enemyLightningUp")
    
    var enemyLightningDownSprites = Array<SKTexture>()
    let enemyLightningDownAtlas = SKTextureAtlas(named:"enemyLightningDown")
    
    var enemyExhausts = [[SKTexture]]()
    var bgShipsArray = [[SKTexture]]()
    
    var megaBombCount = Int(0)
    var coins = Int(0)
    var sentinelDur = Int(0)
    var tomahawkDur = Int(0)
    var bossShot = Int(0)
    var lightningCount = Int(0)
    var shield = Int(0)
    var lives = Int(3)
    var score = Int(0)
    var level = Int(1)
    var minute = Int(1)
    var wepCount: Int = 1
    var seconds = Int(00)
    var bossLife = Int(100)
    
    var isAsteroidBoss: Bool = false
    var didBeatGame: Bool = false
    var gameStarted = Bool(false)
    var died = Bool(false)
    var playerHit: Bool = false
    var isAddingSentinelFire: Bool = false
    var weaponType: WeaponType = .Gun
    
    var bombCountLabel = SKLabelNode()
    var isRequestingReview: Bool = false
    var scoreLabel = SKLabelNode()
    var levelLabel = SKLabelNode()
    var hiScoreLabel = SKLabelNode()
    var hiLabel = SKLabelNode()
    var pausedLabel = SKLabelNode()
    var returnToMenuLabel = SKLabelNode()
    var congratsLabel = SKLabelNode()
    var congratsDetailsLabel = SKLabelNode()
    var staticLevelLabel = SKLabelNode()
    var staticScoreLabel = SKLabelNode()
    var staticHiScoreLabel = SKLabelNode()
    var unPauseLabel = SKLabelNode()
    var bossAlertLabel = SKLabelNode()
    var endGameReturnMenuLabel = SKLabelNode()
    var bossStaticLifeLabel = SKLabelNode()
    var bossLifeLabel = SKLabelNode()
    var livesXLabel = SKLabelNode()
    var lifeLabel = SKLabelNode()
    var sentinelLabel = SKLabelNode()
    var tomahawkLabel = SKLabelNode()
    var levelCompleteLabel = SKLabelNode()
    var timerLabel = SKLabelNode()

    var shieldLabel = SKLabelNode()
    var coinIcon: SKSpriteNode!
    var coinlabel = SKLabelNode()

    var playerShield: SKShapeNode?
    var megaBomb: SKSpriteNode!
    var shipExhaust: SKSpriteNode!
    var enemyExhaust: SKSpriteNode!
    var enemyExhaust2: SKSpriteNode!
    var bossStar: SKSpriteNode?
    
    var fireButton: SKSpriteNode!
    var bombButton: SKSpriteNode!
    var missileButton: SKSpriteNode!
    var headerView: SKSpriteNode!
    var pauseBtn: SKSpriteNode!
    var sentinel: SKSpriteNode?
    var pausedLabelBG: SKSpriteNode!
    var redBG: SKSpriteNode!
    var selectedWeapon: SKSpriteNode!
    var bar: SKSpriteNode!
    var sentinelIcon: SKSpriteNode!
    var tomahawkIcon: SKSpriteNode!
    var shieldIcon: SKSpriteNode!
    var shipIcon: SKSpriteNode!
    var shipIconExhaust: SKSpriteNode!
    var grayBar: SKSpriteNode!
    var boss: SKSpriteNode?
    var bg: SKSpriteNode!
    var ship: SKSpriteNode!
    var weaponSprites = [SKSpriteNode]()
    var asteroidSprites = [SKSpriteNode]()
    var fadeOut = SKAction()
    var fadeIn = SKAction()
    var shipPan = UIPanGestureRecognizer()
    
    var bannerView: GADBannerView!

    @objc func adWasPresented(_ notification: Notification) {
        if let app = UIApplication.shared.delegate as? AppDelegate,
            let gameMusicPlayer = app.musicPlayer {
            gameMusicPlayer.setVolume(0.3, fadeDuration: 3)
        }

    }
    
    @objc func adWasDismissed(_ notification: Notification) {
        if let menuScene = GKScene(fileNamed: "MenuScene"),
            let _ = menuScene.rootNode as? MenuScene,
            lives <= 0, isRequestingReview == false, level > 1 {
            isRequestingReview = true
            SKStoreReviewController.requestReview()
        }
    }
    
    @objc func appMovedToBackground(_ notification: Notification) {
        pauseGame()
    }
    
    override func didMove(to view: SKView) {
        scene?.scaleMode = SKSceneScaleMode.aspectFit
        
        if let v = self.view,
           let window = v.window,
           let root = window.rootViewController,
           root.isKind(of: GameViewController.self),
           let gameVC = root as? GameViewController {
            bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)
            gameVC.initializeBanner(banner:bannerView)
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            v.addSubview(bannerView)
            
            v.addConstraints(
                [NSLayoutConstraint(item: bannerView as GADBannerView,
                                    attribute: .top,
                                    relatedBy: .equal,
                                    toItem: v,
                                    attribute: .top,
                                    multiplier: 1,
                                    constant: 0),
                 NSLayoutConstraint(item: bannerView as GADBannerView,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: v,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
                ])
        }
        
        if let app = UIApplication.shared.delegate as? AppDelegate,
            let gameMusicPlayer = app.musicPlayer {
            gameMusicPlayer.setVolume(0, fadeDuration: 3)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adWasPresented), name: NSNotification.Name(rawValue: "adWasPresented"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adWasDismissed), name: NSNotification.Name(rawValue: "adWasDismissed"), object: nil)
        
        bombButton = self.childNode(withName: "//bombButton") as? SKSpriteNode
        missileButton = self.childNode(withName: "//missileButton") as? SKSpriteNode
        fireButton = self.childNode(withName: "//fireButton") as? SKSpriteNode
        bombCountLabel = self.childNode(withName: "//bombLabel") as! SKLabelNode
        megaBomb = self.childNode(withName: "//bomb") as? SKSpriteNode
        shipIcon = self.childNode(withName: "//shipIcon") as? SKSpriteNode
        shipIconExhaust = self.childNode(withName: "//shipIconExhaust") as? SKSpriteNode
        bossStaticLifeLabel = self.childNode(withName: "//bossStaticLifeLabel") as! SKLabelNode
        bossLifeLabel = self.childNode(withName: "//bossLifeLabel") as! SKLabelNode
        bossStaticLifeLabel.isHidden = true
        bossLifeLabel.isHidden = true
        redBG = self.childNode(withName: "//redBG") as? SKSpriteNode
        sentinelLabel = self.childNode(withName: "//sentinelLabel") as! SKLabelNode
        tomahawkLabel = self.childNode(withName: "//tomahawkLabel") as! SKLabelNode
        pausedLabel = self.childNode(withName: "//pausedLabel") as! SKLabelNode
        pausedLabelBG = self.childNode(withName: "//pausedLabelBG") as? SKSpriteNode
        returnToMenuLabel = self.childNode(withName: "//returnToMenuLabel") as! SKLabelNode
        bg = self.childNode(withName: "//bg") as? SKSpriteNode
        hiScoreLabel = self.childNode(withName: "//hiScoreLabel") as! SKLabelNode
        timerLabel = self.childNode(withName: "//timerLabel") as! SKLabelNode
        hiLabel = self.childNode(withName: "//hiLabel") as! SKLabelNode
        bar = self.childNode(withName: "//bar") as? SKSpriteNode
        headerView = self.childNode(withName: "//headerView") as? SKSpriteNode
        lifeLabel = self.childNode(withName: "//lifeLabel") as! SKLabelNode
        shieldLabel = self.childNode(withName: "//shieldLabel") as! SKLabelNode
        levelLabel = self.childNode(withName: "//levelLabel") as! SKLabelNode
        scoreLabel = self.childNode(withName: "//scoreLabel") as! SKLabelNode
        bossAlertLabel = self.childNode(withName: "//bossAlertLabel") as! SKLabelNode
        sentinelIcon = self.childNode(withName: "//sentinelIcon") as? SKSpriteNode
        tomahawkIcon = self.childNode(withName: "//tomahawkIcon") as? SKSpriteNode
        shieldIcon = self.childNode(withName: "//shieldIcon") as? SKSpriteNode
        livesXLabel = self.childNode(withName: "//livesXLabel") as! SKLabelNode
        grayBar = self.childNode(withName: "//grayBar") as? SKSpriteNode
        congratsLabel = self.childNode(withName: "//congratsLabel") as! SKLabelNode
        congratsDetailsLabel = self.childNode(withName: "//congratsDetailsLabel") as! SKLabelNode
        endGameReturnMenuLabel = self.childNode(withName: "//endGameReturnMenuLabel") as! SKLabelNode
        staticLevelLabel = self.childNode(withName: "//staticLevelLabel") as! SKLabelNode
        staticScoreLabel = self.childNode(withName: "//staticScoreLabel") as! SKLabelNode
        unPauseLabel = self.childNode(withName: "//unPauseLabel") as! SKLabelNode
        pauseBtn = self.childNode(withName: "//pauseBtn") as? SKSpriteNode
        selectedWeapon = self.childNode(withName: "//weapon") as? SKSpriteNode
        coinIcon = self.childNode(withName: "//coinIcon") as? SKSpriteNode
        coinlabel = self.childNode(withName: "//coinlabel") as! SKLabelNode
        levelCompleteLabel = self.childNode(withName: "//levelCompleteLabel") as! SKLabelNode

        asteroidSprites.append(SKSpriteNode(texture: Textures.asteroidtexture))
        asteroidSprites.append(SKSpriteNode(texture: Textures.asteroid2texture))
        asteroidSprites.append(SKSpriteNode(texture: Textures.asteroid3texture))
        asteroidSprites.append(SKSpriteNode(texture: Textures.asteroid4texture))
        
        weaponSprites.append(SKSpriteNode(texture: Textures.guntexture))
        weaponSprites.append(SKSpriteNode(texture: Textures.fireballtexture))
        weaponSprites.append(SKSpriteNode(texture: Textures.lightningtexture))
        weaponSprites.append(SKSpriteNode(texture: Textures.sentineltexture))
        weaponSprites.append(SKSpriteNode(texture: Textures.spreadtexture))
        weaponSprites.append(SKSpriteNode(texture: Textures.tomahawktexture))
        weaponSprites.append(SKSpriteNode(texture: Textures.megabombtexture))
        
        playerArray.append(playerAtlas.textureNamed("player"))
        playerUpArray.append(playerUpAtlas.textureNamed("playerup"))
        playerUpArray.append(playerUpAtlas.textureNamed("playerup2"))
        playerUpArray.append(playerUpAtlas.textureNamed("playerup3"))
        playerUpArray.append(playerUpAtlas.textureNamed("playerup4"))
        
        playerDownArray.append(playerDownAtlas.textureNamed("playerdown"))
        playerDownArray.append(playerDownAtlas.textureNamed("playerdown2"))
        playerDownArray.append(playerDownAtlas.textureNamed("playerdown3"))
        playerDownArray.append(playerDownAtlas.textureNamed("playerdown4"))
        
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("1"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("2"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("3"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("4"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("5"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("6"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("7"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("8"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("9"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("10"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("11"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("12"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("13"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("14"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("15"))
        buzzBossNormArray.append(buzzBossNormAtlas.textureNamed("16"))
        
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("1"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("2"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("3"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("4"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("5"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("6"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("7"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("8"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("9"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("10"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("11"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("12"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("13"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("14"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("15"))
        buzzBossAttackArray.append(buzzBossAttackAtlas.textureNamed("16"))
        
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("1"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("2"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("3"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("4"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("5"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("6"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("7"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("8"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("9"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("10"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("11"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("12"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("13"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("14"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("15"))
        brainBossNormArray.append(brainBossNormAtlas.textureNamed("16"))
        
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("1"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("2"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("3"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("4"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("5"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("6"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("7"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("8"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("9"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("10"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("11"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("12"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("13"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("14"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("15"))
        brainBossAttackArray.append(brainBossAttackAtlas.textureNamed("16"))
        
        expArray.append(expAtlas.textureNamed("explosion"))
        expArray.append(expAtlas.textureNamed("explosion2"))
        expArray.append(expAtlas.textureNamed("explosion3"))
        expArray.append(expAtlas.textureNamed("explosion4"))
        expArray.append(expAtlas.textureNamed("explosion5"))
        expArray.append(expAtlas.textureNamed("explosion6"))
        expArray.append(expAtlas.textureNamed("explosion7"))
        expArray.append(expAtlas.textureNamed("explosion8"))
        expArray.append(expAtlas.textureNamed("explosion9"))
        expArray.append(expAtlas.textureNamed("explosion10"))
        expArray.append(expAtlas.textureNamed("explosion11"))
        
        enemy1Array.append(enemy1Atlas.textureNamed("enemy"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy2"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy3"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy4"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy5"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy6"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy7"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy8"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy9"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy10"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy11"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy12"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy13"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy14"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy15"))
        enemy1Array.append(enemy1Atlas.textureNamed("enemy16"))
        
        enemy2Array.append(enemy2Atlas.textureNamed("enemy"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy2"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy3"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy4"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy5"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy6"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy7"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy8"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy9"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy10"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy11"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy12"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy13"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy14"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy15"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy16"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy17"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy18"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy19"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy20"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy21"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy22"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy23"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy24"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy25"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy26"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy27"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy28"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy29"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy30"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy31"))
        enemy2Array.append(enemy2Atlas.textureNamed("enemy32"))
        
        enemy3Array.append(enemy3Atlas.textureNamed("enemy"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy2"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy3"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy4"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy5"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy6"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy7"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy8"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy9"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy10"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy11"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy12"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy13"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy14"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy15"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy16"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy17"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy18"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy19"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy20"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy21"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy22"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy23"))
        enemy3Array.append(enemy3Atlas.textureNamed("enemy24"))
        
        enemy4Array.append(enemy4Atlas.textureNamed("enemy"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy2"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy3"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy4"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy5"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy6"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy7"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy8"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy9"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy10"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy11"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy12"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy13"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy14"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy15"))
        enemy4Array.append(enemy4Atlas.textureNamed("enemy16"))
        
        enemy5Array.append(enemy5Atlas.textureNamed("enemy"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy2"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy3"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy4"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy5"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy6"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy7"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy8"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy9"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy10"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy11"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy12"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy13"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy14"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy15"))
        enemy5Array.append(enemy5Atlas.textureNamed("enemy16"))
        
        enemy6Array.append(enemy6Atlas.textureNamed("enemy"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy2"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy3"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy4"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy5"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy6"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy7"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy8"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy9"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy10"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy11"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy12"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy13"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy14"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy15"))
        enemy6Array.append(enemy6Atlas.textureNamed("enemy16"))
        
        enemy7Array.append(enemy7Atlas.textureNamed("enemy"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy2"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy3"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy4"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy5"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy6"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy7"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy8"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy9"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy10"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy11"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy12"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy13"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy14"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy15"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy16"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy17"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy18"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy19"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy20"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy21"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy22"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy23"))
        enemy7Array.append(enemy7Atlas.textureNamed("enemy24"))
        
        enemy8Array.append(enemy8Atlas.textureNamed("enemy"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy2"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy3"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy4"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy5"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy6"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy7"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy8"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy9"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy10"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy11"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy12"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy13"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy14"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy15"))
        enemy8Array.append(enemy8Atlas.textureNamed("enemy16"))
        
        enemy9Array.append(enemy9Atlas.textureNamed("enemy"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy2"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy3"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy4"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy5"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy6"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy7"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy8"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy9"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy10"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy11"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy12"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy13"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy14"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy15"))
        enemy9Array.append(enemy9Atlas.textureNamed("enemy16"))
        
        bgShipsArray.append(enemy1Array)
        bgShipsArray.append(enemy2Array)
        bgShipsArray.append(enemy3Array)
        bgShipsArray.append(enemy4Array)
        bgShipsArray.append(enemy5Array)
        bgShipsArray.append(enemy6Array)
        bgShipsArray.append(enemy7Array)
        bgShipsArray.append(enemy8Array)
        bgShipsArray.append(enemy9Array)
        
        blueBulletSprites.append(blueBulletAtlas.textureNamed("bullet_blue"))
        blueBulletSprites.append(blueBulletAtlas.textureNamed("bullet_blue2"))
        blueBulletSprites.append(blueBulletAtlas.textureNamed("bullet_blue3"))
        blueBulletSprites.append(blueBulletAtlas.textureNamed("bullet_blue4"))
        
        greenBulletSprites.append(greenBulletAtlas.textureNamed("greenbullet"))
        greenBulletSprites.append(greenBulletAtlas.textureNamed("greenbullet2"))
        greenBulletSprites.append(greenBulletAtlas.textureNamed("greenbullet3"))
        greenBulletSprites.append(greenBulletAtlas.textureNamed("greenbullet4"))
        
        redBulletSprites.append(redBulletAtlas.textureNamed("bulletred"))
        redBulletSprites.append(redBulletAtlas.textureNamed("bulletred2"))
        redBulletSprites.append(redBulletAtlas.textureNamed("bulletred3"))
        redBulletSprites.append(redBulletAtlas.textureNamed("bulletred4"))
        
        blobSprites.append(blobAtlas.textureNamed("blob"))
        blobSprites.append(blobAtlas.textureNamed("blob2"))
        blobSprites.append(blobAtlas.textureNamed("blob3"))
        blobSprites.append(blobAtlas.textureNamed("blob4"))
        blobSprites.append(blobAtlas.textureNamed("blob5"))
        blobSprites.append(blobAtlas.textureNamed("blob6"))
        blobSprites.append(blobAtlas.textureNamed("blob7"))
        blobSprites.append(blobAtlas.textureNamed("blob8"))
        blobSprites.append(blobAtlas.textureNamed("blob9"))
        blobSprites.append(blobAtlas.textureNamed("blob10"))
        blobSprites.append(blobAtlas.textureNamed("blob11"))
        blobSprites.append(blobAtlas.textureNamed("blob12"))
        blobSprites.append(blobAtlas.textureNamed("blob13"))
        blobSprites.append(blobAtlas.textureNamed("blob14"))
        blobSprites.append(blobAtlas.textureNamed("blob15"))
        blobSprites.append(blobAtlas.textureNamed("blob16"))
        blobSprites.append(blobAtlas.textureNamed("blob17"))
        blobSprites.append(blobAtlas.textureNamed("blob18"))
        blobSprites.append(blobAtlas.textureNamed("blob19"))
        blobSprites.append(blobAtlas.textureNamed("blob20"))
        blobSprites.append(blobAtlas.textureNamed("blob21"))
        blobSprites.append(blobAtlas.textureNamed("blob22"))
        blobSprites.append(blobAtlas.textureNamed("blob23"))
        blobSprites.append(blobAtlas.textureNamed("blob24"))
        blobSprites.append(blobAtlas.textureNamed("blob25"))
        blobSprites.append(blobAtlas.textureNamed("blob26"))
        blobSprites.append(blobAtlas.textureNamed("blob27"))
        blobSprites.append(blobAtlas.textureNamed("blob28"))
        blobSprites.append(blobAtlas.textureNamed("blob29"))
        blobSprites.append(blobAtlas.textureNamed("blob30"))
        blobSprites.append(blobAtlas.textureNamed("blob31"))
        blobSprites.append(blobAtlas.textureNamed("blob32"))
        
        boss1Array.append(boss1Atlas.textureNamed("boss0001"))
        boss1Array.append(boss1Atlas.textureNamed("boss0002"))
        boss1Array.append(boss1Atlas.textureNamed("boss0003"))
        boss1Array.append(boss1Atlas.textureNamed("boss0004"))
        boss1Array.append(boss1Atlas.textureNamed("boss0005"))
        boss1Array.append(boss1Atlas.textureNamed("boss0006"))
        boss1Array.append(boss1Atlas.textureNamed("boss0007"))
        boss1Array.append(boss1Atlas.textureNamed("boss0008"))
        boss1Array.append(boss1Atlas.textureNamed("boss0009"))
        boss1Array.append(boss1Atlas.textureNamed("boss0010"))
        boss1Array.append(boss1Atlas.textureNamed("boss0011"))
        boss1Array.append(boss1Atlas.textureNamed("boss0012"))
        boss1Array.append(boss1Atlas.textureNamed("boss0013"))
        boss1Array.append(boss1Atlas.textureNamed("boss0014"))
        boss1Array.append(boss1Atlas.textureNamed("boss0015"))
        boss1Array.append(boss1Atlas.textureNamed("boss0016"))
        boss1Array.append(boss1Atlas.textureNamed("boss0017"))
        boss1Array.append(boss1Atlas.textureNamed("boss0018"))
        boss1Array.append(boss1Atlas.textureNamed("boss0019"))
        boss1Array.append(boss1Atlas.textureNamed("boss0020"))
        boss1Array.append(boss1Atlas.textureNamed("boss0021"))
        boss1Array.append(boss1Atlas.textureNamed("boss0022"))
        boss1Array.append(boss1Atlas.textureNamed("boss0023"))
        boss1Array.append(boss1Atlas.textureNamed("boss0024"))
        boss1Array.append(boss1Atlas.textureNamed("boss0025"))
        boss1Array.append(boss1Atlas.textureNamed("boss0026"))
        boss1Array.append(boss1Atlas.textureNamed("boss0027"))
        boss1Array.append(boss1Atlas.textureNamed("boss0028"))
        boss1Array.append(boss1Atlas.textureNamed("boss0029"))
        boss1Array.append(boss1Atlas.textureNamed("boss0030"))
        boss1Array.append(boss1Atlas.textureNamed("boss0031"))
        boss1Array.append(boss1Atlas.textureNamed("boss0032"))
        boss1Array.append(boss1Atlas.textureNamed("boss0033"))
        boss1Array.append(boss1Atlas.textureNamed("boss0034"))
        boss1Array.append(boss1Atlas.textureNamed("boss0035"))
        boss1Array.append(boss1Atlas.textureNamed("boss0036"))
        boss1Array.append(boss1Atlas.textureNamed("boss0037"))
        boss1Array.append(boss1Atlas.textureNamed("boss0038"))
        boss1Array.append(boss1Atlas.textureNamed("boss0039"))
        boss1Array.append(boss1Atlas.textureNamed("boss0040"))
        boss1Array.append(boss1Atlas.textureNamed("boss0041"))
        boss1Array.append(boss1Atlas.textureNamed("boss0042"))
        boss1Array.append(boss1Atlas.textureNamed("boss0043"))
        boss1Array.append(boss1Atlas.textureNamed("boss0044"))
        boss1Array.append(boss1Atlas.textureNamed("boss0045"))
        boss1Array.append(boss1Atlas.textureNamed("boss0046"))
        boss1Array.append(boss1Atlas.textureNamed("boss0047"))
        
        boss3Array.append(boss3Atlas.textureNamed("boss"))
        boss3Array.append(boss3Atlas.textureNamed("boss2"))
        boss3Array.append(boss3Atlas.textureNamed("boss3"))
        boss3Array.append(boss3Atlas.textureNamed("boss4"))
        boss3Array.append(boss3Atlas.textureNamed("boss5"))
        boss3Array.append(boss3Atlas.textureNamed("boss6"))
        boss3Array.append(boss3Atlas.textureNamed("boss7"))
        boss3Array.append(boss3Atlas.textureNamed("boss8"))
        boss3Array.append(boss3Atlas.textureNamed("boss9"))
        boss3Array.append(boss3Atlas.textureNamed("boss10"))
        boss3Array.append(boss3Atlas.textureNamed("boss11"))
        boss3Array.append(boss3Atlas.textureNamed("boss12"))
        boss3Array.append(boss3Atlas.textureNamed("boss13"))
        boss3Array.append(boss3Atlas.textureNamed("boss14"))
        boss3Array.append(boss3Atlas.textureNamed("boss15"))
        boss3Array.append(boss3Atlas.textureNamed("boss16"))
        
        starSprites.append(starAtlas.textureNamed("star"))
        starSprites.append(starAtlas.textureNamed("star2"))
        starSprites.append(starAtlas.textureNamed("star3"))
        starSprites.append(starAtlas.textureNamed("star4"))
        starSprites.append(starAtlas.textureNamed("star5"))
        starSprites.append(starAtlas.textureNamed("star6"))
        starSprites.append(starAtlas.textureNamed("star7"))
        starSprites.append(starAtlas.textureNamed("star8"))
        starSprites.append(starAtlas.textureNamed("star9"))
        starSprites.append(starAtlas.textureNamed("star10"))
        starSprites.append(starAtlas.textureNamed("star11"))
        starSprites.append(starAtlas.textureNamed("star12"))
        starSprites.append(starAtlas.textureNamed("star13"))
        starSprites.append(starAtlas.textureNamed("star14"))
        starSprites.append(starAtlas.textureNamed("star15"))
        starSprites.append(starAtlas.textureNamed("star16"))
        
        shipExhaustArray.append(shipAtlas.textureNamed("shipexhaust"))
        shipExhaustArray.append(shipAtlas.textureNamed("shipexhaust2"))
        shipExhaustArray.append(shipAtlas.textureNamed("shipexhaust3"))
        shipExhaustArray.append(shipAtlas.textureNamed("shipexhaust4"))
        
        enemyExhaustArray.append(enemyExhaustAtlas.textureNamed("redthrust"))
        enemyExhaustArray.append(enemyExhaustAtlas.textureNamed("redthrust2"))
        enemyExhaustArray.append(enemyExhaustAtlas.textureNamed("redthrust3"))
        enemyExhaustArray.append(enemyExhaustAtlas.textureNamed("redthrust4"))
        
        missileExhaustArray.append(missileExhaustAtlas.textureNamed("redthrust"))
        missileExhaustArray.append(missileExhaustAtlas.textureNamed("redthrust2"))
        missileExhaustArray.append(missileExhaustAtlas.textureNamed("redthrust3"))
        missileExhaustArray.append(missileExhaustAtlas.textureNamed("redthrust4"))
        
        enemyExhaust2Array.append(enemyExhaust2Atlas.textureNamed("thrust_green"))
        enemyExhaust2Array.append(enemyExhaust2Atlas.textureNamed("thrust_green2"))
        enemyExhaust2Array.append(enemyExhaust2Atlas.textureNamed("thrust_green3"))
        enemyExhaust2Array.append(enemyExhaust2Atlas.textureNamed("thrust_green4"))
        
        enemyExhaust3Array.append(enemyExhaust3Atlas.textureNamed("thrust_pink"))
        enemyExhaust3Array.append(enemyExhaust3Atlas.textureNamed("thrust_pink2"))
        enemyExhaust3Array.append(enemyExhaust3Atlas.textureNamed("thrust_pink3"))
        enemyExhaust3Array.append(enemyExhaust3Atlas.textureNamed("thrust_pink4"))
        
        enemyExhaust4Array.append(enemyExhaust4Atlas.textureNamed("thrust_slicer"))
        enemyExhaust4Array.append(enemyExhaust4Atlas.textureNamed("thrust_slicer2"))
        enemyExhaust4Array.append(enemyExhaust4Atlas.textureNamed("thrust_slicer3"))
        enemyExhaust4Array.append(enemyExhaust4Atlas.textureNamed("thrust_slicer4"))
        
        enemyExhaust5Array.append(enemyExhaust5Atlas.textureNamed("thrust_sphere"))
        enemyExhaust5Array.append(enemyExhaust5Atlas.textureNamed("thrust_sphere2"))
        enemyExhaust5Array.append(enemyExhaust5Atlas.textureNamed("thrust_sphere3"))
        enemyExhaust5Array.append(enemyExhaust5Atlas.textureNamed("thrust_sphere4"))
        
        enemyExhaust6Array.append(enemyExhaust6Atlas.textureNamed("thrust_gunner"))
        enemyExhaust6Array.append(enemyExhaust6Atlas.textureNamed("thrust_gunner2"))
        enemyExhaust6Array.append(enemyExhaust6Atlas.textureNamed("thrust_gunner3"))
        enemyExhaust6Array.append(enemyExhaust6Atlas.textureNamed("thrust_gunner4"))
        
        enemyExhausts.append(enemyExhaustArray)
        enemyExhausts.append(enemyExhaust2Array)
        enemyExhausts.append(enemyExhaust3Array)
        enemyExhausts.append(enemyExhaust4Array)
        enemyExhausts.append(enemyExhaust5Array)
        enemyExhausts.append(enemyExhaust6Array)
        
        fireballSprites.append(fireballAtlas.textureNamed("fireball1"))
        fireballSprites.append(fireballAtlas.textureNamed("fireball2"))
        fireballSprites.append(fireballAtlas.textureNamed("fireball3"))
        
        coinArray.append(coinAtlas.textureNamed("1"))
        coinArray.append(coinAtlas.textureNamed("2"))
        coinArray.append(coinAtlas.textureNamed("3"))
        coinArray.append(coinAtlas.textureNamed("4"))
        coinArray.append(coinAtlas.textureNamed("5"))
        coinArray.append(coinAtlas.textureNamed("6"))
        coinArray.append(coinAtlas.textureNamed("7"))
        coinArray.append(coinAtlas.textureNamed("8"))
        coinArray.append(coinAtlas.textureNamed("9"))
        coinArray.append(coinAtlas.textureNamed("10"))
        coinArray.append(coinAtlas.textureNamed("11"))
        coinArray.append(coinAtlas.textureNamed("12"))
        coinArray.append(coinAtlas.textureNamed("13"))
        coinArray.append(coinAtlas.textureNamed("14"))
        coinArray.append(coinAtlas.textureNamed("15"))
        coinArray.append(coinAtlas.textureNamed("16"))
        coinArray.append(coinAtlas.textureNamed("17"))
        coinArray.append(coinAtlas.textureNamed("18"))
        
        
        lightningUpSprites.append(lightningUpAtlas.textureNamed("lightningUp1"))
        lightningUpSprites.append(lightningUpAtlas.textureNamed("lightningUp2"))
        lightningUpSprites.append(lightningUpAtlas.textureNamed("lightningUp3"))
        
        lightningDownSprites.append(lightningDownAtlas.textureNamed("lightningDown1"))
        lightningDownSprites.append(lightningDownAtlas.textureNamed("lightningDown2"))
        lightningDownSprites.append(lightningDownAtlas.textureNamed("lightningDown3"))
        
        enemyLightningUpSprites.append(enemyLightningUpAtlas.textureNamed("enemyLightningUp1"))
        enemyLightningUpSprites.append(enemyLightningUpAtlas.textureNamed("enemyLightningUp2"))
        enemyLightningUpSprites.append(enemyLightningUpAtlas.textureNamed("enemyLightningUp3"))
        
        enemyLightningDownSprites.append(enemyLightningDownAtlas.textureNamed("enemyLightningDown1"))
        enemyLightningDownSprites.append(enemyLightningDownAtlas.textureNamed("enemyLightningDown2"))
        enemyLightningDownSprites.append(enemyLightningDownAtlas.textureNamed("enemyLightningDown3"))
        
        fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
        fadeIn = SKAction.fadeAlpha(to: 1.0 , duration: 0.5)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsWorld.contactDelegate = self
        
        UserDefaults.standard.setValue(true, forKey: "willContinue")

        createShip()
        
        weaponType = .Gun

        if let tomahawkDur = UserDefaults.standard.object(forKey: "tomahawkDur") as? Int,
           tomahawkDur > 0, let _ = self.missileButton {
            self.tomahawkDur = tomahawkDur
            tomahawkLabel.text = "\(tomahawkDur)"
            let fIn = SKAction.fadeAlpha(to: 0.8, duration: 0.5)
            self.missileButton.run(fIn)
        }
        
        if let sentinelDur = UserDefaults.standard.object(forKey: "sentinelDur") as? Int,
           sentinelDur > 0 {
            self.sentinelDur = sentinelDur
            sentinelLabel.text = "\(sentinelDur)"
            applySentinel()
        }
        
        if let bombs = UserDefaults.standard.object(forKey: "bombs") as? Int,
           bombs > 0, let _ = self.bombButton {
            megaBombCount = bombs
            bombCountLabel.text = "\(megaBombCount)"
            let fIn = SKAction.fadeAlpha(to: 0.8, duration: 0.5)
            self.bombButton.run(fIn)
        }
        
        if let coins = UserDefaults.standard.object(forKey: "coins") as? Int {
            self.coins = coins
            coinlabel.text = "\(coins)"
        }
        
        if let level = UserDefaults.standard.object(forKey: "level") as? Int {
            self.level = level
            levelLabel.text = "\(level)"
        }
        
        if let lives = UserDefaults.standard.object(forKey: "lives") as? Int {
            self.lives = lives
            lifeLabel.text = "\(lives)"
        }
        
        if let wepCount = UserDefaults.standard.object(forKey: "weaponCount") as? Int {
            self.wepCount = wepCount
            if wepCount == 1 {
                bar.texture = SKTexture(imageNamed: "bar")
            } else {
                bar.texture = SKTexture(imageNamed: "bar\(wepCount)")
            }
        }
        
        if let type = UserDefaults.standard.object(forKey: "weaponType") as? WeaponType.RawValue,
            let wep = WeaponType(rawValue: type) {
            weaponType = wep
        }
        
        if let shield = UserDefaults.standard.object(forKey: "shield") as? Int {
            self.shield = shield
            shieldLabel.text = "\(shield)%"
            if shield > 0 {
                activateShield()
            }
        }
        
        if weaponType == .Gun {
            selectedWeapon.texture = Textures.guntexture
        } else if weaponType == .Fireball {
            selectedWeapon.texture = Textures.fireballtexture
        } else if weaponType == .Spread {
            selectedWeapon.texture = Textures.spreadtexture
        } else if weaponType == .Lightning {
            selectedWeapon.texture = Textures.lightningtexture
        }
        
        if let hiScore = UserDefaults.standard.value(forKey: "hiscore") as? Int {
            hiScoreLabel.text = "\(hiScore)"
        } else {
            hiScoreLabel.text = "0"
        }
        
        if let score = UserDefaults.standard.value(forKey: "score") as? Int {
            self.score = score
            scoreLabel.text = "\(score)"
        }
        
        let createBgShipAction = SKAction.sequence([SKAction.run(self.createBgShip), SKAction.wait(forDuration: 25)])
        run(SKAction.repeatForever(createBgShipAction), withKey: "createBgShipAction")

        let satelliteAction = SKAction.sequence([SKAction.run(self.createSatellite), SKAction.wait(forDuration: 60)])
        run(SKAction.repeatForever(satelliteAction), withKey: "satelliteAction")
        
        let createStarAction = SKAction.sequence([SKAction.run(self.createStar), SKAction.wait(forDuration: 2)])
        run(SKAction.repeatForever(createStarAction), withKey: "createStarAction")
        
        let cometAction = SKAction.sequence([SKAction.run(self.createComet), SKAction.wait(forDuration: 20)])
        run(SKAction.repeatForever(cometAction), withKey: "cometAction")
        
        let shipSparks = SKAction.sequence([SKAction.run(self.setShipSparks), SKAction.wait(forDuration: 0.5)])
        run(SKAction.repeatForever(shipSparks), withKey: "shipSparks")
        
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.level = level
        }
        
        if let shield = self.playerShield {
            shield.physicsBody?.isDynamic = true
        }
        setBG()
        isRequestingReview = false

        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playMusic(isLevelComplete: false, isMenu: false, isBoss: false, level: self.level)
        }
        
        if let _ = self.fireButton {
            let rotateAction = SKAction.rotate(byAngle: -15, duration: 25)
            self.fireButton.run(SKAction.repeatForever(rotateAction), withKey: "fireButtonRotation")
        }
        
        if let _ = self.missileButton {
            let rotateAction = SKAction.rotate(byAngle: -15, duration: 25)
            self.missileButton.run(SKAction.repeatForever(rotateAction), withKey: "missileButtonRotation")
        }
        
        if let _ = self.bombButton {
            let rotateAction = SKAction.rotate(byAngle: -15, duration: 25)
            self.bombButton.run(SKAction.repeatForever(rotateAction), withKey: "bombButtonRotation")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let three = self.childNode(withName: "//3"),
                let two = self.childNode(withName: "//2"),
                let one = self.childNode(withName: "//1"),
                let go = self.childNode(withName: "//go") {
                three.run(self.fadeOut, completion: {
                    two.run(self.fadeIn, completion: {
                        two.run(self.fadeOut, completion: {
                            one.run(self.fadeIn, completion: {
                                one.run(self.fadeOut, completion: {
                                    go.run(self.fadeIn, completion: {
                                        go.run(self.fadeOut, completion: {
                                            self.gameStarted = true
                                            self.fadeIn.duration = 0.15
                                            self.fadeOut.duration = 0.15

                                            self.shipPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleShipPan(gestureReconizer:)))
                                            self.shipPan.cancelsTouchesInView = false
                                            view.addGestureRecognizer(self.shipPan)
                                            
                                            let wait1Second = SKAction.wait(forDuration: 1)
                                            let incrementCounter = SKAction.run { [weak self] in
                                                self?.timer()
                                            }
                                            
                                            let sequence = SKAction.sequence([wait1Second, incrementCounter])
                                            self.run(SKAction.repeatForever(sequence), withKey: "timer")
                                            
                                            if self.level == 2 || self.level == 4 || self.level == 6 || self.level == 8 {
                                                // Create a life
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 40) {
                                                    let createLifeAction = SKAction.sequence([SKAction.run(self.createLife), SKAction.wait(forDuration: 40)])
                                                    self.run(SKAction.repeatForever(createLifeAction), withKey: "createlife")
                                                }
                                            }
                                            
                                            // Create a weapon
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                                                let createWeaponAction = SKAction.sequence([SKAction.run(self.createWeapon), SKAction.wait(forDuration: 20)])
                                                self.run(SKAction.repeatForever(createWeaponAction), withKey: "createweapon")
                                            }
                                            self.setEnemyActions()
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            }
        }
    }
    
    // MARK: - Ship pan and manual shoot routines
    
    @objc func fireShipWeapon() {
        guard let app = UIApplication.shared.delegate as? AppDelegate,
              let fireButton = self.fireButton,
              isPaused == false else { return }
        
        isAddingSentinelFire = false
        let size = UIScreen.main.bounds
        let rotateAction = SKAction.rotate(byAngle: -45, duration: 10)
        let moveAction = SKAction.moveTo(x: size.width * 2, duration: 6)
        moveAction.timingMode = .linear
        if weaponType == .Spread {
            setSpreadAction()
            app.playSpread()
        } else if weaponType == .Lightning {
            setLightningAction()
            app.playLightningSound()
        } else if let node = getNode() {
            if weaponType == .Fireball {
                app.playFireballSound()
            } else {
                app.playWeaponShot()
            }
            self.addChild(node)
            setTracer(node: node, action: moveAction, isEnemy: false, isLightning: false)
            
            let actions = SKAction.group([rotateAction, moveAction])
            node.run(actions)
        }
        
        if var _ = self.sentinel {
            isAddingSentinelFire = true
            if weaponType == .Spread {
                setSpreadAction()
            } else if weaponType == .Lightning {
                setLightningAction()
            } else if let node = getNode() {
                self.addChild(node)
                setTracer(node: node, action: moveAction, isEnemy: false, isLightning: false)
                
                let actions = SKAction.group([rotateAction, moveAction])
                node.run(actions)
            }
            
            sentinelDur -= 1
            sentinelLabel.text = "\(sentinelDur)"
            if sentinelDur == 0 {
                self.sentinel?.removeFromParent()
                self.sentinel = nil
            }
        }
        
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.25)
        let fadeIn = SKAction.fadeAlpha(to: 1.0 , duration: 0.25)
        fireButton.run(fadeOut, completion: {
            fireButton.run(fadeIn, completion: {
            })
        })
    }
    
    @objc func handleShipPan(gestureReconizer: UIPanGestureRecognizer) {
        guard didBeatGame == false, let v = view else { return }
        
        let currentTranslateX = gestureReconizer.translation(in: v).x
        let currentTranslateY = gestureReconizer.translation(in: v).y
        let translateX = currentTranslateX - previousTranslateX
        let translateY = currentTranslateY - previousTranslateY
        
        let newShapeX = ship.position.x + translateX
        let newShapeY = ship.position.y + translateY
        
        if gestureReconizer.state == .ended {
            previousTranslateX = 0.0
            previousTranslateY = 0.0
            let steady = SKAction.animate(with: self.playerArray, timePerFrame: 0.2)
            ship.run(SKAction.repeatForever(steady))
        } else {
            previousTranslateX = currentTranslateX
            previousTranslateY = currentTranslateY
        }
        
        guard (newShapeX <= pauseBtn.frame.minX && newShapeX >= scoreLabel.position.x) &&
            (newShapeY <= headerView.frame.minY && newShapeY >= grayBar.frame.maxY) else { return }
        
        if newShapeY < ship.position.y && !isShipDown {
            isShipUp = false
            isShipDown = true
            let down = SKAction.animate(with: self.playerDownArray, timePerFrame: 0.2)
            ship.run(down) {
                self.ship.texture = SKTexture(imageNamed: "playerdown4")
            }
        }
        
        if newShapeY > ship.position.y && !isShipUp {
            isShipUp = true
            isShipDown = false
            let up = SKAction.animate(with: self.playerUpArray, timePerFrame: 0.2)
            ship.run(up) {
                self.ship.texture = SKTexture(imageNamed: "playerup4")
            }
        }
        ship.position = CGPoint(x: ship.position.x + translateX, y: ship.position.y - translateY * 2)
    }
    
    func setEnemyActions() {
        if level == 3 || level == 6 || level == 9 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(8)
            let action = SKAction.sequence([SKAction.run(self.createBlob), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createblob")
        }
        
        if level >= 1 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(2.5)
            let action = SKAction.sequence([SKAction.run(self.createEnemy), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies")
        }
        
        if level >= 2 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(8)
            let action = SKAction.sequence([SKAction.run(self.createEnemy2), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies2")
        }
        
        if level >= 3 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(12)
            let action = SKAction.sequence([SKAction.run(self.createEnemy3), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies3")
        }
        
        if level >= 4 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(16)
            let action = SKAction.sequence([SKAction.run(self.createEnemy4), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies4")
        }
        
        if level >= 5 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(20)
            let action = SKAction.sequence([SKAction.run(self.createEnemy5), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies5")
        }
        
        if self.level >= 6 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(24)
            let action = SKAction.sequence([SKAction.run(self.createEnemy6), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies6")
        }
        
        if level >= 7 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(28)
            let action = SKAction.sequence([SKAction.run(self.createEnemy7), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies7")
        }
        
        if level >= 8 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(32)
            let action = SKAction.sequence([SKAction.run(self.createEnemy8), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies8")
        }
        
        if level >= 9 {
            let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(36)
            let action = SKAction.sequence([SKAction.run(self.createEnemy9), SKAction.wait(forDuration: dur)])
            self.run(SKAction.repeatForever(action), withKey: "createenemies9")
        }
    }
    
    func setBG() {
        guard let bg = self.bg else { return }
        
        for sprite in children {
            if sprite.name == "redplanet" || sprite.name == "yellowplanet" || sprite.name == "orangeplanet" || sprite.name == "multiplanet" || sprite.name == "planetring" || sprite.name == "planetstation" {
                sprite.removeFromParent()
            }
        }
        
        var image: UIImage?
        if level == 1 {
            bg.alpha = 0.5
            image = UIImage(named: "bg3")
            createPlanetsMulti()
        } else if level == 2 {
            bg.alpha = 0.6
            image = UIImage(named: "bg2")
            createOrangePlanet()
        } else if level == 3 {
            bg.alpha = 0.8
            image = UIImage(named: "bg")
            
            createRedPlanet()
            
        } else if level == 4 {
            bg.alpha = 0.6
            image = UIImage(named: "bg4")
        } else if level == 5 {
            bg.alpha = 0.7
            image = UIImage(named: "bg5")
        } else if level == 6 {
            bg.alpha = 1.0
            image = UIImage(named: "bg6")
            createPlanetStation()
        } else if level == 7 {
            bg.alpha = 0.4
            image = UIImage(named: "bg7")
        } else if level == 8 {
            bg.alpha = 0.9
            image = UIImage(named: "bg8")
            createYellowPlanet()
        } else if level == 9 {
            bg.alpha = 0.6
            image = UIImage(named: "bg9")
        } else if level == 10 {
            createPlanetRing()
            bg.alpha = 1.0
            image = UIImage(named: "bg10")
        }
        
        guard let i = image else { return }
        
        bg.texture = SKTexture(image: i)
    }
    
    @objc func fireEnemyAndBossWeapon(_ enemy: SKSpriteNode) {
        let width = UIScreen.main.bounds.width
        var fire = SKSpriteNode(imageNamed: "gun2")
        let weapons: [WeaponType] = [.Gun, .Fireball]
        let rotateAction = SKAction.rotate(byAngle: 45, duration: 10)
        if var weapon = weapons.randomElement() {
            if let _ = self.boss {
                if level == 1 {
                    weapon = .Gun
                    fire = SKSpriteNode(imageNamed: "gun3")
                } else if level == 2 {
                    weapon = .Fireball
                }
            }
            if weapon == .Gun {
                fire.size = CGSize(width: 50, height: 50)
                setEnemyAndBossFirePhysics(for: fire)
                fire.name = self.boss != nil ? "bossfire" : "enemyfire"
                if let boss = self.boss, level == 1 {
                    fire.position = CGPoint(x: boss.frame.midX, y: boss.frame.midY)
                } else {
                    fire.position = CGPoint(x: enemy.frame.minX, y: enemy.frame.midY)
                }
                fire.zPosition = 2
                self.addChild(fire)
                let action = SKAction.moveTo(x: -width * 2, duration: 4)
                action.timingMode = .linear
                setTracer(node: fire, action: action, isEnemy: true, isLightning: false)
                
                if let _ = self.boss, level == 3 {
                    fire.run(action)
                } else {
                    let actions = SKAction.group([action, rotateAction])
                    fire.run(actions)
                }
            } else if weapon == .Fireball {
                fire = SKSpriteNode(texture: SKTextureAtlas(named:"fireballwep").textureNamed("fireball1"))
                fire.size = CGSize(width: 40, height: 40)
                fire.accessibilityLabel = "enemyfireball"
                
                setEnemyAndBossFirePhysics(for: fire)
                fire.name = self.boss != nil ? "bossfire" : "enemyfire"
                fire.position = CGPoint(x: enemy.frame.minX, y: enemy.frame.midY)
                fire.zPosition = 2
                self.addChild(fire)
                
                let action = SKAction.moveTo(x: -width * 2, duration: 4)
                action.timingMode = .linear
                setTracer(node: fire, action: action, isEnemy: true, isLightning: false)
                
                let actions = SKAction.group([action, rotateAction])
                fire.run(actions)
            }
            
            if let app = UIApplication.shared.delegate as? AppDelegate {
                if let _ = self.boss {
                    app.playBossShot()
                } else {
                    app.playWeaponShot()
                }
            }
        }
    }
    
    func getNode() -> SKSpriteNode? {
        var nodeToFire = SKSpriteNode(imageNamed: "gun")
        if weaponType == .Gun {
            nodeToFire.size = CGSize(width: 50, height: 50)
            if wepCount == 2 {
                nodeToFire = SKSpriteNode(imageNamed: "gun2")
                nodeToFire.size = CGSize(width: 55, height: 55)
                addTopShot(node: nodeToFire)
            } else if wepCount == 3 {
                nodeToFire = SKSpriteNode(imageNamed: "gun2")
                nodeToFire.size = CGSize(width: 65, height: 65)
                addTopShot(node: nodeToFire)
            } else if wepCount == 4 {
                nodeToFire = SKSpriteNode(imageNamed: "gun3")
                nodeToFire.size = CGSize(width: 70, height: 70)
                addTopShot(node: nodeToFire)
                addBottomShot(node: nodeToFire)
            } else if wepCount == 5 {
                nodeToFire = SKSpriteNode(imageNamed: "gun3")
                nodeToFire.size = CGSize(width: 75, height: 75)
                addTopShot(node: nodeToFire)
                addBottomShot(node: nodeToFire)
            }
        } else if weaponType == .Fireball {
            nodeToFire = SKSpriteNode(texture: SKTextureAtlas(named:"fireballwep").textureNamed("fireball1"))
            nodeToFire.size = CGSize(width: 40, height: 40)
            nodeToFire.accessibilityLabel = "fireball"
            if wepCount == 2 {
                nodeToFire.colorBlendFactor = 0.4
                nodeToFire.color = UIColor.red
                nodeToFire.size = CGSize(width: 45, height: 45)
                addTopShot(node: nodeToFire)
            } else if wepCount == 3 {
                nodeToFire.colorBlendFactor = 0.6
                nodeToFire.color = UIColor.red
                nodeToFire.size = CGSize(width: 50, height: 50)
                addTopShot(node: nodeToFire)
            } else if wepCount == 4 {
                nodeToFire.colorBlendFactor = 0.8
                nodeToFire.color = UIColor.red
                nodeToFire.size = CGSize(width: 55, height: 55)
                addTopShot(node: nodeToFire)
                addBottomShot(node: nodeToFire)
            } else if wepCount == 5 {
                nodeToFire.colorBlendFactor = 1.0
                nodeToFire.color = UIColor.red
                nodeToFire.size = CGSize(width: 60, height: 60)
                addTopShot(node: nodeToFire)
                addBottomShot(node: nodeToFire)
            }
            let animate = SKAction.animate(with: self.fireballSprites, timePerFrame: 0.1)
            nodeToFire.run(SKAction.repeatForever(animate), withKey: "fireballaction")
        } else if weaponType == .Spread {
            nodeToFire = SKSpriteNode(imageNamed: "spread")
            nodeToFire.size = CGSize(width: 40, height: 40)
        }
        
        nodeToFire.name = "playerfire"
        nodeToFire.zPosition = 3
        setShipFirePhysics(for: nodeToFire)
        nodeToFire.position = CGPoint(x: ship.frame.maxX, y: ship.frame.midY)
        
        if isAddingSentinelFire,
            let sentinel = self.sentinel {
            nodeToFire.position = CGPoint(x: sentinel.frame.maxX, y: sentinel.frame.midY)
        }
        
        return nodeToFire
    }
    
    func createSpark() {
        let small = SKSpriteNode(imageNamed: "bgstar")
        small.alpha = 0.7
        small.size = CGSize(width: 15, height: 15)
        
        let medium = SKSpriteNode(imageNamed: "bgstar")
        medium.alpha = 0.5
        medium.size = CGSize(width: 25, height: 25)
        
        let large = SKSpriteNode(imageNamed: "bgstar")
        large.alpha = 0.3
        large.size = CGSize(width: 35, height: 35)
        
        let sparks = [small, medium, large]
        if let spark = sparks.randomElement() {
            spark.alpha = 0
            spark.name = "shipWeaponSpark"
            spark.color = UIColor.orange
            spark.colorBlendFactor = 1.0
            self.addChild(spark)
        }
    }
    
    func setEnemyAndBossFirePhysics(for node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 1.5)
        if let _ = self.boss {
            if level == 4 {
                node.physicsBody?.isDynamic = true
                node.physicsBody?.categoryBitMask = CollisionBitMask.enemyCategory
                node.physicsBody?.contactTestBitMask = CollisionBitMask.shipCategory | CollisionBitMask.enemyCategory
            } else {
                node.physicsBody?.isDynamic = false
                node.physicsBody?.categoryBitMask = CollisionBitMask.bossFireCategory
                node.physicsBody?.contactTestBitMask = CollisionBitMask.shipCategory | CollisionBitMask.bossFireCategory
            }
        } else {
            node.physicsBody?.isDynamic = false
            node.physicsBody?.categoryBitMask = CollisionBitMask.enemyFireCategory
            node.physicsBody?.contactTestBitMask = CollisionBitMask.shipCategory | CollisionBitMask.enemyFireCategory
        }
        node.physicsBody?.collisionBitMask = CollisionBitMask.shipCategory
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func setShipFirePhysics(for node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 5)
        node.physicsBody?.categoryBitMask = CollisionBitMask.shipFireCategory
        node.physicsBody?.collisionBitMask = CollisionBitMask.enemyCategory | CollisionBitMask.bossCategory
        node.physicsBody?.contactTestBitMask = CollisionBitMask.enemyCategory | CollisionBitMask.shipFireCategory | CollisionBitMask.bossCategory
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func launchTomahawk() {
        guard let _ = ship else { return }
                
        let m1 = SKSpriteNode(imageNamed: "tomahawk")
        m1.accessibilityLabel = "tomahawk"
        m1.size = CGSize(width: 50, height: 30)
        m1.position = ship.position
        m1.name = "playerfire"
        setShipFirePhysics(for: m1)
        
        let missileExhaust1 = SKSpriteNode(texture: SKTextureAtlas(named:"missileExhaust").textureNamed("redthrust"))
        missileExhaust1.size = CGSize(width: 60, height: 40)
        missileExhaust1.position = CGPoint(x: -40, y: 0)
        let toppoint = CGPoint(x: ship.position.x, y: ship.position.y + 150)
        let topmoveAction = SKAction.move(to: toppoint, duration: 3)
        m1.run(topmoveAction, withKey: "tomahawkLaunched")
        
        m1.addChild(missileExhaust1)
        
        let animateexhaust = SKAction.animate(with: self.missileExhaustArray, timePerFrame: 0.1)
        missileExhaust1.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        addChild(m1)
        m1.alpha = 1.0
        m1.zPosition = 4
        
        let sparks = SKAction.sequence([SKAction.run(self.createSpark), SKAction.wait(forDuration: 0.3)])
        m1.run(SKAction.repeatForever(sparks), withKey: "shipWeaponSpark")
                
        if tomahawkDur == 0, let _ = self.missileButton {
            let fOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
            self.missileButton.run(fOut)
        }
    }
    
    func setSpreadAction() {
        let rotateAction = SKAction.rotate(byAngle: -45, duration: 10)
        
        if wepCount == 1 || wepCount == 2 {
            if let node = getNode() {
                addChild(node)
                let toppoint: CGPoint!
                if isAddingSentinelFire {
                    toppoint = CGPoint(x: size.width, y: (sentinel?.position.y)! + 300)
                } else {
                    toppoint = CGPoint(x: size.width, y: ship.position.y + 300)
                }
                let topmoveAction = SKAction.move(to: toppoint, duration: 4)
                topmoveAction.timingMode = .linear
                setTracer(node: node, action: topmoveAction, isEnemy: false, isLightning: false)
                let actions = SKAction.group([rotateAction, topmoveAction])
                node.run(actions)
            }
            
            
            if let nextNode = getNode() {
                addChild(nextNode)
                let bottompoint: CGPoint!
                if isAddingSentinelFire {
                    bottompoint = CGPoint(x: size.width, y: (sentinel?.position.y)! - 300)
                } else {
                    bottompoint = CGPoint(x: size.width, y: ship.position.y - 300)
                }
                
                let bottommoveAction = SKAction.move(to: bottompoint, duration: 4)
                bottommoveAction.timingMode = .linear
                setTracer(node: nextNode, action: bottommoveAction, isEnemy: false, isLightning: false)
                let nextactions = SKAction.group([rotateAction, bottommoveAction])
                nextNode.run(nextactions)
            }
        } else if wepCount == 3 || wepCount == 4 {
            if let node = getNode() {
                node.colorBlendFactor = 0.7
                node.color = UIColor.blue
                
                addChild(node)
                let toppoint: CGPoint!
                if isAddingSentinelFire {
                    toppoint = CGPoint(x: size.width, y: (sentinel?.position.y)! + 300)
                } else {
                    toppoint = CGPoint(x: size.width, y: ship.position.y + 300)
                }
                let topmoveAction = SKAction.move(to: toppoint, duration: 4)
                topmoveAction.timingMode = .linear
                setTracer(node: node, action: topmoveAction, isEnemy: false, isLightning: false)
                let actions = SKAction.group([rotateAction, topmoveAction])
                node.run(actions)
            }
            
            if let nextNode = getNode() {
                nextNode.colorBlendFactor = 0.7
                nextNode.color = UIColor.blue
                addChild(nextNode)
                let moveAction = SKAction.moveTo(x: size.width, duration: 4)
                moveAction.timingMode = .linear
                setTracer(node: nextNode, action: moveAction, isEnemy: false, isLightning: false)
                let nextactions = SKAction.group([rotateAction, moveAction])
                nextNode.run(nextactions)
            }
            
            if let nextNextNode = getNode() {
                nextNextNode.colorBlendFactor = 0.7
                nextNextNode.color = UIColor.blue
                
                addChild(nextNextNode)
                let bottompoint: CGPoint!
                if isAddingSentinelFire {
                    bottompoint = CGPoint(x: size.width, y: (sentinel?.position.y)! - 300)
                } else {
                    bottompoint = CGPoint(x: size.width, y: ship.position.y - 300)
                }
                let bottommoveAction = SKAction.move(to: bottompoint, duration: 4)
                bottommoveAction.timingMode = .linear
                setTracer(node: nextNextNode, action: bottommoveAction, isEnemy: false, isLightning: false)
                let nextNextactions = SKAction.group([rotateAction, bottommoveAction])
                nextNextNode.run(nextNextactions)
            }
        } else {
            if let node = getNode() {
                node.colorBlendFactor = 0.7
                node.color = UIColor.red
                addChild(node)
                let toppoint: CGPoint!
                if isAddingSentinelFire {
                    toppoint = CGPoint(x: size.width, y: (sentinel?.position.y)! + 300)
                } else {
                    toppoint = CGPoint(x: size.width, y: ship.position.y + 300)
                }
                let topmoveAction = SKAction.move(to: toppoint, duration: 4)
                topmoveAction.timingMode = .linear
                setTracer(node: node, action: topmoveAction, isEnemy: false, isLightning: false)
                let actions = SKAction.group([rotateAction, topmoveAction])
                node.run(actions)
            }
            
            
            if let node3 = getNode() {
                node3.colorBlendFactor = 0.7
                node3.color = UIColor.red
                addChild(node3)
                let toppoint: CGPoint!
                if isAddingSentinelFire {
                    toppoint = CGPoint(x: size.width, y: (sentinel?.position.y)! + 100)
                } else {
                    toppoint = CGPoint(x: size.width, y: ship.position.y + 100)
                }
                let topmoveAction = SKAction.move(to: toppoint, duration: 4)
                topmoveAction.timingMode = .linear
                setTracer(node: node3, action: topmoveAction, isEnemy: false, isLightning: false)
                let actions = SKAction.group([rotateAction, topmoveAction])
                node3.run(actions)
            }
            
            if let node4 = getNode() {
                node4.colorBlendFactor = 0.7
                node4.color = UIColor.red
                addChild(node4)
                let toppoint: CGPoint!
                if isAddingSentinelFire {
                    toppoint = CGPoint(x: size.width, y: (sentinel?.position.y)! - 100)
                } else {
                    toppoint = CGPoint(x: size.width, y: ship.position.y - 100)
                }
                let topmoveAction = SKAction.move(to: toppoint, duration: 4)
                topmoveAction.timingMode = .linear
                setTracer(node: node4, action: topmoveAction, isEnemy: false, isLightning: false)
                let actions = SKAction.group([rotateAction, topmoveAction])
                node4.run(actions)
            }
            
            if let nextNextNode = getNode() {
                nextNextNode.colorBlendFactor = 0.7
                nextNextNode.color = UIColor.red
                addChild(nextNextNode)
                let bottompoint: CGPoint!
                if isAddingSentinelFire {
                    bottompoint = CGPoint(x: size.width, y: (sentinel?.position.y)! - 300)
                } else {
                    bottompoint = CGPoint(x: size.width, y: ship.position.y - 300)
                }
                let bottommoveAction = SKAction.move(to: bottompoint, duration: 4)
                bottommoveAction.timingMode = .linear
                setTracer(node: nextNextNode, action: bottommoveAction, isEnemy: false, isLightning: false)
                let nextNextactions = SKAction.group([rotateAction, bottommoveAction])
                nextNextNode.run(nextNextactions)
            }
        }
    }
    
    func addTopShot(node: SKSpriteNode) {
        if let copy = node.copy() as? SKSpriteNode {
            var toppoint: CGPoint!
            if isAddingSentinelFire {
                toppoint = CGPoint(x: size.width, y: (sentinel?.position.y)! + 300)
                copy.position = CGPoint(x: sentinel!.frame.maxX, y: sentinel!.frame.midY + 50)
            } else {
                toppoint = CGPoint(x: size.width, y: ship.position.y + 300)
                copy.position = CGPoint(x: ship.frame.maxX, y: ship.frame.midY)
            }
            
            copy.name = "playerfire"
            copy.zPosition = 3
            setShipFirePhysics(for: copy)
            self.addChild(copy)
            
            let topmoveAction = SKAction.move(to: toppoint, duration: 5.6)
            topmoveAction.timingMode = .linear
            setTracer(node: copy, action: topmoveAction, isEnemy: false, isLightning: false)
            
            var actions = SKAction.group([])
            let rotateAction = SKAction.rotate(byAngle: -45, duration: 10)
            if weaponType == .Fireball {
                actions = SKAction.group([rotateAction, topmoveAction])
            } else if weaponType == .Gun {
                actions = topmoveAction
            }
            copy.run(actions)
        }
    }
    
    func addBottomShot(node: SKSpriteNode) {
        if let copy = node.copy() as? SKSpriteNode {
            var toppoint: CGPoint!
            if isAddingSentinelFire {
                toppoint = CGPoint(x: size.width, y: (sentinel?.position.y)! - 300)
                copy.position = CGPoint(x: sentinel!.frame.maxX, y: sentinel!.frame.midY + 50)
            } else {
                toppoint = CGPoint(x: size.width, y: ship.position.y - 300)
                copy.position = CGPoint(x: ship.frame.maxX, y: ship.frame.midY)
            }
            
            copy.name = "playerfire"
            copy.zPosition = 3
            setShipFirePhysics(for: copy)
            self.addChild(copy)
            
            let topmoveAction = SKAction.move(to: toppoint, duration: 5.6)
            topmoveAction.timingMode = .linear
            setTracer(node: copy, action: topmoveAction, isEnemy: false, isLightning: false)
            
            var actions = SKAction.group([])
            let rotateAction = SKAction.rotate(byAngle: -45, duration: 10)
            if weaponType == .Fireball {
                actions = SKAction.group([rotateAction, topmoveAction])
            } else if weaponType == .Gun {
                actions = topmoveAction
            }
            copy.run(actions)
        }
    }
    
    func setLightningAction() {
        if let node = SKSpriteNode(texture: SKTextureAtlas(named:"lightningUp").textureNamed("lightningUp1")) as SKSpriteNode? {
            addChild(node)
            node.zPosition = 5
            node.name = "playerfire"
            if wepCount < 3 {
                node.size = CGSize(width: 60, height: 60)
            } else if wepCount < 5 {
                node.size = CGSize(width: 65, height: 65)
                node.colorBlendFactor = 0.6
                node.color = UIColor.purple
            } else {
                node.size = CGSize(width: 70, height: 70)
                node.colorBlendFactor = 0.6
                node.color = UIColor.red
            }
            var toppoint: CGPoint!
            if isAddingSentinelFire {
                toppoint = CGPoint(x: size.width, y: (sentinel?.position.y)! + 150)
                node.position = CGPoint(x: sentinel!.frame.maxX, y: sentinel!.frame.midY + 50)
            } else {
                toppoint = CGPoint(x: size.width, y: ship.position.y + 150)
                node.position = CGPoint(x: ship.frame.maxX, y: ship.frame.midY + 50)
            }
            
            setShipFirePhysics(for: node)
            let topmoveAction = SKAction.move(to: toppoint, duration: 12)
            topmoveAction.timingMode = .linear
            
            let animate = SKAction.animate(with: self.lightningUpSprites, timePerFrame: 0.1)
            let animateForever = SKAction.repeatForever(animate)
            setTracer(node: node, action: topmoveAction, isEnemy: false, isLightning: true)
            let actions = SKAction.group([topmoveAction, animateForever])
            node.run(actions)
        }
        
        if let nextNode = SKSpriteNode(texture: SKTextureAtlas(named:"lightningDown").textureNamed("lightningDown1")) as SKSpriteNode? {
            addChild(nextNode)
            nextNode.zPosition = 5
            nextNode.name = "playerfire"
            if wepCount < 3 {
                nextNode.size = CGSize(width: 60, height: 60)
            } else if wepCount < 5 {
                nextNode.size = CGSize(width: 65, height: 65)
                nextNode.colorBlendFactor = 0.6
                nextNode.color = UIColor.purple
            } else {
                nextNode.size = CGSize(width: 70, height: 70)
                nextNode.colorBlendFactor = 0.6
                nextNode.color = UIColor.red
            }
            let bottompoint: CGPoint!
            if isAddingSentinelFire {
                bottompoint = CGPoint(x: size.width, y: (sentinel?.position.y)! - 150)
                nextNode.position = CGPoint(x: sentinel!.frame.maxX, y: sentinel!.frame.midY - 50)
            } else {
                bottompoint = CGPoint(x: size.width, y: ship.position.y - 150)
                nextNode.position = CGPoint(x: ship.frame.maxX, y: ship.frame.midY - 50)
            }
            
            setShipFirePhysics(for: nextNode)
            let bottommoveAction = SKAction.move(to: bottompoint, duration: 12)
            bottommoveAction.timingMode = .linear
            let animate = SKAction.animate(with: self.lightningDownSprites, timePerFrame: 0.1)
            let animateForever = SKAction.repeatForever(animate)
            setTracer(node: nextNode, action: bottommoveAction, isEnemy: false, isLightning: true)
            let actions = SKAction.group([bottommoveAction, animateForever])
            nextNode.run(actions)
        }
    }

    func setTracer(node: SKSpriteNode, action: SKAction, isEnemy: Bool, isLightning: Bool) {
        if let tracer = node.copy() as? SKSpriteNode {
            self.addChild(tracer)
            tracer.physicsBody = nil
            tracer.position.y = node.position.y
            tracer.position.x = isEnemy ? node.position.x + 30 : node.position.x - 30
            tracer.run(action)
            if (isLightning) {
                tracer.size = CGSize(width: node.size.width, height: node.size.height)
            } else {
                tracer.size = CGSize(width: node.size.width * 3, height: node.size.height)
            }
            tracer.alpha = 0.5
            
            let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 2.5)
            tracer.run(fadeOut)
            
            if node.accessibilityLabel == "fireball" {
                let sparks = SKAction.sequence([SKAction.run(self.createSpark), SKAction.wait(forDuration: 0.3)])
                node.run(SKAction.repeatForever(sparks), withKey: "shipWeaponSpark")
            }
            
            if node.accessibilityLabel == "enemyfireball" {
                let sparks = SKAction.sequence([SKAction.run(self.createSpark), SKAction.wait(forDuration: 0.3)])
                node.run(SKAction.repeatForever(sparks), withKey: "enemyWeaponSpark")
            }
        }
    }
    
    func createLife() {
        if let life = SKSpriteNode(texture: Textures.lifetexture) as SKSpriteNode? {
            addBlinkingShell(sprite: life)
            let width = UIScreen.main.bounds.width

            let bot = -UIScreen.main.bounds.height + 150
            let top = UIScreen.main.bounds.height - 125
            let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
            life.position = CGPoint(x:width + 150, y: randomY)
            life.size = CGSize(width: 50, height: 50)
            life.zPosition = 3
            life.name = "createdlife"
            life.physicsBody = SKPhysicsBody(circleOfRadius: life.size.width)
            life.physicsBody?.categoryBitMask = CollisionBitMask.lifeCategory
            life.physicsBody?.collisionBitMask = CollisionBitMask.shipCategory | CollisionBitMask.lifeCategory
            life.physicsBody?.contactTestBitMask = CollisionBitMask.shipCategory | CollisionBitMask.lifeCategory
            life.physicsBody?.affectedByGravity = false
            life.physicsBody?.isDynamic = false
            life.physicsBody?.restitution = 0
            life.physicsBody?.linearDamping = 1.1
            self.addChild(life)

            let randomMoveDuration = TimeInterval(CGFloat(arc4random() % UInt32(10))) + 10
            let rotateAction = SKAction.rotate(byAngle: 45, duration: randomMoveDuration * 2)
            let moveAction = SKAction.moveTo(x: -width - 150, duration: randomMoveDuration)
            moveAction.timingMode = .linear

            let actions = SKAction.group([rotateAction, moveAction])
            life.run(SKAction.repeatForever(actions))
        }
    }
    
    func addBlinkingShell(sprite: SKSpriteNode) {
        if let shell = SKSpriteNode(texture: Textures.shelltexture) as SKSpriteNode? {
            shell.size = CGSize(width: 60, height: 60)
            shell.position = sprite.position
            shell.zPosition = sprite.zPosition - 1
            sprite.addChild(shell)

            let fOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
            let fIn = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
            let actions = SKAction.sequence([fOut, fIn])
            shell.run(SKAction.repeatForever(actions))
        }
    }

    func createWeapon() {
        var availableWeps = weaponSprites
        if sentinelDur > 0 {
            availableWeps = availableWeps.filter({$0.texture != Textures.sentineltexture})
        }
        if let texture = availableWeps.randomElement()?.texture {
            guard boss == nil else { return }
            
            let weapon = SKSpriteNode(texture: texture)
            addBlinkingShell(sprite: weapon)
            let width = UIScreen.main.bounds.width
            let bot = -UIScreen.main.bounds.height + 150
            let top = UIScreen.main.bounds.height - 125
            let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
            
            weapon.position = CGPoint(x:width + 150, y: randomY)
            weapon.size = CGSize(width: 50, height: 50)
            weapon.zPosition = 4
            weapon.name = "createdweapon"
            weapon.physicsBody = SKPhysicsBody(circleOfRadius: weapon.size.width)
            weapon.physicsBody?.categoryBitMask = CollisionBitMask.weaponCategory
            weapon.physicsBody?.collisionBitMask = CollisionBitMask.shipCategory | CollisionBitMask.weaponCategory
            weapon.physicsBody?.contactTestBitMask = CollisionBitMask.shipCategory | CollisionBitMask.weaponCategory
            weapon.physicsBody?.affectedByGravity = false
            weapon.physicsBody?.isDynamic = false
            weapon.physicsBody?.restitution = 0
            weapon.physicsBody?.linearDamping = 1.1
            self.addChild(weapon)
            
            let randomMoveDuration = TimeInterval(CGFloat(arc4random() % UInt32(10))) + 10
            let rotateAction = SKAction.rotate(byAngle: 45, duration: randomMoveDuration * 2)
            let moveAction = SKAction.moveTo(x: -width - 150, duration: randomMoveDuration)
            moveAction.timingMode = .linear
            
            let actions = SKAction.group([rotateAction, moveAction])
            weapon.run(SKAction.repeatForever(actions))
        }
    }
    
    func createShip() {
        let ship = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("player"))
        ship.name = "player"
        ship.size = CGSize(width: 120, height: 120)
        ship.position = CGPoint(x: scoreLabel.position.x, y: 0)
        ship.physicsBody = SKPhysicsBody(circleOfRadius: ship.size.width / 4)
        ship.physicsBody?.linearDamping = 0
        ship.physicsBody?.restitution = 0
        ship.physicsBody?.categoryBitMask = CollisionBitMask.shipCategory
        ship.physicsBody?.collisionBitMask = CollisionBitMask.enemyFireCategory | CollisionBitMask.enemyCategory | CollisionBitMask.bossCategory | CollisionBitMask.bossFireCategory
        ship.physicsBody?.contactTestBitMask = CollisionBitMask.enemyFireCategory | CollisionBitMask.enemyCategory | CollisionBitMask.bossCategory | CollisionBitMask.bossFireCategory
        ship.physicsBody?.affectedByGravity = false
        ship.physicsBody?.isDynamic = true
        ship.physicsBody?.allowsRotation = false
        ship.zPosition = 4
        
        addChild(ship)
        
        shipExhaust = SKSpriteNode(texture: SKTextureAtlas(named:"shipexhaust").textureNamed("shipexhaust"))
        ship.addChild(shipExhaust)
        shipExhaust.zPosition = 4
        shipExhaust.position = CGPoint(x: -80, y: 0)
        
        let animateexhaust = SKAction.animate(with: self.shipExhaustArray, timePerFrame: 0.1)
        shipExhaust.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        self.ship = ship
    }
    
    @objc func randomEnemyMoveAction(ship: SKSpriteNode) -> SKAction {
        var actions = [SKAction]()
        var randomMoveDuration: TimeInterval
        if ship.name == "bgship" {
            randomMoveDuration = TimeInterval(CGFloat(arc4random() % UInt32(10))) + 15
        } else {
            randomMoveDuration = TimeInterval(CGFloat(arc4random() % UInt32(10))) + 7
        }
        
        let width = UIScreen.main.bounds.width
        let linearAcross = SKAction.moveTo(x: -width - 150, duration: randomMoveDuration)
        let linearAcross2 = SKAction.moveTo(x: -width - 150, duration: randomMoveDuration)
        let linearAcross3 = SKAction.moveTo(x: -width - 150, duration: randomMoveDuration)
        let linear1Action = SKAction.moveTo(x: sentinelIcon.position.x, duration: randomMoveDuration)
        let linear2Action = SKAction.moveTo(x: selectedWeapon.position.x, duration: randomMoveDuration)
        let diagonalDownAction = SKAction.moveBy(x: bar.frame.minX, y: ship.position.y - 25, duration: 3)
        let diagonalUpAction = SKAction.moveBy(x: selectedWeapon.position.x, y: ship.position.y + 25, duration: 3)
        let seqDownUp = SKAction.sequence([linear1Action, diagonalDownAction, linear2Action, diagonalUpAction, linearAcross])
        let seqUpDown = SKAction.sequence([linear1Action, diagonalUpAction, linear2Action, diagonalDownAction, linearAcross])
        
        actions.append(linearAcross)
        actions.append(linearAcross2)
        actions.append(linearAcross3)
        actions.append(seqDownUp)
        actions.append(seqUpDown)
        
        return actions.randomElement() ?? linearAcross
    }
    
    @objc func createBgShip() {
        if let randomShipArray = bgShipsArray.randomElement(),
            let texture = randomShipArray.first,
            let ship = SKSpriteNode(texture: texture) as SKSpriteNode? {
            ship.size = CGSize(width: 45, height: 45)
            ship.name = "bgship"
            
            let bot = -UIScreen.main.bounds.height + 150
            let top = UIScreen.main.bounds.height - 125
            let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
            
            // Add enemy at random height
            let width = UIScreen.main.bounds.width
            ship.position = CGPoint(x:width + 150, y: randomY)
            ship.zPosition = 2
            ship.alpha = 0.8
            self.addChild(ship)
            ship.run(randomEnemyMoveAction(ship: ship), withKey: "shipBgMoveAction")
            
            let animate = SKAction.animate(with: randomShipArray, timePerFrame: 0.1)
            ship.run(SKAction.repeatForever(animate), withKey: "animate")
        }
    }
    
    @objc func setShipSparks() {
        let small = SKSpriteNode(imageNamed: "bgstar")
        small.alpha = 0.7
        small.size = CGSize(width: 15, height: 15)
        
        let medium = SKSpriteNode(imageNamed: "bgstar")
        medium.alpha = 0.5
        medium.size = CGSize(width: 25, height: 25)
        
        let large = SKSpriteNode(imageNamed: "bgstar")
        large.alpha = 0.3
        large.size = CGSize(width: 35, height: 35)
        
        let sparks = [small, medium, large]
        if let spark = sparks.randomElement() {
            spark.alpha = 1.0
            spark.name = "shipspark"
            spark.color = UIColor.magenta
            spark.colorBlendFactor = 1.0
            spark.position = CGPoint(x: self.ship.frame.minX, y: self.ship.position.y)
            self.addChild(spark)
        }
    }
    
    @objc func createStar() {
        let small = SKSpriteNode(imageNamed: "bgstar")
        small.alpha = 0.7
        small.size = CGSize(width: 15, height: 15)
        small.name = "star"
        
        let medium = SKSpriteNode(imageNamed: "bgstar")
        medium.alpha = 0.5
        medium.size = CGSize(width: 25, height: 25)
        medium.name = "star"
        
        let large = SKSpriteNode(imageNamed: "bgstar")
        large.alpha = 0.3
        large.size = CGSize(width: 35, height: 35)
        large.name = "star"
        
        let stars = [small, medium, large]
        if let star = stars.randomElement() {
            let bot = -UIScreen.main.bounds.height + 150
            let top = UIScreen.main.bounds.height - 125
            let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
            
            if let viewX = view?.frame.maxX {
                star.position = CGPoint(x: viewX + 150, y: randomY)
            }
            star.zPosition = 2
            self.addChild(star)
            
            let width = UIScreen.main.bounds.width
            let randomDuration = TimeInterval(CGFloat(arc4random() % UInt32(30) + 15))
            let action = SKAction.moveTo(x: -width * 2, duration: randomDuration)
            action.timingMode = .linear
            star.run(action)
        }
    }
    
    func getEnemyPhysics(enemy: SKSpriteNode) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.width / 2)
        physicsBody.categoryBitMask = CollisionBitMask.enemyCategory
        physicsBody.collisionBitMask = CollisionBitMask.shipFireCategory
        physicsBody.contactTestBitMask = CollisionBitMask.shipFireCategory
        physicsBody.affectedByGravity = false
        physicsBody.isDynamic = false
        physicsBody.restitution = 0
        physicsBody.linearDamping = 1.1
        physicsBody.allowsRotation = false
        
        return physicsBody
    }
    
    @objc func createAsteroids() {
        if let texture = asteroidSprites.randomElement()?.texture {
            let asteroid = SKSpriteNode(texture: texture)
            asteroid.name = "enemy"
            asteroid.physicsBody = getEnemyPhysics(enemy: asteroid)
            asteroid.accessibilityLabel = "asteroid"
            
            let bot = -UIScreen.main.bounds.height + 150
            let top = UIScreen.main.bounds.height - 125
            let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
            
            // Add enemy at random height
            let width = UIScreen.main.bounds.width
            asteroid.position = CGPoint(x:width + 150, y: randomY)
            asteroid.zPosition = 4
            self.addChild(asteroid)
            
            // Move enemy at random duration
            let randomMoveDuration = TimeInterval(CGFloat(arc4random() % UInt32(15)))
            let action = SKAction.moveTo(x: -width * 2, duration: randomMoveDuration)
            action.timingMode = .linear
            let rotateAction = SKAction.rotate(byAngle: 45, duration: 10)
            let actions = SKAction.group([action, rotateAction])
            asteroid.run(actions, withKey: "asteroidMoveAction")
        }
    }
    
    func enemySpeed() -> TimeInterval {
        var enemySpeedDur = 10
        if level == 2 {
            enemySpeedDur = 9
        } else if level == 3 {
            enemySpeedDur = 8
        } else if level == 4 {
            enemySpeedDur = 7
        } else if level == 6 {
            enemySpeedDur = 6
        } else if level == 7 {
            enemySpeedDur = 5
        } else if level == 8 {
            enemySpeedDur = 4
        } else if level == 10 {
            enemySpeedDur = 3
        }
        return TimeInterval(enemySpeedDur)
    }
    
    @objc func createYellowPlanet() {
        let yellowPlanet = SKSpriteNode(imageNamed: "yellowplanet")
        
        yellowPlanet.size = CGSize(width: 300, height: 300)
        yellowPlanet.name = "yellowplanet"
        
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        
        
        let width = UIScreen.main.bounds.width
        yellowPlanet.position = CGPoint(x:width + 150, y: randomY)
        yellowPlanet.zPosition = 1
        self.addChild(yellowPlanet)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 350, duration: 200)
        action.timingMode = .linear
        yellowPlanet.run(action, withKey: "yellowPlanetMove")
    }
    
    @objc func createPlanetsMulti() {
        let multi = SKSpriteNode(imageNamed: "Planets-Multi")
        
        multi.size = CGSize(width: 300, height: 300)
        multi.name = "multiplanet"
        
        let top = UIScreen.main.bounds.height - 300
        
        let width = UIScreen.main.bounds.width
        multi.position = CGPoint(x:width + 150, y: top)
        multi.zPosition = 1
        self.addChild(multi)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 350, duration: 200)
        action.timingMode = .linear
        multi.run(action, withKey: "multiPlanetMove")
    }
    
    @objc func createPlanetRing() {
        let ring = SKSpriteNode(imageNamed: "Planets-Ring")
        
        ring.size = CGSize(width: 300, height: 300)
        ring.name = "planetring"
        
        let top = UIScreen.main.bounds.height - 300
        
        let width = UIScreen.main.bounds.width
        ring.position = CGPoint(x:width + 150, y: top)
        ring.zPosition = 1
        self.addChild(ring)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 350, duration: 200)
        action.timingMode = .linear
        ring.run(action, withKey: "planetRingMove")
    }
    
    @objc func createPlanetStation() {
        let station = SKSpriteNode(imageNamed: "Planets-Station")
        
        station.size = CGSize(width: 300, height: 300)
        station.name = "planetstation"
        
        let top = UIScreen.main.bounds.height - 300
        
        let width = UIScreen.main.bounds.width
        station.position = CGPoint(x:width + 150, y: top)
        station.zPosition = 1
        self.addChild(station)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 350, duration: 200)
        action.timingMode = .linear
        station.run(action, withKey: "planetStationMove")
    }
    
    @objc func createOrangePlanet() {
        let orangePlanet = SKSpriteNode(imageNamed: "orangeplanet")
        
        orangePlanet.size = CGSize(width: 300, height: 300)
        orangePlanet.name = "orangeplanet"
        
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        
        
        let width = UIScreen.main.bounds.width
        orangePlanet.position = CGPoint(x:width + 150, y: randomY)
        orangePlanet.zPosition = 1
        self.addChild(orangePlanet)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 350, duration: 200)
        action.timingMode = .linear
        orangePlanet.run(action, withKey: "orangePlanetMove")
    }
    
    @objc func createSatellite() {
        let satellite = SKSpriteNode(texture: SKTextureAtlas(named:"boss3").textureNamed("boss"))
        satellite.size = CGSize(width: 45, height: 45)
        satellite.name = "satellite"
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        satellite.position = CGPoint(x:width + 150, y: randomY)
        satellite.zPosition = 2
        satellite.alpha = 0.8
        self.addChild(satellite)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 150, duration: 130)
        action.timingMode = .linear
        satellite.run(action, withKey: "satelliteMoveAction")
        
        let animate = SKAction.animate(with: self.boss3Array, timePerFrame: 0.1)
        satellite.run(SKAction.repeatForever(animate), withKey: "satelliteAction")
    }
    
    @objc func createComet() {
        let comet = SKSpriteNode(imageNamed: "comet")
        comet.size = CGSize(width: 80, height: 30)
        comet.name = "comet"
        comet.alpha = 0.5
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        comet.position = CGPoint(x:width + 150, y: randomY)
        comet.zPosition = 2
        self.addChild(comet)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 150, duration: 3)
        action.timingMode = .linear
        comet.run(action, withKey: "cometMoveAction")
    }
    
    @objc func createRedPlanet() {
        let redplanet = SKSpriteNode(imageNamed: "redplanet")
        
        redplanet.size = CGSize(width: 600, height: 600)
        redplanet.name = "redplanet"
        
        let bot = -UIScreen.main.bounds.height + 150
        let width = UIScreen.main.bounds.width
        redplanet.position = CGPoint(x:width + 150, y: bot)
        redplanet.zPosition = 1
        self.addChild(redplanet)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 550, duration: 200)
        action.timingMode = .linear
        redplanet.run(action, withKey: "redPlanetMove")
    }
    
    @objc func createEnemy() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy1").textureNamed("enemy"))
        enemy.size = CGSize(width: 94, height: 92)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Set random enemy move action
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy1Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireWeaponAction = SKAction.sequence([SKAction.run {
                self.fireEnemyAndBossWeapon(enemy)
                }, SKAction.wait(forDuration: randomFireDuration)])
            enemy.run(SKAction.repeatForever(fireWeaponAction), withKey: "enemyFireAction")
        }
    }
    
    @objc func createEnemy2() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy2").textureNamed("enemy"))
        enemy.size = CGSize(width: 86, height: 88)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Move enemy with random SKAction
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy2Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run( {self.setEnemy2Fire(enemy: enemy) } )]), count: 2)
            
            let fireSequence = SKAction.sequence([SKAction.wait(forDuration: 3), fireAction])
            enemy.run(SKAction.repeatForever(fireSequence))
        }
    }
    
    func setEnemy2Fire(enemy: SKSpriteNode) {
        let width = UIScreen.main.bounds.width
        let fire = SKSpriteNode(texture: SKTextureAtlas(named:"fireballwep").textureNamed("fireball1"))
        let rotateAction = SKAction.rotate(byAngle: 45, duration: 10)
        fire.size = CGSize(width: 40, height: 40)
        setEnemyAndBossFirePhysics(for: fire)
        fire.name = "enemyfire"
        fire.position = CGPoint(x: enemy.frame.minX, y: enemy.frame.midY)
        fire.zPosition = 2
        self.addChild(fire)
        let action = SKAction.moveTo(x: -width * 2, duration: 4)
        action.timingMode = .linear
        setTracer(node: fire, action: action, isEnemy: true, isLightning: false)
        
        let actions = SKAction.group([action, rotateAction])
        fire.run(actions)
    }
    
    func setEnemy3Fire(enemy: SKSpriteNode) {
        let width = UIScreen.main.bounds.width
        let fire = SKSpriteNode(imageNamed: "gun2")
        let rotateAction = SKAction.rotate(byAngle: 45, duration: 10)
        
        fire.size = CGSize(width: 50, height: 50)
        setEnemyAndBossFirePhysics(for: fire)
        fire.name = "enemyfire"
        
        fire.position = CGPoint(x: enemy.frame.minX, y: enemy.frame.midY)
        fire.zPosition = 2
        self.addChild(fire)
        
        let action = SKAction.moveTo(x: -width * 2, duration: 4)
        action.timingMode = .linear
        setTracer(node: fire, action: action, isEnemy: true, isLightning: false)
        
        let actions = SKAction.group([action, rotateAction])
        fire.run(actions)
    }
    
    @objc func createEnemy3() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy3").textureNamed("enemy"))
        enemy.size = CGSize(width: 82, height: 79)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Move enemy with random SKAction
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy3Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run( {self.setEnemy3Fire(enemy: enemy) } )]), count: 5)
            
            let fireSequence = SKAction.sequence([SKAction.wait(forDuration: 3), fireAction])
            enemy.run(SKAction.repeatForever(fireSequence))
        }
    }
    
    @objc func createEnemy4() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy4").textureNamed("enemy"))
        enemy.size = CGSize(width: 82, height: 79)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Move enemy with random SKAction
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy4Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireWeaponAction = SKAction.sequence([SKAction.run {
                self.fireEnemyAndBossWeapon(enemy)
                }, SKAction.wait(forDuration: randomFireDuration)])
            enemy.run(SKAction.repeatForever(fireWeaponAction), withKey: "enemyFireAction")
        }
    }
    
    @objc func createEnemy5() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy5").textureNamed("enemy"))
        enemy.size = CGSize(width: 82, height: 79)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Move enemy with random SKAction
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy5Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireWeaponAction = SKAction.sequence([SKAction.run {
                self.fireEnemyAndBossWeapon(enemy)
                }, SKAction.wait(forDuration: randomFireDuration)])
            enemy.run(SKAction.repeatForever(fireWeaponAction), withKey: "enemyFireAction")
        }
    }
    
    @objc func createEnemy6() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy6").textureNamed("enemy"))
        enemy.size = CGSize(width: 82, height: 79)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Move enemy with random SKAction
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy6Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireWeaponAction = SKAction.sequence([SKAction.run {
                self.fireEnemyAndBossWeapon(enemy)
                }, SKAction.wait(forDuration: randomFireDuration)])
            enemy.run(SKAction.repeatForever(fireWeaponAction), withKey: "enemyFireAction")
        }
    }
    
    @objc func createEnemy7() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy7").textureNamed("enemy"))
        enemy.size = CGSize(width: 82, height: 79)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Move enemy with random SKAction
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy7Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireWeaponAction = SKAction.sequence([SKAction.run {
                self.fireEnemyAndBossWeapon(enemy)
                }, SKAction.wait(forDuration: randomFireDuration)])
            enemy.run(SKAction.repeatForever(fireWeaponAction), withKey: "enemyFireAction")
        }
    }
    
    @objc func createEnemy8() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy8").textureNamed("enemy"))
        enemy.size = CGSize(width: 82, height: 75)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Move enemy with random SKAction
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy8Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireWeaponAction = SKAction.sequence([SKAction.run {
                self.fireEnemyAndBossWeapon(enemy)
                }, SKAction.wait(forDuration: randomFireDuration)])
            enemy.run(SKAction.repeatForever(fireWeaponAction), withKey: "enemyFireAction")
        }
    }
    
    @objc func createEnemy9() {
        let enemy = SKSpriteNode(texture: SKTextureAtlas(named:"enemy9").textureNamed("enemy"))
        enemy.size = CGSize(width: 92, height: 84)
        enemy.name = "enemy"
        enemy.physicsBody = getEnemyPhysics(enemy: enemy)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        enemy.position = CGPoint(x:width + 150, y: randomY)
        enemy.zPosition = 3
        self.addChild(enemy)
        
        // Move enemy with random SKAction
        enemy.run(randomEnemyMoveAction(ship: enemy), withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.enemy9Array, timePerFrame: 0.1)
        enemy.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        
        // Run enemy fire function forever at random duration
        var randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 2
        DispatchQueue.main.asyncAfter(deadline: .now() + randomFireDuration) {
            randomFireDuration = TimeInterval(CGFloat(arc4random() % UInt32(3))) + 6
            let fireWeaponAction = SKAction.sequence([SKAction.run {
                self.fireEnemyAndBossWeapon(enemy)
                }, SKAction.wait(forDuration: randomFireDuration)])
            enemy.run(SKAction.repeatForever(fireWeaponAction), withKey: "enemyFireAction")
        }
    }
    
    @objc func createBlob() {
        let blob = SKSpriteNode(texture: SKTextureAtlas(named:"blob").textureNamed("blob"))
        blob.accessibilityLabel = "blob"
        blob.size = CGSize(width: 86, height: 94)
        blob.name = "enemy"
        blob.physicsBody = getEnemyPhysics(enemy: blob)
        
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        blob.position = CGPoint(x:width + 150, y: randomY)
        blob.zPosition = 3
        self.addChild(blob)
        
        // Move enemy at random duration
        let randomMoveDuration = TimeInterval(CGFloat(arc4random() % UInt32(10))) + enemySpeed()
        let action = SKAction.moveTo(x: -width - 150, duration: randomMoveDuration)
        action.timingMode = .linear
        blob.run(action, withKey: "enemyMoveAction")
        
        let animateexhaust = SKAction.animate(with: self.blobSprites, timePerFrame: 0.1)
        blob.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
    }
    
    func setBossPhysics(boss: SKSpriteNode) {
        if let b = boss as SKSpriteNode? {
            b.physicsBody = SKPhysicsBody(circleOfRadius: b.size.width / 2.5)
            b.physicsBody?.categoryBitMask = CollisionBitMask.bossCategory
            b.physicsBody?.collisionBitMask = CollisionBitMask.shipCategory | CollisionBitMask.shipFireCategory
            b.physicsBody?.contactTestBitMask = CollisionBitMask.shipCategory | CollisionBitMask.shipFireCategory
            b.physicsBody?.affectedByGravity = false
            b.physicsBody?.isDynamic = true
            b.physicsBody?.restitution = 0
            b.physicsBody?.linearDamping = 0
            b.physicsBody?.allowsRotation = false
        }
    }
    
    func presentBoss() {
        bossStaticLifeLabel.isHidden = false
        bossLifeLabel.isHidden = false
        bossLifeLabel.text = "\(bossLife)%"
        self.bossStaticLifeLabel.text = "\(NSLocalizedString("Boss", comment: "")):"
        var fireAction: SKAction!
        let bot = -UIScreen.main.bounds.height + 300
        let top = UIScreen.main.bounds.height - 300
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        if level == 1 {
            boss = SKSpriteNode(texture: SKTextureAtlas(named:"boss1").textureNamed("boss0001"))
            if let boss = self.boss {
                let animate = SKAction.animate(with: self.boss1Array, timePerFrame: 0.1)
                boss.run(SKAction.repeatForever(animate), withKey: "bossanimate")
                boss.size = CGSize(width: 256, height: 256)
                boss.position = CGPoint(x:levelLabel.position.x, y: randomY)
                fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run( {self.fireEnemyAndBossWeapon(boss) } )]), count: 5)
            }
        } else if level == 2 {
            boss = SKSpriteNode(texture: SKTextureAtlas(named:"buzzBossNorm").textureNamed("1"))
            if let boss = self.boss {
                let animate = SKAction.animate(with: self.buzzBossNormArray, timePerFrame: 0.1)
                let attack = SKAction.animate(with: self.buzzBossAttackArray, timePerFrame: 0.1)
                let sequence = SKAction.sequence([animate,SKAction.wait(forDuration: 0.3), attack])
                
                boss.run(SKAction.repeatForever(sequence), withKey: "bossanimate")
                boss.size = CGSize(width: 256, height: 256)
                boss.position = CGPoint(x:levelLabel.position.x, y: randomY)
                fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run( {self.fireEnemyAndBossWeapon(boss) } )]), count: 5)
                enemyExhaust = SKSpriteNode(texture: SKTextureAtlas(named:"enemyExhaust6").textureNamed("thrust_gunner"))
                enemyExhaust.position = CGPoint(x: 150, y: 0)
                enemyExhaust.size = CGSize(width: 200, height: 160)
                boss.addChild(enemyExhaust)
                
                let animateexhaust = SKAction.animate(with: self.enemyExhaust6Array, timePerFrame: 0.1)
                enemyExhaust.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
            }
        } else if level == 4 {
            boss = SKSpriteNode(texture: SKTextureAtlas(named:"enemy2").textureNamed("enemy"))
            if let boss = self.boss {
                let animate = SKAction.animate(with: self.enemy2Array, timePerFrame: 0.1)
                boss.run(SKAction.repeatForever(animate), withKey: "bossanimate")
                boss.size = CGSize(width: 140, height: 120)
                boss.position = CGPoint(x:levelLabel.position.x, y: randomY)
                enemyExhaust = SKSpriteNode(texture: SKTextureAtlas(named:"enemyExhaust2").textureNamed("thrust_green"))
                enemyExhaust.position = CGPoint(x: 85, y: 0)
                enemyExhaust.size = CGSize(width: 100, height: 80)
                boss.addChild(enemyExhaust)
                
                let animateexhaust = SKAction.animate(with: self.enemyExhaust2Array, timePerFrame: 0.1)
                enemyExhaust.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
                bossStar = SKSpriteNode(texture: SKTextureAtlas(named:"star").textureNamed("star"))
                bossStar?.size = CGSize(width: 80, height: 85)
                bossStar?.position = CGPoint(x: 0, y: 150)
                boss.addChild(bossStar!)
                
                let botRight = SKAction.moveBy(x: 150, y: -150, duration: 0.25)
                let botLeft = SKAction.moveBy(x: -150, y: -150, duration: 0.25)
                let topLeft = SKAction.moveBy(x: -150, y: 150, duration: 0.25)
                let topRight = SKAction.moveBy(x:  150, y: 150, duration: 0.25)
                
                let sequence = SKAction.sequence([botRight, botLeft, topLeft, topRight])
                bossStar?.run(SKAction.repeatForever(sequence), withKey: "bossStarAction")
                fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run( {self.setBoss4Fire(boss: boss) } )]), count: 3)
            }
        } else if level == 5 {
            boss = SKSpriteNode(texture: SKTextureAtlas(named:"boss3").textureNamed("boss"))
            if let boss = self.boss {
                let animate = SKAction.animate(with: self.boss3Array, timePerFrame: 0.1)
                boss.run(SKAction.repeatForever(animate), withKey: "bossanimate")
                boss.size = CGSize(width: 120, height: 120)
                boss.position = CGPoint(x:levelLabel.position.x, y: randomY)
                fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run( {self.setBoss5Fire(boss: boss) } )]), count: 5)
            }
        } else if level == 7 {
            boss = SKSpriteNode(texture: SKTextureAtlas(named:"enemy6").textureNamed("enemy"))
            if let boss = self.boss {
                let animate = SKAction.animate(with: self.enemy6Array, timePerFrame: 0.1)
                boss.run(SKAction.repeatForever(animate), withKey: "bossanimate")
                boss.size = CGSize(width: 120, height: 120)
                boss.position = CGPoint(x:levelLabel.position.x, y: randomY)
                fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run( {self.setBoss7Fire(boss: boss) } )]), count: 8)
                
                enemyExhaust = SKSpriteNode(texture: SKTextureAtlas(named:"enemyExhaust6").textureNamed("thrust_gunner"))
                enemyExhaust.position = CGPoint(x: 85, y: 0)
                boss.addChild(enemyExhaust)
                
                let animateexhaust = SKAction.animate(with: self.enemyExhaust6Array, timePerFrame: 0.1)
                enemyExhaust.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
            }
        } else if level == 8 {
            boss = SKSpriteNode(texture: SKTextureAtlas(named:"enemy4").textureNamed("enemy"))
            if let boss = self.boss {
                let animate = SKAction.animate(with: self.enemy4Array, timePerFrame: 0.1)
                boss.run(SKAction.repeatForever(animate), withKey: "bossanimate")
                boss.size = CGSize(width: 120, height: 120)
                boss.position = CGPoint(x:levelLabel.position.x, y: randomY)
                fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run( {self.setBoss8Fire(boss: boss) } )]), count: 10)
                
                enemyExhaust = SKSpriteNode(texture: SKTextureAtlas(named:"enemyExhaust3").textureNamed("thrust_pink"))
                enemyExhaust.position = CGPoint(x: 85, y: 0)
                boss.addChild(enemyExhaust)
                
                let animateexhaust = SKAction.animate(with: self.enemyExhaust3Array, timePerFrame: 0.1)
                enemyExhaust.run(SKAction.repeatForever(animateexhaust), withKey: "thrust_pink")
            }
        } else if level == 10 {
            boss = SKSpriteNode(texture: SKTextureAtlas(named:"brainBossNorm").textureNamed("1"))
            if let boss = self.boss {
                let animate = SKAction.animate(with: self.brainBossNormArray, timePerFrame: 0.1)
                let attack = SKAction.animate(with: self.brainBossAttackArray, timePerFrame: 0.1)
                let sequence = SKAction.sequence([animate,SKAction.wait(forDuration: 0.3), attack])
                boss.run(SKAction.repeatForever(sequence), withKey: "bossanimate")
                boss.size = CGSize(width: 256, height: 256)
                boss.position = CGPoint(x:levelLabel.position.x, y: randomY)
                fireAction = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 0.4), SKAction.run( {self.setBoss10Fire(boss: boss) } )]), count: 4)
            }
        }
        
        if !isAsteroidBoss {
            guard let boss = self.boss else { return }
            
            boss.name = "boss"
            boss.zPosition = 3
            self.setBossPhysics(boss: boss)
            
            // Move enemy at random duration
            let randomMoveDuration = TimeInterval(CGFloat(arc4random() % UInt32(2))) + 3
            let up = SKAction.moveTo(y: top, duration: randomMoveDuration)
            let down = SKAction.moveTo(y: bot, duration: randomMoveDuration)
            let left = SKAction.moveTo(x: bar.position.x, duration: randomMoveDuration)
            let right = SKAction.moveTo(x: levelLabel.position.x, duration: randomMoveDuration)
            
            up.timingMode = .linear
            down.timingMode = .linear
            left.timingMode = .linear
            right.timingMode = .linear
            
            var sequence = SKAction.sequence([up, down])
            if level == 2 {
                sequence = SKAction.sequence([up, left, down, right])
            } else if level == 5 || level == 10 {
                sequence = SKAction.sequence([up, left, right, down, left, right, up, down])
            }
            boss.run(SKAction.repeatForever(sequence), withKey: "bossMoveAction")
            boss.alpha = 0
            self.addChild(boss)
            let fadeboss = SKAction.fadeAlpha(to: 1 , duration: 3.0)
            boss.run(fadeboss)
            
            let fireSequence = SKAction.sequence([SKAction.wait(forDuration: 3), fireAction])
            boss.run(SKAction.repeatForever(fireSequence))
        }
    }
    
    func setBoss10Fire(boss: SKSpriteNode) {
        let screen = UIScreen.main.bounds
        let bullet = SKSpriteNode(texture: SKTextureAtlas(named:"redBullet").textureNamed("bulletred"))
        bullet.size = CGSize(width: 90, height: 75)
        bullet.position = CGPoint(x: 0, y: -50)
        bullet.name = "bossfire"
        setEnemyAndBossFirePhysics(for: bullet)
        boss.addChild(bullet)
        
        let bullet2 = SKSpriteNode(texture: SKTextureAtlas(named:"redBullet").textureNamed("bulletred"))
        bullet2.size = CGSize(width: 90, height: 75)
        bullet2.position = CGPoint(x: 0, y: -50)
        bullet2.name = "bossfire"
        setEnemyAndBossFirePhysics(for: bullet2)
        boss.addChild(bullet2)
        
        let bullet3 = SKSpriteNode(texture: SKTextureAtlas(named:"redBullet").textureNamed("bulletred"))
        bullet3.size = CGSize(width: 90, height: 75)
        bullet3.position = CGPoint(x: 0, y: -50)
        bullet3.name = "bossfire"
        setEnemyAndBossFirePhysics(for: bullet3)
        boss.addChild(bullet3)
        
        let toppoint: CGPoint!
        toppoint = CGPoint(x: -screen.size.width * 2.5, y: boss.position.y + 300)
        let topmoveAction = SKAction.move(to: toppoint, duration: 4)
        topmoveAction.timingMode = .linear
        bullet.run(topmoveAction)
        
        let moveAction = SKAction.moveTo(x: -screen.size.width * 2.5, duration: 4)
        moveAction.timingMode = .linear
        bullet2.run(moveAction)
        
        let bottompoint: CGPoint!
        bottompoint = CGPoint(x: -screen.size.width * 2.5, y: boss.position.y - 300)
        let bottommoveAction = SKAction.move(to: bottompoint, duration: 4)
        bottommoveAction.timingMode = .linear
        bullet3.run(bottommoveAction)
        
        let animateexhaust = SKAction.animate(with: self.redBulletSprites, timePerFrame: 0.1)
        bullet.run(SKAction.repeatForever(animateexhaust), withKey: "boss10FireAction")
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playBossShot()
        }
    }
    
    func setBoss8Fire(boss: SKSpriteNode) {
        let screen = UIScreen.main.bounds
        let bullet = SKSpriteNode(imageNamed: "greenbullet")
        bullet.size = CGSize(width: 34, height: 34)
        bullet.position = CGPoint(x: 0, y: 0)
        boss.addChild(bullet)
        bullet.name = "bossfire"
        setEnemyAndBossFirePhysics(for: bullet)
        
        let action = SKAction.moveBy(x: -screen.width * 2.5, y: ship.position.y, duration: 3)
        action.timingMode = .linear
        bullet.run(action)
        
        let animateexhaust = SKAction.animate(with: self.greenBulletSprites, timePerFrame: 0.1)
        bullet.run(SKAction.repeatForever(animateexhaust), withKey: "boss8FireAction")
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playBossShot()
        }
    }
    
    func setBoss7Fire(boss: SKSpriteNode) {
        let screen = UIScreen.main.bounds
        let blueBullet = SKSpriteNode(texture: SKTextureAtlas(named:"blueBullet").textureNamed("bullet_blue"))
        blueBullet.size = CGSize(width: 90, height: 75)
        blueBullet.position = CGPoint(x: 0, y: 50)
        boss.addChild(blueBullet)
        blueBullet.name = "bossfire"
        setEnemyAndBossFirePhysics(for: blueBullet)
        
        let action = SKAction.moveBy(x: -screen.width * 2.5, y: ship.position.y, duration: 3)
        action.timingMode = .linear
        blueBullet.run(action)
        
        let animateexhaust = SKAction.animate(with: self.blueBulletSprites, timePerFrame: 0.1)
        blueBullet.run(SKAction.repeatForever(animateexhaust), withKey: "boss7FireAction")
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playBossShot()
        }
    }
    
    func setBoss5Fire(boss: SKSpriteNode) {
        let screen = UIScreen.main.bounds
        let pinkbullet = SKSpriteNode(imageNamed: "purplebullet")
        pinkbullet.size = CGSize(width: 80, height: 60)
        pinkbullet.position = CGPoint(x: 0, y: 0)
        boss.addChild(pinkbullet)
        pinkbullet.name = "bossfire"
        setEnemyAndBossFirePhysics(for: pinkbullet)
        
        let action = SKAction.moveBy(x: -screen.width * 2.5, y: ship.position.y, duration: 3)
        action.timingMode = .linear
        pinkbullet.run(action)
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playBossShot()
        }
    }
    
    func setBoss4Fire(boss: SKSpriteNode) {
        let screen = UIScreen.main.bounds
        let bossStar = SKSpriteNode(texture: SKTextureAtlas(named:"star").textureNamed("star"))
        bossStar.size = CGSize(width: 80, height: 85)
        bossStar.position = CGPoint(x: boss.position.x, y: boss.position.y + 50)
        addChild(bossStar)
        bossStar.name = "enemy"
        setEnemyAndBossFirePhysics(for: bossStar)
        
        let action = SKAction.moveBy(x: -screen.width * 2.5, y: ship.position.y, duration: 4)
        action.timingMode = .linear
        bossStar.run(action)
        
        let bossStar2 = SKSpriteNode(texture: SKTextureAtlas(named:"star").textureNamed("star"))
        bossStar2.size = CGSize(width: 80, height: 85)
        bossStar2.position = CGPoint(x: boss.position.x, y: boss.position.y - 50)
        addChild(bossStar2)
        bossStar2.name = "enemy"
        setEnemyAndBossFirePhysics(for: bossStar2)
        
        let action2 = SKAction.moveBy(x: -screen.width * 2.5, y: -ship.position.y, duration: 4)
        action2.timingMode = .linear
        bossStar2.run(action2)
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playBossShot()
        }
    }
    
    func stopActions() {
        
        if let action = action(forKey: "timer") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createblob") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies2") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies3") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies4") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies5") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies6") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies7") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies8") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createenemies9") {
            action.speed = 0
        }
        
        if let action = action(forKey: "createweapon") {
            action.speed = 0
        }
    }
    
    func startActions() {
        
        if let action = self.action(forKey: "timer") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createblob") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies2") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies3") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies4") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies5") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies6") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies7") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies8") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createenemies9") {
            action.speed = 1
        }
        
        if let action = self.action(forKey: "createweapon") {
            action.speed = 1
        }
    }
    
    func showAsteroids() {
        self.bossAlertLabel.text = NSLocalizedString("Asteroids", comment: "")
        self.bossLifeLabel.isHidden = true
        self.bossStaticLifeLabel.isHidden = false
        self.bossStaticLifeLabel.text = NSLocalizedString("Asteroids", comment: "")
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 1.0)
        let fadeIn = SKAction.fadeAlpha(to: 0.3 , duration: 1.0)
        let bossfadeIn = SKAction.fadeAlpha(to: 1.0 , duration: 0.5)
        if let app = UIApplication.shared.delegate as? AppDelegate,
            let gameMusicPlayer = app.musicPlayer {
            gameMusicPlayer.setVolume(0, fadeDuration: 3)
            app.playAlert()
        }
        
        shakeScreen()
        
        redBG.run(fadeIn, completion: {
            self.bossAlertLabel.run(bossfadeIn)
            self.redBG.run(fadeOut, completion: {
                self.bossAlertLabel.run(fadeOut)
                self.redBG.run(fadeIn, completion: {
                    self.bossAlertLabel.run(bossfadeIn)
                    self.redBG.run(fadeOut, completion: {
                        self.bossAlertLabel.run(fadeOut)
                        self.redBG.run(fadeIn, completion: {
                            self.bossAlertLabel.run(bossfadeIn)
                            self.redBG.run(fadeOut, completion: {
                                self.bossAlertLabel.run(fadeOut)
                                if let app = UIApplication.shared.delegate as? AppDelegate {
                                    app.playMusic(isLevelComplete: false, isMenu: false, isBoss: true, level: self.level)
                                }
                                
                                self.bg.removeAction(forKey: "shake")

                                self.seconds = 00
                                self.minute = 1
                                self.isAsteroidBoss = true

                                self.bg.alpha = 0.2
                                let dur = TimeInterval(CGFloat(arc4random() % UInt32(2))) + TimeInterval(1)
                                let asteroids = SKAction.sequence([SKAction.run(self.createAsteroids), SKAction.wait(forDuration: dur)])
                                self.run(SKAction.repeatForever(asteroids), withKey: "createAsteroids")
                                if let timer = self.action(forKey: "timer") {
                                    timer.speed = 1
                                }
                            })
                        })
                    })
                })
            })
        })
    }
    
    func shakeScreen() {
        if let bg = self.bg {
            let left = SKAction.moveTo(x: -10, duration: 0.01)
            let origin = SKAction.moveTo(x: 0, duration: 0.01)
            let right = SKAction.moveTo(x: 10, duration: 0.01)
            let actions = SKAction.sequence([left, origin, right, origin])
            
            bg.run(SKAction.repeatForever(actions), withKey: "shake")
        }
    }
    
    func showRedBossBG() {
        self.bossAlertLabel.text = NSLocalizedString("Boss", comment: "")
        
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 1.0)
        let fadeIn = SKAction.fadeAlpha(to: 0.3 , duration: 1.0)
        let bossfadeIn = SKAction.fadeAlpha(to: 1.0 , duration: 0.5)
        if let app = UIApplication.shared.delegate as? AppDelegate,
            let gameMusicPlayer = app.musicPlayer {
            gameMusicPlayer.setVolume(0, fadeDuration: 3)
            app.playAlert()
        }
        
        shakeScreen()
        
        redBG.run(fadeIn, completion: {
            self.bossAlertLabel.run(bossfadeIn)
            self.redBG.run(fadeOut, completion: {
                self.bossAlertLabel.run(fadeOut)
                self.redBG.run(fadeIn, completion: {
                    self.bossAlertLabel.run(bossfadeIn)
                    self.redBG.run(fadeOut, completion: {
                        self.bossAlertLabel.run(fadeOut)
                        self.redBG.run(fadeIn, completion: {
                            self.bossAlertLabel.run(bossfadeIn)
                            self.redBG.run(fadeOut, completion: {
                                self.bg.removeAction(forKey: "shake")
                                self.bossAlertLabel.run(fadeOut)
                                if let app = UIApplication.shared.delegate as? AppDelegate {
                                    app.playMusic(isLevelComplete: false, isMenu: false, isBoss: true, level: self.level)
                                }
                                self.bg.alpha = 0.2
                                self.presentBoss()
                            })
                        })
                    })
                })
            })
        })
    }
    
    func fireMissiles() {
        let size = UIScreen.main.bounds
        
        for node in children {
            if node.isKind(of: SKSpriteNode.self),
                let sprite = node as? SKSpriteNode,
                sprite.accessibilityLabel == "tomahawk" {
                if sprite.action(forKey: "tomahawkLaunched") == nil,
                   let _ = self.missileButton {
                    var moveAction = SKAction.moveTo(x: size.width * 2, duration: 5) as SKAction?
                    let onScreen = size.width - 50
                    
                    if let enemies = children.filter({$0.name == "enemy"}) as [SKNode]?,
                        enemies.count > 0 {
                        if let enemy = enemies.filter({ $0.position.x > sprite.position.x && $0.position.x < onScreen }).first {
                            moveAction = SKAction.move(to: enemy.position, duration: 1.5)
                            let close = enemy.position.x - 400
                            if sprite.position.x >= close {
                                moveAction = SKAction.move(to: enemy.position, duration: 0.5)
                            }
                        }
                    }
                    
                    if let boss = self.boss, sprite.position.x < boss.position.x {
                        moveAction = SKAction.move(to: boss.position, duration: 1.5)
                        let close = boss.position.x - 400
                        if sprite.position.x >= close {
                            moveAction = SKAction.move(to: boss.position, duration: 0.5)
                        }
                    }
                    
                    if let action = moveAction {
                        sprite.run(action)
                    }
                }
            }
        }
    }
    
    func displayLevelCompleteLabel() {
        let fadeIn = SKAction.fadeAlpha(to: 0.7 , duration: 0.5)
        if let complete = self.childNode(withName: "//levelCompleteLabel") {
            complete.run(fadeIn, completion: {
            })
        }
    }
    
    func hideLevelCompleteLabel() {
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
        if let complete = self.childNode(withName: "//levelCompleteLabel") {
            complete.run(fadeOut, completion: {
            })
        }
    }
    
    func timer() {
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1.0 , duration: 0.5)
        
        if !isAsteroidBoss {
            if minute == 0 {
                if seconds == 04,
                    let three = self.childNode(withName: "//3") {
                    three.run(fadeIn, completion: {
                        three.run(fadeOut, completion: {
                        })
                    })
                } else if seconds == 03,
                    let two = self.childNode(withName: "//2") {
                    two.run(fadeIn, completion: {
                        two.run(fadeOut, completion: {
                        })
                    })
                } else if seconds == 02,
                    let one = self.childNode(withName: "//1") {
                    one.run(fadeIn, completion: {
                        one.run(fadeOut, completion: {
                        })
                    })
                }
            }
        }
        
        if seconds == 01 && minute == 0 && !isAsteroidBoss {
            if self.level == 3 || self.level == 6 || self.level == 9 {
                self.showAsteroids()
            } else {
                self.showRedBossBG()
            }
        }
        
        if seconds == 00 {
            if minute == 1 {
                minute = 0
                seconds = 59
            } else if minute == 0 {
                if self.isAsteroidBoss {
                    self.removeAction(forKey: "createAsteroids")
                    self.isAsteroidBoss = false
                    if let timer = self.action(forKey: "timer") {
                        timer.speed = 0
                    }
                    if let fire = ship.action(forKey: "playerFireAction") {
                        fire.speed = 0
                    }
                    if let app = UIApplication.shared.delegate as? AppDelegate {
                        app.playMusic(isLevelComplete: true, isMenu: false, isBoss: false, level: level)
                    }
                    displayLevelCompleteLabel()
                    animateShipAfterLevel()
                    DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(6)) {
                        if self.level != 10 {
                            self.navigateToStore()
                        }
                    }
                } else if self.level == 3 || self.level == 6 || self.level == 9 {
                    self.isAsteroidBoss = true
                    self.stopActions()
                } else {
                    self.stopActions()
                }
            }
        } else {
            seconds -= 1
        }
    }
    
    func animateWeaponSparks() {
        for node in children {
            if node.isKind(of: SKSpriteNode.self),
                node.accessibilityLabel == "tomahawk" || node.accessibilityLabel == "fireball" || node.accessibilityLabel == "enemyfireball",
                let sparks = children.filter({$0.name == "shipWeaponSpark"}) as [SKNode]?,
                sparks.count > 0 {
                for spark in sparks {
                    if spark.hasActions() == false {
                        spark.alpha = 1
                        spark.zPosition = 3
                        spark.position = CGPoint(x: node.frame.minX, y: node.position.y)
                        let width = UIScreen.main.bounds.width
                        let randomDuration = TimeInterval(CGFloat(arc4random() % UInt32(30) + 15))
                        var action = SKAction.moveTo(x: -width * 2, duration: randomDuration)
                        if node.accessibilityLabel == "enemyfireball" {
                            action = SKAction.moveTo(x: width * 2, duration: randomDuration)
                        }
                        action.timingMode = .linear
                        spark.run(action)
                        
                        let fade = SKAction.fadeAlpha(to: 0.0, duration: 4)
                        spark.run(fade)
                    }
                }
            }
        }
    }
        
    func clearDefaults() {
        UserDefaults.standard.removeObject(forKey: "level")
        UserDefaults.standard.removeObject(forKey: "lives")
        UserDefaults.standard.removeObject(forKey: "weaponCount")
        UserDefaults.standard.removeObject(forKey: "weaponType")
        UserDefaults.standard.removeObject(forKey: "coins")
        UserDefaults.standard.removeObject(forKey: "bombs")
        UserDefaults.standard.removeObject(forKey: "sentinelDur")
        UserDefaults.standard.removeObject(forKey: "tomahawkDur")
        UserDefaults.standard.setValue(0, forKey: "score")
    }
    
    override func update(_ currentTime: TimeInterval) {
        if seconds < 10 {
            timerLabel.text = "\(minute):0\(seconds)"
        } else {
            timerLabel.text = "\(minute):\(seconds)"
        }
        
        for s in children {
            if s.name == "coin" {
                let move = SKAction.move(to: ship.position, duration: 0.5)
                s.run(move)
            }
        }
        
        if shield > 0,
            let ship = self.ship,
            let copy = children.filter({ $0.name == "shipshield" }) as [SKNode]?,
            copy.count > 0 {
            copy[0].position = ship.position
        }
        
        if boss != nil || isAsteroidBoss {
            let fadeOut = SKAction.fadeAlpha(to: 0.5, duration: 4)
            for sprite in children {
                if sprite.name == "bgship" || sprite.name == "satellite" {
                    sprite.alpha = 0.3
                }
                
                if sprite.name == "redplanet" ||
                    sprite.name == "orangeplanet" ||
                    sprite.name == "yellowplanet" {
                    sprite.run(fadeOut)
                }
            }
        }
        
        if let boss = self.boss, level != 2 && level != 5 {
            boss.position.x = levelLabel.position.x
        }
        
        if didBeatGame {
            clearDefaults()
        } else if let weaponType = self.weaponType as WeaponType?,
            let wepCount = self.wepCount as Int?,
            let level = self.level as Int?,
            let lives = self.lives as Int?,
            let coins = self.coins as Int?,
            let megaBombCount = self.megaBombCount as Int?,
            let sentinelDur = self.sentinelDur as Int?,
            let tomahawkDur = self.tomahawkDur as Int? {
            UserDefaults.standard.setValue(weaponType.rawValue, forKey: "weaponType")
            UserDefaults.standard.setValue(wepCount, forKey: "weaponCount")
            UserDefaults.standard.setValue(level, forKey: "level")
            UserDefaults.standard.setValue(lives, forKey: "lives")
            UserDefaults.standard.setValue(coins, forKey: "coins")
            UserDefaults.standard.setValue(megaBombCount, forKey: "bombs")
            UserDefaults.standard.setValue(sentinelDur, forKey: "sentinelDur")
            UserDefaults.standard.setValue(tomahawkDur, forKey: "tomahawkDur")
        }
        
        animateWeaponSparks()
        fireMissiles()
        
        if let sentinel = sentinel {
            sentinel.position = CGPoint(x: ship.frame.maxX - 20, y: ship.frame.maxY)
        }
        
        self.lifeLabel.text = "\(lives)"
        self.scoreLabel.text = "\(score)"
        self.levelLabel.text = "\(level)"
        self.coinlabel.text = "\(coins)"
        self.bombCountLabel.text = "\(megaBombCount)"
        self.sentinelLabel.text = "\(sentinelDur)"
        self.tomahawkLabel.text = "\(tomahawkDur)"
        
        if lives <= 0 {
            UserDefaults.standard.setValue(false, forKey: "willContinue")
            ship.physicsBody?.pinned = true
            ship.isHidden = true
            shipExhaust.isHidden = true
            ship.removeFromParent()
            shipExhaust.removeFromParent()
            self.lifeLabel.text = "\(0)"
            if let menuScene = GKScene(fileNamed: "MenuScene") {
                if let menuNode = menuScene.rootNode as? MenuScene,
                    let app = UIApplication.shared.delegate as? AppDelegate,
                    let player = app.musicPlayer {
                    if let _ = self.bannerView {
                        self.bannerView.removeFromSuperview()
                    }
                    clearDefaults()
                    player.setVolume(0, fadeDuration: 3)
                    menuNode.entities = menuScene.entities
                    menuNode.graphs = menuScene.graphs
                    menuNode.scaleMode = .aspectFit
                    menuNode.newGameLabel?.text = NSLocalizedString("Start", comment: "")
                    
                    let transition = SKTransition.fade(withDuration: 2)
                    self.view?.presentScene(menuNode, transition: transition)
                    app.level = 0
                    app.playIntro()
                    
                    if let v = self.view,
                        let window = v.window,
                        let root = window.rootViewController,
                        root.isKind(of: GameViewController.self),
                        let gameVC = root as? GameViewController {
                        gameVC.presentAd()
                    }
                }
            }
        } else {
            self.lifeLabel.text = "\(lives)"
            for node in children {
                if node.name == "shipspark" && node.hasActions() == false {
                    node.zPosition = 2
                    node.position = CGPoint(x:self.ship.frame.minX, y: self.ship.position.y)
                    let width = UIScreen.main.bounds.width
                    let randomDuration = TimeInterval(CGFloat(arc4random() % UInt32(30) + 15))
                    let action = SKAction.moveTo(x: -width * 2, duration: randomDuration)
                    action.timingMode = .linear
                    node.run(action)
                    
                    let fade = SKAction.fadeAlpha(to: 0.0, duration: 4)
                    node.run(fade)
                }
            }
        }
        
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 2)
        if isAsteroidBoss == false {
            for sprite in children {
                if sprite.accessibilityLabel == "asteroid" {
                    sprite.run(fadeOut)
                }
                // Set exhaust on enemy ship
                if (sprite.name == "enemy" && sprite.accessibilityLabel != "asteroid") || sprite.name == "bgship",
                    sprite.accessibilityLabel != "blob",
                    sprite.children.count == 0,
                    let exhaustArray = enemyExhausts.randomElement(),
                    boss == nil {
                    let texture = exhaustArray.first as SKTexture?
                    enemyExhaust = SKSpriteNode(texture: texture)
                    if sprite.name == "bgship" {
                        enemyExhaust.size = CGSize(width: enemyExhaust.size.width / 2, height: enemyExhaust.size.height / 2)
                        enemyExhaust.position = CGPoint(x: 30, y: 0)
                        enemyExhaust.alpha = 0.8
                    } else {
                        enemyExhaust.position = CGPoint(x: 60, y: 0)
                    }
                    sprite.addChild(enemyExhaust)
                    
                    let animateexhaust = SKAction.animate(with: exhaustArray, timePerFrame: 0.1)
                    enemyExhaust.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
                }
            }
        }
        
        for sprite in children {
            if sprite.name == "enemy" || sprite.name == "createdweapon" {
                if sprite.position.x < frame.minX + 100 {
                    sprite.physicsBody?.isDynamic = false
                } else if sprite.position.x < frame.maxX - 50 {
                    sprite.physicsBody?.isDynamic = true
                }
            }
            
            if sprite.name == "player" {
                guard let headerView = self.headerView, let grayBar = self.grayBar else {return}
                
                if sprite.position.y >= headerView.frame.origin.y - 30 {
                    sprite.position.y = headerView.frame.origin.y - 30
                } else if sprite.position.y <= grayBar.frame.maxY + 30 {
                    sprite.position.y = grayBar.frame.maxY + 30
                }
            }
            
            // Remove enemies, weapons, stars and player/enemy fire
            if sprite.frame.maxX <= frame.minX || (sprite.name == "playerfire" && sprite.frame.minX >= frame.maxX) {
                if sprite.accessibilityLabel == "fireball" {
                    removeAction(forKey: "shipWeaponSpark")
                }
                if sprite.accessibilityLabel == "enemyfireball" {
                    removeAction(forKey: "enemyWeaponSpark")
                }
                sprite.removeFromParent()
            }
        }
    }

    func pauseGame() {
        guard let _ = physicsWorld as SKPhysicsWorld?,
            let app = UIApplication.shared.delegate as? AppDelegate,
            let gameMusicPlayer = app.musicPlayer,
            gameStarted else { return }
        
        self.shipPan.isEnabled = false
        
        physicsWorld.speed = 0
        isPaused = true
        gameMusicPlayer.pause()
        unPauseLabel.isHidden = false
        
        returnToMenuLabel.isHidden = false
        pausedLabel.isHidden = false
        pausedLabelBG.isHidden = false
        pauseBtn.texture = Textures.unpausetexture
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }
        
        for touch: AnyObject in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if gameStarted {
                if touchedNode == fireButton,
                   let _ = self.fireButton {
                    fireShipWeapon()
                } else if touchedNode == endGameReturnMenuLabel,
                    let view = self.view as SKView?,
                    let menuScene = SKScene(fileNamed: "MenuScene") as? MenuScene {
                    clearDefaults()
                    app.playMenuItemSound()
                    let transition = SKTransition.fade(withDuration: 1)
                    menuScene.scaleMode = .aspectFit
                    menuScene.newGameLabel?.text = NSLocalizedString("Start", comment: "")
                    view.ignoresSiblingOrder = true
                    view.presentScene(menuScene, transition: transition)
                } else if touchedNode == pauseBtn || touchedNode == unPauseLabel {
                    app.playMenuItemSound()
                    if isPaused == true {
                        isPaused = false
                        self.shipPan.isEnabled = true
                        pausedLabel.isHidden = true
                        pausedLabelBG.isHidden = true
                        unPauseLabel.isHidden = true
                        returnToMenuLabel.isHidden = true
                        physicsWorld.speed = 1
                        pauseBtn.texture = Textures.pausetexture
                        if let app = UIApplication.shared.delegate as? AppDelegate,
                            let gameMusicPlayer = app.musicPlayer {
                            gameMusicPlayer.play()
                        }
                    } else {
                        pauseGame()
                    }
                } else if touchedNode == returnToMenuLabel,
                    let view = self.view as SKView?,
                    let menuScene = SKScene(fileNamed: "MenuScene") as? MenuScene,
                    let app = UIApplication.shared.delegate as? AppDelegate {
                    app.playMenuItemSound()
                    let transition = SKTransition.fade(withDuration: 1)
                    menuScene.scaleMode = .aspectFit
                    if let willContinue = UserDefaults.standard.object(forKey: "willContinue") as? Bool,
                        willContinue == true {
                        menuScene.newGameLabel?.text = NSLocalizedString("Continue", comment: "")
                    } else {
                        menuScene.newGameLabel?.text = NSLocalizedString("Start", comment: "")
                    }
                    view.ignoresSiblingOrder = true
                    view.presentScene(menuScene, transition: transition)
                    app.level = 0
                    app.playIntro()
                    if let _ = self.bannerView {
                        self.bannerView.removeFromSuperview()
                    }
                } else if touchedNode == bombButton, megaBombCount > 0 {
                    megaBombCount -= 1
                    if megaBombCount <= 0 {
                        megaBombCount = 0
                    }
                    bombCountLabel.text = "\(megaBombCount)"
                    UserDefaults.standard.setValue(megaBombCount, forKey: "bombs")
                    
                    let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.25)
                    let fadeIn = SKAction.fadeAlpha(to: 0.8 , duration: 0.25)
                    bombButton.run(fadeOut, completion: {
                        app.playMegabomb()
                        self.bombButton.run(fadeIn, completion: {
                            self.dropMegaBomb()
                        })
                    })
                } else if touchedNode == missileButton, tomahawkDur > 0 {
                    tomahawkDur -= 1
                    if tomahawkDur <= 0 {
                        tomahawkDur = 0
                    }
                    UserDefaults.standard.setValue(tomahawkDur, forKey: "tomahawkDur")
                    
                    let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.25)
                    let fadeIn = SKAction.fadeAlpha(to: 0.8 , duration: 0.25)
                    missileButton.run(fadeOut, completion: {
                        app.playMissileSound()
                        self.missileButton.run(fadeIn, completion: {
                            self.launchTomahawk()
                        })
                    })
                }
            }
        }
    }
    
    func deductPlayerLife() {
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playHit()
        }
        lives -= 1
        UserDefaults.standard.setValue(lives, forKey: "lives")
        blinkRed(sprite: ship)
    }
    
    func getNodeForCollision(first: SKPhysicsBody, second: SKPhysicsBody, name: String) -> SKNode? {
        var node: SKNode?
        if first.node?.name == name {
            node = first.node
        } else if second.node?.name == name {
            node = second.node
        }
        return node
    }
    
    func destroyPlayer() {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }
        
        if shield >= 20 {
            app.playHit()
            blinkPurple()
            shield -= 20
            shieldLabel.text = "\(shield)%"
            UserDefaults.standard.setValue(shield, forKey: "shield")
            if shield == 0,
                let _ = playerShield {
                playerShield?.physicsBody = nil
                playerShield?.removeFromParent()
                playerShield = nil
            }
        } else {
            if lives == 1 {
                app.playBossPlayerDeathSound()
                let explosion = SKAction.animate(with: self.expArray, timePerFrame: 0.1)
                self.ship.run(explosion, completion: {
                    self.lives -= 1
                })
            } else {
                self.deductPlayerLife()
            }
        }
    }
    
    func activateShield() {
        if let ship = self.ship {
            let shield = SKShapeNode(circleOfRadius: 70 ) // Size of Circle
            shield.fillColor = UIColor.systemPurple
            shield.alpha = 0.2
            shield.zPosition = ship.zPosition - 1
            shield.name = "shipshield"
            shield.position = ship.position
            shield.physicsBody = SKPhysicsBody(circleOfRadius: 70)
            shield.physicsBody?.linearDamping = 0
            shield.physicsBody?.restitution = 0
            shield.physicsBody?.categoryBitMask = CollisionBitMask.shieldCategory
            shield.physicsBody?.collisionBitMask = CollisionBitMask.enemyFireCategory | CollisionBitMask.enemyCategory | CollisionBitMask.bossCategory | CollisionBitMask.bossFireCategory
            shield.physicsBody?.contactTestBitMask = CollisionBitMask.enemyFireCategory | CollisionBitMask.enemyCategory | CollisionBitMask.bossCategory | CollisionBitMask.bossFireCategory
            shield.physicsBody?.affectedByGravity = false
            shield.physicsBody?.isDynamic = true
            shield.physicsBody?.allowsRotation = false
            
            let fOut = SKAction.fadeAlpha(to: 0.1, duration: 0.5)
            let fIn = SKAction.fadeAlpha(to: 0.2, duration: 0.5)
            let actions = SKAction.sequence([fOut, fIn])
            shield.run(SKAction.repeatForever(actions))
            addChild(shield)
            
            playerShield = shield
        }
    }
    
    func blinkPurple() {
        if let ship = self.ship {
            ship.color = UIColor.purple
            ship.colorBlendFactor = 1
            ship.run(fadeOut) {
                ship.colorBlendFactor = 0.1
                ship.run(self.fadeIn, completion: {
                    ship.colorBlendFactor = 1
                    ship.run(self.fadeOut, completion: {
                        ship.colorBlendFactor = 0.1
                        ship.run(self.fadeIn, completion: {
                            ship.colorBlendFactor = 0
                            self.playerHit = false
                        })
                    })
                })
            }
        }
    }

    func blinkRed(sprite: SKSpriteNode) {
        sprite.color = UIColor.red
        sprite.colorBlendFactor = 1
        sprite.run(fadeOut) {
            sprite.colorBlendFactor = 0.1
            sprite.run(self.fadeIn, completion: {
                sprite.colorBlendFactor = 1
                sprite.run(self.fadeOut, completion: {
                    sprite.colorBlendFactor = 0.1
                    sprite.run(self.fadeIn, completion: {
                        sprite.colorBlendFactor = 0
                        if sprite.name == "player" {
                            self.playerHit = false
                        }
                    })
                })
            })
        }
    }
    
    func navigateToStore() {
        level += 1
        UserDefaults.standard.setValue(self.level, forKey: "level")
        if let store = SKScene(fileNamed: "Store") as? Store,
            let view = self.view,
            let app = UIApplication.shared.delegate as? AppDelegate {
            app.playIntro()
            store.gameStarted = true
            store.scaleMode = .aspectFit
            if let _ = self.bannerView {
                self.bannerView.removeFromSuperview()
            }
            let transition = SKTransition.fade(withDuration: 1.5)
            view.presentScene(store, transition: transition)
        }
    }
    
    func animateShipAfterLevel() {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }

        shipPan.isEnabled = false
        ship.physicsBody = nil
        let one = SKAction.moveTo(x: self.bossStaticLifeLabel.frame.minX, duration: 4)
        let two = SKAction.moveTo(x: self.frame.maxX + 200, duration: 2)
        if let shield = self.playerShield {
            shield.physicsBody?.isDynamic = false
        }
        self.ship.run(one) {
            app.playMissileSound()
            self.ship.run(two) {
                self.hideLevelCompleteLabel()
            }
        }
    }
    
    func destroyBoss(_ boss: SKSpriteNode) {
        bossShot += 1
        bossLife -= 10
        bossLifeLabel.text = "\(bossLife)%"
        blinkRed(sprite: boss)
        
        if bossShot == 10 {
            showKillScore(node: boss)
            boss.physicsBody = nil
            boss.removeAllActions()
            
            guard let app = UIApplication.shared.delegate as? AppDelegate else { return }
            
            boss.run(fadeOut) {
                boss.run(self.fadeIn, completion: {
                    boss.run(self.fadeOut, completion: {
                        boss.run(self.fadeIn, completion: {
                            app.playBossPlayerDeathSound()
                            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(0.25)) {
                                app.playBossPlayerDeathSound()
                                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(0.25)) {
                                    app.playBossPlayerDeathSound()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(0.5)) {
                                        if let app = UIApplication.shared.delegate as? AppDelegate {
                                            app.playMusic(isLevelComplete: true, isMenu: false, isBoss: false, level: self.level)
                                        }
                                        self.displayLevelCompleteLabel()
                                    }
                                }
                            }
                            if let fire = self.ship.action(forKey: "playerFireAction") {
                                fire.speed = 0
                            }
                            boss.removeFromParent()
                            self.boss = nil
                            
                            self.score += 500
                            self.giveCoins(enemy: boss)
                            self.setHiScore()

                            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(3)) {
                                self.animateShipAfterLevel()
                                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(6)) {
                                    if self.level != 10 {
                                        self.navigateToStore()
                                    } else {
                                        // END OF GAME!
                                        self.stopActions()
                                        self.levelCompleteLabel.isHidden = true
                                        self.fireButton.isHidden = true
                                        self.timerLabel.isHidden = true
                                        self.shieldIcon.isHidden = true
                                        self.shieldLabel.isHidden = true
                                        self.tomahawkIcon.isHidden = true
                                        self.tomahawkLabel.isHidden = true
                                        self.bombCountLabel.isHidden = true
                                        self.bombButton.isHidden = true
                                        self.missileButton.isHidden = true
                                        self.megaBomb.isHidden = true
                                        self.ship.removeAllActions()
                                        self.coinIcon.isHidden = true
                                        self.coinlabel.isHidden = true
                                        self.ship.isHidden = true
                                        self.grayBar.isHidden = true
                                        self.shipIcon.isHidden = true
                                        self.shipIconExhaust.isHidden = true
                                        self.pauseBtn.isHidden = true
                                        self.livesXLabel.isHidden = true
                                        self.congratsLabel.isHidden = false
                                        self.congratsDetailsLabel.isHidden = false
                                        self.endGameReturnMenuLabel.isHidden = false
                                        self.bar.isHidden = true
                                        self.selectedWeapon.isHidden = true
                                        self.sentinelIcon.isHidden = true
                                        self.sentinelLabel.isHidden = true
                                        self.sentinel?.isHidden = true
                                        self.lifeLabel.isHidden = true
                                        self.hiScoreLabel.isHidden = true
                                        self.scoreLabel.isHidden = true
                                        self.staticScoreLabel.isHidden = true
                                        self.staticLevelLabel.isHidden = true
                                        self.hiLabel.isHidden = true
                                        self.levelLabel.isHidden = true
                                        self.bg.alpha = 0.4
                                        self.didBeatGame = true
                                        self.bossLifeLabel.isHidden = true
                                        self.bossStaticLifeLabel.isHidden = true
                                        self.shipExhaust.isHidden = true
                                        self.headerView.isHidden = true
                                        if let _ = self.bannerView {
                                            self.bannerView.removeFromSuperview()
                                        }
                                        app.playIntro()
                                    }
                                }
                            }
                        })
                    })
                })
            }
        }
    }
    func giveCoins(enemy: SKSpriteNode) {
        let shouldGiveCoins = enemy.name == "enemy" ? [true, false].randomElement() : true
        if shouldGiveCoins == true {
            let qty = [1,2,3,4,5,6,7,8,9,10]
            if let q = qty.randomElement() {
                for i in 1...q {
                    let coin = SKSpriteNode(texture: SKTextureAtlas(named:"coins").textureNamed("1"))
                    coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width / 2)
                    coin.physicsBody?.categoryBitMask = CollisionBitMask.coinCategory
                    coin.physicsBody?.collisionBitMask = CollisionBitMask.shipCategory | CollisionBitMask.coinCategory
                    coin.physicsBody?.contactTestBitMask = CollisionBitMask.shipCategory | CollisionBitMask.coinCategory
                    coin.physicsBody?.affectedByGravity = false
                    coin.physicsBody?.isDynamic = false
                    coin.physicsBody?.restitution = 0
                    coin.physicsBody?.linearDamping = 1.1
                    coin.size = CGSize(width: 50, height: 50)
                    coin.name = "coin"
                    coin.zPosition = 4
                    if i == q {
                        coin.accessibilityLabel = "lastcoin"
                    }
                    if let buffer = i == 1 ? 0 : i == 2 ? 50 : i == 3 ? 100 : i == 4 ? 150 : i == 5 ? 200 : i == 6 ? 250 : i == 7 ? 300 : i == 8 ? 350 : i == 9 ? 400 : 450 {
                        let v = CGFloat(buffer)
                        coin.position = CGPoint(x:enemy.position.x + v, y: enemy.position.y)
                        let animate = SKAction.animate(with: self.coinArray, timePerFrame: 0.1)
                        coin.run(SKAction.repeatForever(animate), withKey: "coinaction")
                        addChild(coin)
                    }
                }
            }
        }
    }
    
    func showKillScore(node: SKSpriteNode) {
        let scoreLabel = SKLabelNode(fontNamed: "Futura-Medium")
        scoreLabel.fontSize = 24
        if node.name == "boss" {
            scoreLabel.text = "+500"
        } else {
            scoreLabel.text = "+50"
        }
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = node.position
        scoreLabel.zPosition = 15
        addChild(scoreLabel)
        let height = UIScreen.main.bounds.height
        let upAction = SKAction.moveTo(y: height, duration: 5)
        scoreLabel.run(upAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(2)) {
            scoreLabel.removeFromParent()
        }
    }
    
    func setHiScore() {
        if let hiScore = UserDefaults.standard.value(forKey: "hiscore") as? Int {
            if score > hiScore {
                UserDefaults.standard.setValue(score, forKey: "hiscore")
                hiScoreLabel.text = "\(score)"
            }
        } else {
            UserDefaults.standard.setValue(score, forKey: "hiscore")
        }
        UserDefaults.standard.setValue(score, forKey: "score")
    }
    
    func destroyEnemy(_ enemy: SKSpriteNode) {
        showKillScore(node: enemy)
        enemy.physicsBody = nil
        enemy.removeAllActions()
        giveCoins(enemy: enemy)

        let explosion = SKAction.animate(with: self.expArray, timePerFrame: 0.1)
        enemy.run(explosion, completion: {
            self.score += 50
            self.setHiScore()
            enemy.removeFromParent()
        });
    }
    
    func dropMegaBomb() {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }

        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.3)
        let fadeIn = SKAction.fadeAlpha(to: 0.3 , duration: 0.3)
        let bossfadeIn = SKAction.fadeAlpha(to: 1.0 , duration: 0.3)
        self.bossAlertLabel.text = NSLocalizedString("Bomb", comment: "")
        redBG.run(fadeIn, completion: {
            self.bossAlertLabel.run(bossfadeIn) {
                self.redBG.run(fadeOut, completion: {
                    self.bossAlertLabel.run(fadeOut)
                    for sprite in self.children {
                        if sprite.name == "enemy",
                            let enemy = sprite as? SKSpriteNode {
                            self.destroyEnemy(enemy)
                        }
                    }
                    app.playKill()
                    if self.megaBombCount == 0, let _ = self.bombButton {
                        let fOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                        self.bombButton.run(fOut)
                    }
                })
            }
        })
    }
    
    func applySentinel() {
        let sentinel = SKSpriteNode(imageNamed: "sentinel")
        sentinel.size = CGSize(width: 35, height: 35)
        sentinel.position = CGPoint(x: ship.frame.maxX - 20, y: ship.frame.maxY)
        sentinel.zPosition = 5
        addChild(sentinel)

        self.sentinel = sentinel
    }
    
    func setWeapon(_ weapon: SKSpriteNode) {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }
        
        guard weapon.texture != Textures.megabombtexture, let _ = self.bombButton else {
            app.playNewWeapon()
            megaBombCount += 1
            bombCountLabel.text = "\(megaBombCount)"
            let fIn = SKAction.fadeAlpha(to: 0.8, duration: 0.5)
            self.bombButton.run(fIn)
            UserDefaults.standard.setValue(megaBombCount, forKey: "bombs")
            
            return
        }
        
        guard weapon.texture != Textures.sentineltexture else {
            let sentinel = SKSpriteNode(imageNamed: "sentinel")
            sentinel.size = CGSize(width: 35, height: 35)
            sentinel.position = CGPoint(x: ship.frame.maxX - 20, y: ship.frame.maxY)
            sentinel.zPosition = 5
            addChild(sentinel)
            app.playNewWeapon()
            sentinelDur = 30
            self.sentinel = sentinel
            sentinelLabel.text = "\(sentinelDur)"
            UserDefaults.standard.setValue(sentinelDur, forKey: "sentinelDur")
            
            return
        }
        
        guard weapon.texture != Textures.tomahawktexture, let _ = self.missileButton else {
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.playNewWeapon()
            }
            tomahawkDur = 30
            tomahawkLabel.text = "\(tomahawkDur)"
            let fIn = SKAction.fadeAlpha(to: 0.8, duration: 0.5)
            self.missileButton.run(fIn)
            UserDefaults.standard.setValue(tomahawkDur, forKey: "tomahawkDur")
            
            return
        }
        
        if selectedWeapon.texture?.description != weapon.texture?.description {
            selectedWeapon.texture = weapon.texture
            if selectedWeapon.texture == Textures.spreadtexture {
                weaponType = .Spread
            } else if selectedWeapon.texture == Textures.lightningtexture {
                weaponType = .Lightning
            } else if selectedWeapon.texture == Textures.fireballtexture {
                weaponType = .Fireball
            } else if selectedWeapon.texture == Textures.guntexture {
                weaponType = .Gun
            }
            
            UserDefaults.standard.setValue(weaponType.rawValue, forKey: "weaponType")
            bar.texture = SKTexture(imageNamed: "bar")
            wepCount = 1
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.playNewWeapon()
            }
            UserDefaults.standard.setValue(wepCount, forKey: "weaponCount")
        } else if wepCount < 5 {
            wepCount += 1
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.playLevelUp()
            }
            UserDefaults.standard.setValue(wepCount, forKey: "weaponCount")
            bar.texture = SKTexture(imageNamed: "bar\(wepCount)")
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        let isEnemy = firstBody.categoryBitMask == CollisionBitMask.enemyCategory ||
            secondBody.categoryBitMask == CollisionBitMask.enemyCategory
        let isEnemyFire = firstBody.categoryBitMask == CollisionBitMask.enemyFireCategory ||
            secondBody.categoryBitMask == CollisionBitMask.enemyFireCategory
        let isShip = firstBody.categoryBitMask == CollisionBitMask.shipCategory ||
            secondBody.categoryBitMask == CollisionBitMask.shipCategory
        let isShipFire = firstBody.categoryBitMask == CollisionBitMask.shipFireCategory ||
            secondBody.categoryBitMask == CollisionBitMask.shipFireCategory
        let isWeapon = firstBody.categoryBitMask == CollisionBitMask.weaponCategory ||
            secondBody.categoryBitMask == CollisionBitMask.weaponCategory
        let isBoss = firstBody.categoryBitMask == CollisionBitMask.bossCategory ||
            secondBody.categoryBitMask == CollisionBitMask.bossCategory
        let isBossFire = firstBody.categoryBitMask == CollisionBitMask.bossFireCategory ||
            secondBody.categoryBitMask == CollisionBitMask.bossFireCategory
        let isLife = firstBody.categoryBitMask == CollisionBitMask.lifeCategory ||
            secondBody.categoryBitMask == CollisionBitMask.lifeCategory
        let isCoin = firstBody.categoryBitMask == CollisionBitMask.coinCategory ||
            secondBody.categoryBitMask == CollisionBitMask.coinCategory
        let isShield = firstBody.categoryBitMask == CollisionBitMask.shieldCategory ||
            secondBody.categoryBitMask == CollisionBitMask.shieldCategory
        
        if isShip && isCoin,
            let coin = getNodeForCollision(first: firstBody, second: secondBody, name: "coin") {
            coin.removeFromParent()
            coins += 1
            if coin.accessibilityLabel == "lastcoin" {
                app.playCoins()
                UserDefaults.standard.setValue(coins, forKey: "coins")
            }
        }
        
        if isShip && isLife,
            let life = getNodeForCollision(first: firstBody, second: secondBody, name: "createdlife") {
            app.playNewWeapon()
            life.removeFromParent()
            lives += 1
            app.playLife()
            UserDefaults.standard.setValue(lives, forKey: "lives")
        }
        
        if isShip && isBossFire || isShield && isBossFire,
            let bossFire = getNodeForCollision(first: firstBody, second: secondBody, name: "bossfire") {
            bossFire.removeFromParent()
            if playerHit == false {
                playerHit = true
                app.playHit()
                destroyPlayer()
            }
        }
        
        if isBoss && isShipFire,
            let boss = getNodeForCollision(first: firstBody, second: secondBody, name: "boss") as? SKSpriteNode,
            let shipfire = getNodeForCollision(first: firstBody, second: secondBody, name: "playerfire") {
            shipfire.removeFromParent()
            app.playKill()
            destroyBoss(boss)
        }
        
        if isBoss && isShip || isBoss && isShield {
            if playerHit == false {
                playerHit = true
                destroyPlayer()
            }
        }
        
        if isShip && isWeapon,
            let weapon = getNodeForCollision(first: firstBody, second: secondBody, name: "createdweapon") as? SKSpriteNode {
            weapon.removeFromParent()
            setWeapon(weapon)
        }
        
        if isShip && isEnemyFire || isShield && isEnemyFire,
            let enemyfire = getNodeForCollision(first: firstBody, second: secondBody, name: "enemyfire") {
            enemyfire.removeFromParent()
            if playerHit == false {
                playerHit = true
                app.playHit()
                destroyPlayer()
            }
        }
        
        if isEnemy && isShipFire,
            let enemy = getNodeForCollision(first: firstBody, second: secondBody, name: "enemy") as? SKSpriteNode,
            let shipfire = getNodeForCollision(first: firstBody, second: secondBody, name: "playerfire") as? SKSpriteNode {
            shipfire.removeFromParent()
            destroyEnemy(enemy)
            app.playKill()
        }
        
        if isEnemy && isShip || isEnemy && isShield {
            if playerHit == false {
                playerHit = true
                destroyPlayer()
            }
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}
