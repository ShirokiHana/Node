"use strict";

import { NextFunction, Request, Response } from 'express';
import { CartItem } from "../types/types";
import {ValidationError} from "../lib/errors";

    const isPositiveInt = ( value : unknown ) =>
        // reject decimals
        Number.isSafeInteger( Number( value ) ) && Number( value ) >= 1;

    const isDate = ( value : string ) =>
        /^\d{4}-\d{2}-\d{2}$/.test( value ) && !Number.isNaN( Date.parse( value ) );

    const STATUSES = [ 'pending', 'received', 'cancelled' ];

// TODO: Ensure items have positive number quantities

    export const validateCart = (
        request : Request,
        _response : Response,
        next : NextFunction
        ) => {
        const cart : CartItem[] = request.body.items;

        if ( !Array.isArray( cart ) || cart.length === 0 )
            throw new ValidationError( 'Cart is empty' );

        const valid = cart.every(
            ( item : any ) =>
                isPositiveInt( item?.part_id ) &&
                isPositiveInt( item?.quantity )
        )

        if ( !valid )
            throw new ValidationError( 'Cart has invalid items' );

        next();
    }

    export const validateSupplier = (
        request : Request,
        _response : Response,
        next : NextFunction
        ) => {
        const { supplier_name } = request.body;

        if ( typeof supplier_name !== 'string' || supplier_name === '' )
            throw new ValidationError( 'Invalid supplier name' );

        next();
    };

    export const validateOrderFilters = ( _request : Request, response : Response, next : NextFunction ) => {
        const { supplier_id, status, from, to } = response.locals.filters;

        if ( supplier_id !== null && !isPositiveInt( supplier_id ) )
            throw new ValidationError( 'Invalid supplier_id' );
        if ( status !== null && !STATUSES.includes( status ) )
            throw new ValidationError( 'Invalid status' );
        if ( from !== null && !isDate( from ) )
            throw new ValidationError( 'Invalid from date (use YYYY-MM-DD)' );
        if ( to !== null && !isDate( to ) )
            throw new ValidationError( 'Invalid to date (use YYYY-MM-DD)' );
        if ( from !== null && to !== null && from > to )
            throw new ValidationError( 'from must not be after to' );

        next();
    };

    export const validateOrderStatus = ( request : Request, _response : Response, next : NextFunction ) => {
        const { status } = request.body ?? {};

        if ( typeof status !== 'string' || !STATUSES.includes( status ) )
            throw new ValidationError( 'Invalid status' );

        next();
    };