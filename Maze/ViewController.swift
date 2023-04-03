//
//  ViewController.swift
//  Maze
//
//  Created by よっちゃん on 2023/04/02.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var playerView: UIView!
    var playerMotionManager: CMMotionManager!
    var speedX: Double = 0.0
    var speedY: Double = 0.0
    
    let maze = [
        [1,0,0,0,1,0],
        [1,0,1,0,1,0],
        [3,0,1,0,1,0],
        [1,1,1,0,0,0],
        [1,0,0,1,1,0],
        [0,0,1,0,0,0],
        [0,1,1,0,1,0],
        [0,0,0,0,1,1],
        [0,1,1,0,0,0],
        [0,0,1,1,1,2],
    ]
    
    let screenSize = UIScreen.main.bounds.size
    
    
    var startView: UIView!
    var goalView: UIView!
    var wallRectArray = [CGRect]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let cellWidth = screenSize.width / CGFloat(maze[0].count)
        let cellHeight = screenSize.height / CGFloat(maze.count)
        let cellOffsetX = cellWidth / 2
        let cellOfsetY = cellHeight / 2
        
        for y in 0 ..< maze.count {
            for x in 0 ..< maze[y].count {
                switch maze[y][x] {
                case 1: //ゲームオーバーのマス
                    let wallView = createView(x: x, y: y, width: cellWidth, height: cellHeight, offsetX: cellOffsetX,  offsetY: cellOfsetY)
                    wallView.backgroundColor = UIColor.black
                    view.addSubview(wallView)
                    wallRectArray.append(wallView.frame)
                    
                case 2: //スタート地点
                    startView = createView(x: x, y: y, width: cellWidth, height: cellHeight, offsetX: cellOffsetX, offsetY: cellOfsetY)
                    startView.backgroundColor =  UIColor.green
                    view.addSubview(startView)
                    
                case 3: //ゴール
                    goalView = createView(x: x, y: y, width: cellWidth, height: cellHeight, offsetX: cellOffsetX, offsetY: cellOfsetY)
                    goalView.backgroundColor = UIColor.red
                    view.addSubview(goalView)
                
                    
                default:
                    break
                }
            }
            
        }
            //olayerView 生成
        playerView = UIView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight / 6))
        playerView.center = startView.center
        playerView.backgroundColor = UIColor.gray
        view.addSubview(playerView)
        
        //MotionManager 生成
        playerMotionManager = CMMotionManager()
        playerMotionManager.accelerometerUpdateInterval = 0.02
        
        startAccelemeter()
        
        
        func createView(x: Int, y: Int, width: CGFloat, height: CGFloat, offsetX: CGFloat, offsetY: CGFloat) ->
        UIView {
            let rect = CGRect(x: 0, y: 0, width: width, height: height)
            let view = UIView(frame: rect)
            
            let center = CGPoint(x: offsetX + width * CGFloat(x), y: offsetY + height * CGFloat(y))
            
            view.center = center
            
            return view
        }
    }
    
}
