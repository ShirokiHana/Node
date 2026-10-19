"use strict";

import { NextFunction, Request, Response } from 'express';

export const requireSupplier = async ( request : Request, response : Response, next : NextFunction ) => {
    try {
        const id : number | null = Number ( request.body?.supplier_id ?? request.params.supplier_id );

        console.log( 'Body rS: ', request.body );
        console.log( 'Body rS id: ', id );

        if ( !Number.isInteger( id ) || id < 1 )
            return response.redirect( 303, '/restock/' );
        next();
    } catch ( error ) {
        next( error );
    }
}