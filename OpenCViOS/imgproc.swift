//
//  OpenCV+imgproc.swift
//  LibrarianEyes
//
//  Created by Kyle Alan Hale on 2/23/15.
//  Copyright (c) 2015 Kyle Alan Hale. All rights reserved.
//

import UIKit

public func boundingRect(points: [CGPoint]) -> CGRect {
    return OpenCV.boundingRectForPoints(points.map { NSValue(CGPoint: $0) })
}
public func boundingRect(points: Mat!) -> CGRect {
    return OpenCV.boundingRectForPointsInMat(points.bridgedMat)
}

public func countNonZero(src: Mat!) -> Int {
    return OpenCV.countNonZeroForImage(src.bridgedMat)
}

public func cvtColor(src: Mat!, inout dst: Mat!, code: ColorConversionCode, dstCn: Int = 0) {
    var newDst: OpenCVMat?
    
    OpenCV.cvtColorWithSrc(src.bridgedMat, dst: &newDst, code: code.rawValue, dstCn: dstCn)
    
    dst = Mat(bridgedMat: newDst)
}

public func drawContours(image: Mat!, contours: [Contour], contourIdx: Int, color: Scalar, thickness: Int = 1, lineType: LineType = .Connected8, hierarchy: [Vec4i]? = nil, maxLevel: Int = Int(Int32.max), offset: CGPoint = CGPointZero) {
    let wrappedContours = contours.map { $0.map { NSValue(CGPoint: $0) } }
    
    OpenCV.drawContours(image.bridgedMat, contours: wrappedContours, contourIdx: contourIdx, color: color, thickness: thickness, lineType: lineType.rawValue, hierarchy: hierarchy, maxLevel: maxLevel, offset: offset)
}

public func findContours(image: Mat!, inout contours: [Contour]!, inout hierarchy: [Vec4i]!, mode: RetrievalMode, method: ContourApproximationMode, offset: CGPoint = CGPointZero) {
    var newContours: NSArray?
    var newHierarchy: NSArray?
    
    OpenCV.findContoursWithImage(image.bridgedMat, contours: &newContours, hierarchy: &newHierarchy, mode: mode.rawValue, method: method.rawValue, offset: offset)
    
    if let newContours = newContours as? [[NSValue]] {
        contours = newContours.map { $0.map { $0.CGPointValue() } }
    }
    if let newHierarchy = newHierarchy as? [[NSNumber]] {
        hierarchy = newHierarchy.map { $0.map { $0.integerValue } }
    }
}

public func getStructuringElement(shape: MorphShape, ksize: CGSize, anchor: CGPoint = CGPoint(x: -1, y: -1)) -> Mat! {
    return Mat(bridgedMat: OpenCV.getStructuringElementWithShape(shape.rawValue, ksize: ksize, anchor: anchor))
}

public func morphologyEx(src: Mat!, inout dst: Mat!, op: MorphType, kernel: Mat!, anchor: CGPoint = CGPoint(x: -1, y: -1), iterations: Int = 1, borderType: BorderType = .Constant, borderValue: Scalar? = nil) {
    var newDst: OpenCVMat?
    
    OpenCV.morphologyExWithSrc(src.bridgedMat, dst: &newDst, op: op.rawValue, kernel: kernel.bridgedMat, anchor: anchor, iterations: iterations, borderType: borderType.rawValue, borderValue: borderValue)
    
    dst = Mat(bridgedMat: newDst)
}

public func pyrDown(src: Mat!, inout dst: Mat!, dstsize: CGSize = CGSizeZero, borderType: BorderType = .Reflect101) {
    var newDst: OpenCVMat?
    
    OpenCV.pyrDownWithSrc(src.bridgedMat, dst: &newDst, dstsize: dstsize, borderType: borderType.rawValue)
    
    dst = Mat(bridgedMat: newDst)
}

public func rectangle(img: Mat!, rec: CGRect, color: Scalar, thickness: Int = 1, lineType: LineType = .Connected8, shift: Int = 0) {
    OpenCV.rectangleInImage(img.bridgedMat, rec: rec, color: color, thickness: thickness, lineType: lineType.rawValue, shift: shift)
}

public func threshold(src: Mat!, inout dst: Mat!, thresh: Double, maxval: Double, type: ThresholdType) -> Double {
    var newDst: OpenCVMat?
    
    let newThresh = OpenCV.thresholdWithSrc(src.bridgedMat, dst: &newDst, thresh: CGFloat(thresh), maxval: CGFloat(maxval), type: Int(type.rawValue))
    
    dst = Mat(bridgedMat: newDst)
    
    return Double(newThresh)
}

public typealias Scalar = [Double]
public typealias Contour = [CGPoint]
public typealias Vec4i = [Int]

public var Filled = -1

public enum BorderType: Int {
    case Constant = 0
    case Replicate = 1
    case Reflect = 2
    case Wrap = 3
    case Reflect101 = 4
    case Transparent = 5
    case Isolated = 16
    
    public static var Default: BorderType { return .Reflect101 }
}

/** Constants for color conversion */
public enum ColorConversionCode: Int {
    case BGR2BGRA = 0
    public static var RGB2RGBA: ColorConversionCode { return .BGR2BGRA }
    
    case BGRA2BGR    = 1
    public static var RGBA2RGB: ColorConversionCode { return .BGRA2BGR }
    
    case BGR2RGBA    = 2
    public static var RGB2BGRA: ColorConversionCode { return .BGR2RGBA }
    
    case RGBA2BGR    = 3
    public static var BGRA2RGB: ColorConversionCode { return .RGBA2BGR }
    
    case BGR2RGB     = 4
    public static var RGB2BGR: ColorConversionCode { return .BGR2RGB }
    
    case BGRA2RGBA   = 5
    public static var RGBA2BGRA: ColorConversionCode { return .BGRA2RGBA }
    
    case BGR2GRAY    = 6
    case RGB2GRAY    = 7
    case GRAY2BGR    = 8
    public static var GRAY2RGB: ColorConversionCode { return .GRAY2BGR }
    case GRAY2BGRA   = 9
    public static var GRAY2RGBA: ColorConversionCode { return .GRAY2BGRA }
    case BGRA2GRAY   = 10
    case RGBA2GRAY   = 11
    
    case BGR2BGR565  = 12
    case RGB2BGR565  = 13
    case BGR5652BGR  = 14
    case BGR5652RGB  = 15
    case BGRA2BGR565 = 16
    case RGBA2BGR565 = 17
    case BGR5652BGRA = 18
    case BGR5652RGBA = 19
    
    case GRAY2BGR565 = 20
    case BGR5652GRAY = 21
    
    case BGR2BGR555  = 22
    case RGB2BGR555  = 23
    case BGR5552BGR  = 24
    case BGR5552RGB  = 25
    case BGRA2BGR555 = 26
    case RGBA2BGR555 = 27
    case BGR5552BGRA = 28
    case BGR5552RGBA = 29
    
    case GRAY2BGR555 = 30
    case BGR5552GRAY = 31
    
    case BGR2XYZ     = 32
    case RGB2XYZ     = 33
    case XYZ2BGR     = 34
    case XYZ2RGB     = 35
    
    case BGR2YCrCb   = 36
    case RGB2YCrCb   = 37
    case YCrCb2BGR   = 38
    case YCrCb2RGB   = 39
    
    case BGR2HSV     = 40
    case RGB2HSV     = 41
    
    case BGR2Lab     = 44
    case RGB2Lab     = 45
    
    case BayerBG2BGR = 46
    case BayerGB2BGR = 47
    case BayerRG2BGR = 48
    case BayerGR2BGR = 49
    
    public static var BayerBG2RGB: ColorConversionCode { return .BayerRG2BGR }
    public static var BayerGB2RGB: ColorConversionCode { return .BayerGR2BGR }
    public static var BayerRG2RGB: ColorConversionCode { return .BayerBG2BGR }
    public static var BayerGR2RGB: ColorConversionCode { return .BayerGB2BGR }
    
    case BGR2Luv     = 50
    case RGB2Luv     = 51
    case BGR2HLS     = 52
    case RGB2HLS     = 53
    
    case HSV2BGR     = 54
    case HSV2RGB     = 55
    
    case Lab2BGR     = 56
    case Lab2RGB     = 57
    case Luv2BGR     = 58
    case Luv2RGB     = 59
    case HLS2BGR     = 60
    case HLS2RGB     = 61
    
    case BayerBG2BGR_VNG = 62
    case BayerGB2BGR_VNG = 63
    case BayerRG2BGR_VNG = 64
    case BayerGR2BGR_VNG = 65
    
    public static var BayerBG2RGB_VNG: ColorConversionCode { return .BayerRG2BGR_VNG }
    public static var BayerGB2RGB_VNG: ColorConversionCode { return .BayerGR2BGR_VNG }
    public static var BayerRG2RGB_VNG: ColorConversionCode { return .BayerBG2BGR_VNG }
    public static var BayerGR2RGB_VNG: ColorConversionCode { return .BayerGB2BGR_VNG }
    
    case BGR2HSV_FULL = 66
    case RGB2HSV_FULL = 67
    case BGR2HLS_FULL = 68
    case RGB2HLS_FULL = 69
    
    case HSV2BGR_FULL = 70
    case HSV2RGB_FULL = 71
    case HLS2BGR_FULL = 72
    case HLS2RGB_FULL = 73
    
    case LBGR2Lab     = 74
    case LRGB2Lab     = 75
    case LBGR2Luv     = 76
    case LRGB2Luv     = 77
    
    case Lab2LBGR     = 78
    case Lab2LRGB     = 79
    case Luv2LBGR     = 80
    case Luv2LRGB     = 81
    
    case BGR2YUV      = 82
    case RGB2YUV      = 83
    case YUV2BGR      = 84
    case YUV2RGB      = 85
    
    case BayerBG2GRAY = 86
    case BayerGB2GRAY = 87
    case BayerRG2GRAY = 88
    case BayerGR2GRAY = 89
    
    //YUV 4:2:0 formats family
    case YUV2RGB_NV12 = 90
    case YUV2BGR_NV12 = 91
    case YUV2RGB_NV21 = 92
    case YUV2BGR_NV21 = 93
    public static var YUV420sp2RGB: ColorConversionCode { return .YUV2RGB_NV21 }
    public static var YUV420sp2BGR: ColorConversionCode { return .YUV2BGR_NV21 }
    
    case YUV2RGBA_NV12 = 94
    case YUV2BGRA_NV12 = 95
    case YUV2RGBA_NV21 = 96
    case YUV2BGRA_NV21 = 97
    public static var YUV420sp2RGBA: ColorConversionCode { return .YUV2RGBA_NV21 }
    public static var YUV420sp2BGRA: ColorConversionCode { return .YUV2BGRA_NV21 }
    
    case YUV2RGB_YV12 = 98
    case YUV2BGR_YV12 = 99
    case YUV2RGB_IYUV = 100
    case YUV2BGR_IYUV = 101
    public static var YUV2RGB_I420: ColorConversionCode { return .YUV2RGB_IYUV }
    public static var YUV2BGR_I420: ColorConversionCode { return .YUV2BGR_IYUV }
    public static var YUV420p2RGB: ColorConversionCode { return .YUV2RGB_YV12 }
    public static var YUV420p2BGR: ColorConversionCode { return .YUV2BGR_YV12 }
    
    case YUV2RGBA_YV12 = 102
    case YUV2BGRA_YV12 = 103
    case YUV2RGBA_IYUV = 104
    case YUV2BGRA_IYUV = 105
    public static var YUV2RGBA_I420: ColorConversionCode { return .YUV2RGBA_IYUV }
    public static var YUV2BGRA_I420: ColorConversionCode { return .YUV2BGRA_IYUV }
    public static var YUV420p2RGBA: ColorConversionCode { return .YUV2RGBA_YV12 }
    public static var YUV420p2BGRA: ColorConversionCode { return .YUV2BGRA_YV12 }
    
    case YUV2GRAY_420 = 106
    public static var YUV2GRAY_NV21: ColorConversionCode { return .YUV2GRAY_420 }
    public static var YUV2GRAY_NV12: ColorConversionCode { return .YUV2GRAY_420 }
    public static var YUV2GRAY_YV12: ColorConversionCode { return .YUV2GRAY_420 }
    public static var YUV2GRAY_IYUV: ColorConversionCode { return .YUV2GRAY_420 }
    public static var YUV2GRAY_I420: ColorConversionCode { return .YUV2GRAY_420 }
    public static var YUV420sp2GRAY: ColorConversionCode { return .YUV2GRAY_420 }
    public static var YUV420p2GRAY: ColorConversionCode { return .YUV2GRAY_420 }
    
    //YUV 4:2:2 formats family
    case YUV2RGB_UYVY = 107
    case YUV2BGR_UYVY = 108
    //YUV2RGB_VYUY = 109
    //YUV2BGR_VYUY = 110
    public static var YUV2RGB_Y422: ColorConversionCode { return .YUV2RGB_UYVY }
    public static var YUV2BGR_Y422: ColorConversionCode { return .YUV2BGR_UYVY }
    public static var YUV2RGB_UYNV: ColorConversionCode { return .YUV2RGB_UYVY }
    public static var YUV2BGR_UYNV: ColorConversionCode { return .YUV2BGR_UYVY }
    
    case YUV2RGBA_UYVY = 111
    case YUV2BGRA_UYVY = 112
    //YUV2RGBA_VYUY = 113
    //YUV2BGRA_VYUY = 114
    public static var YUV2RGBA_Y422: ColorConversionCode { return .YUV2RGBA_UYVY }
    public static var YUV2BGRA_Y422: ColorConversionCode { return .YUV2BGRA_UYVY }
    public static var YUV2RGBA_UYNV: ColorConversionCode { return .YUV2RGBA_UYVY }
    public static var YUV2BGRA_UYNV: ColorConversionCode { return .YUV2BGRA_UYVY }
    
    case YUV2RGB_YUY2 = 115
    case YUV2BGR_YUY2 = 116
    case YUV2RGB_YVYU = 117
    case YUV2BGR_YVYU = 118
    public static var YUV2RGB_YUYV: ColorConversionCode { return .YUV2RGB_YUY2 }
    public static var YUV2BGR_YUYV: ColorConversionCode { return .YUV2BGR_YUY2 }
    public static var YUV2RGB_YUNV: ColorConversionCode { return .YUV2RGB_YUY2 }
    public static var YUV2BGR_YUNV: ColorConversionCode { return .YUV2BGR_YUY2 }
    
    case YUV2RGBA_YUY2 = 119
    case YUV2BGRA_YUY2 = 120
    case YUV2RGBA_YVYU = 121
    case YUV2BGRA_YVYU = 122
    public static var YUV2RGBA_YUYV: ColorConversionCode { return .YUV2RGBA_YUY2 }
    public static var YUV2BGRA_YUYV: ColorConversionCode { return .YUV2BGRA_YUY2 }
    public static var YUV2RGBA_YUNV: ColorConversionCode { return .YUV2RGBA_YUY2 }
    public static var YUV2BGRA_YUNV: ColorConversionCode { return .YUV2BGRA_YUY2 }
    
    case YUV2GRAY_UYVY = 123
    case YUV2GRAY_YUY2 = 124
    //YUV2GRAY_VYUY = YUV2GRAY_UYVY
    public static var YUV2GRAY_Y422: ColorConversionCode { return .YUV2GRAY_UYVY }
    public static var YUV2GRAY_UYNV: ColorConversionCode { return .YUV2GRAY_UYVY }
    public static var YUV2GRAY_YVYU: ColorConversionCode { return .YUV2GRAY_YUY2 }
    public static var YUV2GRAY_YUYV: ColorConversionCode { return .YUV2GRAY_YUY2 }
    public static var YUV2GRAY_YUNV: ColorConversionCode { return .YUV2GRAY_YUY2 }
    
    // alpha premultiplication
    case RGBA2mRGBA = 125
    case mRGBA2RGBA = 126
    
    case RGB2YUV_I420 = 127
    case BGR2YUV_I420 = 128
    public static var RGB2YUV_IYUV: ColorConversionCode { return .RGB2YUV_I420 }
    public static var BGR2YUV_IYUV: ColorConversionCode { return .BGR2YUV_I420 }
    
    case RGBA2YUV_I420 = 129
    case BGRA2YUV_I420 = 130
    public static var RGBA2YUV_IYUV: ColorConversionCode { return .RGBA2YUV_I420 }
    public static var BGRA2YUV_IYUV: ColorConversionCode { return .BGRA2YUV_I420 }
    case RGB2YUV_YV12  = 131
    case BGR2YUV_YV12  = 132
    case RGBA2YUV_YV12 = 133
    case BGRA2YUV_YV12 = 134
    
    // Edge-Aware Demosaicing
    case BayerBG2BGR_EA = 135
    case BayerGB2BGR_EA = 136
    case BayerRG2BGR_EA = 137
    case BayerGR2BGR_EA = 138
    
    public static var BayerBG2RGB_EA: ColorConversionCode { return .BayerRG2BGR_EA }
    public static var BayerGB2RGB_EA: ColorConversionCode { return .BayerGR2BGR_EA }
    public static var BayerRG2RGB_EA: ColorConversionCode { return .BayerBG2BGR_EA }
    public static var BayerGR2RGB_EA: ColorConversionCode { return .BayerGB2BGR_EA }
    
    case COLORCVT_MAX  = 139
}

public struct ThresholdType : RawOptionSetType, BooleanType {
    private let value: UInt = 0
    public init(nilLiteral: ()) {}
    public init(rawValue value: UInt) { self.value = value }
    public var boolValue: Bool { return value != 0 }
    public var rawValue: UInt { return value }
    public static var allZeros: ThresholdType { return self(rawValue: 0) }
    
    public static var Binary: ThresholdType     { return self(rawValue: 0) }
    public static var BinaryInv: ThresholdType     { return self(rawValue: 1) }
    public static var Trunc: ThresholdType     { return self(rawValue: 2) }
    public static var ToZero: ThresholdType     { return self(rawValue: 3) }
    public static var ToZeroInv: ThresholdType     { return self(rawValue: 4) }
    
    public static var Mask: ThresholdType     { return self(rawValue: 7) }
    //!< flag, use Otsu algorithm to choose the optimal threshold value
    public static var Otsu: ThresholdType     { return self(rawValue: 8) }
    //!< flag, use Triangle algorithm to choose the optimal threshold value
    public static var Triangle: ThresholdType     { return self(rawValue: 16) }
    // ...
}

//! type of morphological operation
public  enum MorphType: Int {
    case Erode    = 0, //!< see cv::erode
    Dilate   = 1, //!< see cv::dilate
    Open     = 2, //!< an opening operation
    //!< \f[\texttt{dst} = \mathrm{open} ( \texttt{src} , \texttt{element} )= \mathrm{dilate} ( \mathrm{erode} ( \texttt{src} , \texttt{element} ))\f]
    Close    = 3, //!< a closing operation
    //!< \f[\texttt{dst} = \mathrm{close} ( \texttt{src} , \texttt{element} )= \mathrm{erode} ( \mathrm{dilate} ( \texttt{src} , \texttt{element} ))\f]
    Gradient = 4, //!< a morphological gradient
    //!< \f[\texttt{dst} = \mathrm{morph\_grad} ( \texttt{src} , \texttt{element} )= \mathrm{dilate} ( \texttt{src} , \texttt{element} )- \mathrm{erode} ( \texttt{src} , \texttt{element} )\f]
    TopHat   = 5, //!< "top hat"
    //!< \f[\texttt{dst} = \mathrm{tophat} ( \texttt{src} , \texttt{element} )= \texttt{src} - \mathrm{open} ( \texttt{src} , \texttt{element} )\f]
    BlackHat = 6  //!< "black hat"
    //!< \f[\texttt{dst} = \mathrm{blackhat} ( \texttt{src} , \texttt{element} )= \mathrm{close} ( \texttt{src} , \texttt{element} )- \texttt{src}\f]
}

public enum MorphShape: Int {
    case Rect    = 0, //!< a rectangular structuring element:  \f[E_{ij}=1\f]
    Cross   = 1, //!< a cross-shaped structuring element:
    //!< \f[E_{ij} =  \fork{1}{if i=\texttt{anchor.y} or j=\texttt{anchor.x}}{0}{otherwise}\f]
    Ellipse = 2 //!< an elliptic structuring element, that is, a filled ellipse inscribed
    //!< into the rectangle Rect(0, 0, esize.width, 0.esize.height)
}

//! mode of the contour retrieval algorithm
public enum RetrievalMode: Int {
    /** retrieves only the extreme outer contours. It sets `hierarchy[i][2]=hierarchy[i][3]=-1` for
    all the contours. */
    case External  = 0,
    /** retrieves all of the contours without establishing any hierarchical relationships. */
    List      = 1,
    /** retrieves all of the contours and organizes them into a two-level hierarchy. At the top
    level, there are external boundaries of the components. At the second level, there are
    boundaries of the holes. If there is another contour inside a hole of a connected component, it
    is still put at the top level. */
    CComp     = 2,
    /** retrieves all of the contours and reconstructs a full hierarchy of nested contours.*/
    Tree      = 3,
    Floodfill = 4 //!<
}

//! the contour approximation algorithm
public enum ContourApproximationMode: Int {
    /** stores absolutely all the contour points. That is, any 2 subsequent points (x1,y1) and
    (x2,y2) of the contour will be either horizontal, vertical or diagonal neighbors, that is,
    max(abs(x1-x2),abs(y2-y1))==1. */
    case None      = 1,
    /** compresses horizontal, vertical, and diagonal segments and leaves only their end points.
    For example, an up-right rectangular contour is encoded with 4 points. */
    Simple    = 2,
    /** applies one of the flavors of the Teh-Chin chain approximation algorithm @cite TehChin89 */
    TC89_L1   = 3,
    /** applies one of the flavors of the Teh-Chin chain approximation algorithm @cite TehChin89 */
    TC89_KCOS = 4
}

//! type of line
public enum LineType: Int {
    case Filled  = -1,
    Connected4  = 4, //!< 4-connected line
    Connected8  = 8, //!< 8-connected line
    AntiAliased = 16 //!< antialiased line
}
