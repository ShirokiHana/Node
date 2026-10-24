"use strict";

import { NextFunction, Request, Response } from 'express';
import {ConflictError, NotFoundError, ValidationError} from "./errors";

const statusCode = ( error : unknown ) => {
    if ( error instanceof ValidationError )
        return 400;

    if ( error instanceof NotFoundError )
        return 404;

    if ( error instanceof ConflictError )
        return 409;

    if ( error instanceof ValidationError )
        return 400;

    return 500;
}

export default (
    error : { message: string },
    _request : Request,
    response : Response,
    next : NextFunction
    ) => {
    if ( response.headersSent )
        return next( error );

    const status = statusCode( error );
    response.status( status ).send(
      status === 500
        ? 'Internal Server error'
        : error.message
    );
};