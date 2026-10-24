"use strict";

import { NextFunction, Request, Response } from 'express';
import { CartItem } from "../types/types";

export const viewRequestBody = ( request : Request, _response : Response, next : NextFunction ) => {
    console.log( 'Request body', request.body );
    next();
}

type Reshape<T> = ( input : unknown ) => T;

export const modifyRequestBody = <T>( fn : Reshape<T> ) =>
    ( request : Request, _response : Response, next : NextFunction ) => {
        request.body = fn( request.body );
        next();
    }

export const modifyQuery = <T>( fn : Reshape<T> ) =>
    ( request : Request, response : Response, next : NextFunction ) => {
        response.locals.filters = fn( request.query );
        next();
    };

//------------Callbacks

export const reshapeTrimStrings = ( array : string[] ) => array.map( string => string.trim() );

export const reshapeStringSafely = ( string : string ) => typeof string === 'string' && string.trim() !== '' ? string.trim() : null;

export const reshapeSupplier : Reshape<any> = ( input : any ) => {
    const name = input?.supplier_name;

    return {
        supplier_name: typeof name === 'string' ? name.trim() : name
    };
};

export const reshapeCart : Reshape<CartItem[]> = ( input : any ) => {
    // PHP side specific bundler, request is an object
    if ( Array.isArray( input?.items ) ) {
        return input.items.map( ( item : any ) => (
            {
                part_id: Number( item?.part_id ),
                quantity: Number( item?.quantity ),
            }
        ) )
    }

    return Object.entries( input?.quantity ?? {} ).map( ( [ part_id, quantity ] ) => ( {
        part_id: Number( part_id ),
        quantity: Number( quantity ),
    } ) );
}


export const reshapeOrderFilters : Reshape<any> = ( input : any ) => ( {
    supplier_id: reshapeStringSafely( input?.supplier_id ),
    status: reshapeStringSafely( input?.status ),
    from: reshapeStringSafely( input?.from ),
    to: reshapeStringSafely( input?.to ),
} );

export const leftFoldOrder = ( order : any, items : any[] ) => ( {
    ...order,
    items,
    total: items.reduce( ( sum, item ) => sum + Math.round( Number( item.unit_price ) * 100 ) * item.quantity, 0 ) / 100,
} );