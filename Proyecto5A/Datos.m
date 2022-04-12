//
//  Datos.m
//  Proyecto5A
//
//  Created by Mac02 on 12/04/22.
//

#import "Datos.h"

@implementation Datos

+ (id)sharedDatos
{
    static id datos;
    
    if (datos == nil)
        datos = [[self alloc] init];
    
    return  datos;
}
@end
