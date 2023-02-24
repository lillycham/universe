//
//  conversion_routines.m
//  
//
//  Created by Lilly Cham on 26/01/2023.
//

@import Foundation;

double ncnToDouble(id num) {
  NSNumber *ns_num = (NSNumber *)num;
  return ns_num.floatValue;
}
