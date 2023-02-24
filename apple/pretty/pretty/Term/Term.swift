//
//  Term.swift
//  pretty
//
//  Created by Lilly Cham on 23/02/2023.
//

import Foundation
import Darwin
import System

enum PTYErr: Error {
  case Generic(desc: String = "Failed to acquire PTY")
}

func posixOpenPt(_ flags: Int32) -> Result<Int32, Errno> {
  let fd = posix_openpt(flags)
  
  guard fd != -1 else {
    return .failure(Errno(rawValue: errno))
  }
  
  return .success(fd)
}

func unlockPt(_ fd: Int32) -> Result<Int32, Errno> {
  let res = unlockpt(fd)
  
  guard res != -1 else {
    return .failure(Errno(rawValue: errno))
  }
  
  return .success(res)
}

func grantPt(_ fd: Int32) -> Result<Int32, Errno> {
  let res = grantpt(fd)
  
  guard res != -1 else {
    return .failure(Errno(rawValue: errno))
  }
  
  return .success(res)
}

func fdClone(from old: Int32) -> Result<Int32, Errno> {
  let res = dup(old)
  
  guard res != -1 else {
    return .failure(Errno(rawValue: errno))
  }
  
  return .success(res)
}

func ttyInit(line: Int = #line, file: String = #fileID) -> (FileHandle, FileHandle)? {
  let fd = posixOpenPt(O_RDWR)
  let fd_: Int32
  
  switch fd {
  case .success(let x): fd_ = x
  case .failure(let err): fatalError("when acquiring a PTY: \(err)")
  }
  
  guard let childPath = URL(string: String(cString: ptsname(fd_))) else {
    fatalError("Failed to instantiate child path on \(file):\(line)")
  }
  
//  guard let child = try? FileHandle(forUpdating: childPath) else {
//    fatalError("Failed to instantiate child fd on \(file):\(line)")
//  }
  
  logger.info("path: \(childPath)")
  
  let parent = FileHandle(fileDescriptor: fd_)
  let child: FileHandle
  switch fdClone(from: fd_) {
  case .success(let x): child = FileHandle(fileDescriptor: x)
  case.failure(let err): fatalError("\(err)")
  }
  return (parent, child)
}
