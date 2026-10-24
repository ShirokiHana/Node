"use strict";

import express, {NextFunction, Request, Response} from "express";
import { requireSupplier } from "../middleware/enforceRequire";
import { validateCart } from "../middleware/validateRequest";
import createOrder from "../model/createOrder";
import errorBubble from "../lib/errorBubble";
import orderPage from "../public/list";
import supplierPage from "../public";
import { modifyRequestBody, reshapeCart, viewRequestBody } from "../middleware/reshapeData";
import receiptPage from "../public/receipt";
import validateId from "../middleware/validateId";
import suppliersPage from "../public/suppliers";
import ordersPage from "../public/orders";
import orderDetailPage from "../public/orderDetail";

// HTML rendering only

const appRouter = express.Router();

// --------Functions

const selectSupplierRoute = ( request : Request, response : Response, _next : NextFunction ) => {
    return response.redirect( 303, `/restock/${ request.body.supplier_id }/cart/` );
}

const renderHTML = ( fn : ( arg0 : Request ) => string | Promise<string> ) =>
    async ( request : Request, response : Response, next : NextFunction ) => {
        try {
            response.type( "html" ).send( await fn(request) );
        } catch ( error ) {
            next( error );
        }
    }

    const createOrderRoute = async ( request : Request, response : Response, next : NextFunction ) => {
        try {
            const order_id = await createOrder( Number( request.params.supplier_id ), request.body );
            response.redirect( 303, `/restock/${ order_id }`);
        } catch ( error ) {
            next( error );
        }
    }

// --------Middleware

appRouter.use( express.urlencoded( { extended: true } ) );

// --------Routing

// Render supplier selection
appRouter.route('/' )
    .get( renderHTML( supplierPage ) )
    .post( viewRequestBody, requireSupplier, selectSupplierRoute )
;

appRouter.route('/suppliers')
    .get( renderHTML( suppliersPage ) )
;

appRouter.route('/orders')
    .get( renderHTML( ordersPage ) )
;

appRouter.route('/orders/:id')
    .get( renderHTML( orderDetailPage ) )
;

appRouter.route('/:order_id' )
    .get( validateId( 'order_id' ), renderHTML( receiptPage ) )
;

// Render app cart
appRouter.route('/:supplier_id/cart' )
    // TODO: Require supplier middleware, enforce
    .get( viewRequestBody, requireSupplier, renderHTML( orderPage ) )
    .post( validateId( 'supplier_id' ),
            modifyRequestBody( reshapeCart ),
            validateCart,
            createOrderRoute
    )
;

// --------Error Bubbling
appRouter.use( errorBubble );

export default appRouter;