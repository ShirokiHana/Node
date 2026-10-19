"use strict";

import { NextFunction, Request, Response } from 'express';
import { ValidationError } from "../lib/errors";

export default ( param = 'id' ) =>
    ( request : Request, _response : Response, next : NextFunction ) => {
        const value = request.params[ param ];

        if ( typeof value !== "string" || !/^\d+$/.test( value ) || Number( value ) < 1 )
            throw new ValidationError( `Invalid ${ param }` );
    next();
}