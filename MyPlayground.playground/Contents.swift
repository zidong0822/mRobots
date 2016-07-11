//: Playground - noun: a place where people can play


//var pos = [Bool](count: 72, repeatedValue: false)
//
//
//func getGrid(width:Int,height:Int){
//
//    let gridWidth = 40
//    let gridHeight = 60
//    
//    let availableGrids = NSMutableArray()
//    for i in 0..<9-height+1 {
//   
//        for j in 0 ..< 8-width+1{
//        
//        var availableGrid = true
//    
//        for px in 0..<width{
//        
//            for py in 0..<height{
//                
//                if (pos[i+px+(j+py)*8]){
//                   
//                    availableGrid = false
//                    break;
//                }
//            }
//            if (!availableGrid){
//                print(i,j,"被占用")
//                break;
//            }
//        }
//        if (availableGrid){
//          
//          
//            let point = CGPointMake(CGFloat(i),CGFloat(j))
//            let pointObj = NSValue(point: point)
//            availableGrids.addObject(pointObj)
//            
//            
//            }
//   
//    }
//}
//    
//    print(availableGrids)
//    
////    for value in availableGrids{
////    
////        let point = value.pointValue
////        let xx = Int(point.x)*gridWidth+width*gridWidth/2
////        let yy = Int(point.y)*gridHeight+height*gridHeight/2
////        
////    }
//}
//
//
//
//
//
////getGrid(1, height:1)
////pos[0]=true
////getGrid(2, height: 1)



