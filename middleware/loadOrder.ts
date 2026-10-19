"use strict";

import { NextFunction, Request, Response } from 'express';
import { findOrder, findOrderItems } from "../routes/order";
import { leftFoldOrder } from "./reshapeData";

export default async ( request : Request, response : Response, next : NextFunction ) => {
        const id = String( request.params.id );
        const [ order, items ] = await Promise.all( [
                findOrder( id ),
                findOrderItems( id )
            ]
        );

        response.locals.order = leftFoldOrder( order, items );
        next();
}