//
//  Encrypt.swift
//  sc
//
//  Created by Mac on 2018/8/15.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import Foundation

extension String {
    
    //sha1加密算法
    func getSha1() -> String {
        return self;
    }
    
    //md5加密算法
    func md5() -> String {
        let cStrl = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }

}
