//
//  DebugUtils.swift
//  JOJA
//
//  Created by Andrew on 2020/9/3.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

func debug(_ objects: Any..., separator: String = " ", terminator: String = "\n", file:String = #file, line:Int = #line, function:String = #function) {
    #if DEBUG
    print((file).split(separator: "/").last!,line.description + ":",function)
    print("🙋🏼‍♂️Debug info:  \n\t", terminator: "")
    for i in objects{
        print(i, separator: "", terminator: separator)
    }
    print(terminator)
    #endif
}
