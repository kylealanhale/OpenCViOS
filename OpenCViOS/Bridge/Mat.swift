//
//  Mat.swift
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/22/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

import Foundation

extension Mat {
    convenience init(rows: Int, cols: Int, type: MatType, data: UnsafeMutablePointer<Void>, step: Int = 0) {
        self.init(rows: rows, cols: cols, type: type.rawValue, data: data, step: step)
    }
    var step: MatStep {
        return MatStep(mat: self)
    }
}

struct MatStep {
    let mat: Mat
    subscript(index: Int) -> Int {
        return mat.stepAtIndex(index)
    }
}

enum MatType: Int {
    case CV_USRTYPE1
    case CV_8U, CV_8UC1, CV_8UC2, CV_8UC3, CV_8UC4
    case CV_8S, CV_8SC1, CV_8SC2, CV_8SC3, CV_8SC4
    case CV_16U, CV_16UC1, CV_16UC2, CV_16UC3, CV_16UC4
    case CV_16S, CV_16SC1, CV_16SC2, CV_16SC3, CV_16SC4
    case CV_32S, CV_32SC1, CV_32SC2, CV_32SC3, CV_32SC4
    case CV_32F, CV_32FC1, CV_32FC2, CV_32FC3, CV_32FC4
    case CV_64F, CV_64FC1, CV_64FC2, CV_64FC3, CV_64FC4
    
    var rawValue: Int {
        switch self {
        case .CV_8U:
            return 0
        case .CV_8S:
            return 1
        case .CV_16U:
            return 2
        case .CV_16S:
            return 3
        case .CV_32S:
            return 4
        case .CV_32F:
            return 5
        case .CV_64F:
            return 6
        case .CV_USRTYPE1:
            return 7
        case .CV_8UC1:
            return MatType.makeType(.CV_8U, 1)
        case .CV_8UC2:
            return MatType.makeType(.CV_8U, 2)
        case .CV_8UC3:
            return MatType.makeType(.CV_8U, 3)
        case .CV_8UC4:
            return MatType.makeType(.CV_8U, 4)
        case .CV_8SC1:
            return MatType.makeType(.CV_8S, 1)
        case .CV_8SC2:
            return MatType.makeType(.CV_8S, 2)
        case .CV_8SC3:
            return MatType.makeType(.CV_8S, 3)
        case .CV_8SC4:
            return MatType.makeType(.CV_8S, 4)
        case .CV_16UC1:
            return MatType.makeType(.CV_16U, 1)
        case .CV_16UC2:
            return MatType.makeType(.CV_16U, 2)
        case .CV_16UC3:
            return MatType.makeType(.CV_16U, 3)
        case .CV_16UC4:
            return MatType.makeType(.CV_16U, 4)
        case .CV_16SC1:
            return MatType.makeType(.CV_16S, 1)
        case .CV_16SC2:
            return MatType.makeType(.CV_16S, 2)
        case .CV_16SC3:
            return MatType.makeType(.CV_16S, 3)
        case .CV_16SC4:
            return MatType.makeType(.CV_16S, 4)
        case .CV_32SC1:
            return MatType.makeType(.CV_32S, 1)
        case .CV_32SC2:
            return MatType.makeType(.CV_32S, 2)
        case .CV_32SC3:
            return MatType.makeType(.CV_32S, 3)
        case .CV_32SC4:
            return MatType.makeType(.CV_32S, 4)
        case .CV_32FC1:
            return MatType.makeType(.CV_32F, 1)
        case .CV_32FC2:
            return MatType.makeType(.CV_32F, 2)
        case .CV_32FC3:
            return MatType.makeType(.CV_32F, 3)
        case .CV_32FC4:
            return MatType.makeType(.CV_32F, 4)
        case .CV_64FC1:
            return MatType.makeType(.CV_64F, 1)
        case .CV_64FC2:
            return MatType.makeType(.CV_64F, 2)
        case .CV_64FC3:
            return MatType.makeType(.CV_64F, 3)
        case .CV_64FC4:
            return MatType.makeType(.CV_64F, 4)
        }
    }
    static func makeType(type: MatType, _ cn: Int) -> Int {
        let max = 512
        let shift = 3
        let depthMax = 1 << shift
        let depthMask = depthMax - 1
        
        return (type.rawValue & depthMask) + ((cn - 1) << shift)
    }
}
