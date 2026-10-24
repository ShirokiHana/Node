"use strict";

import {execute, findAll, findBy, partial} from "../model/mysqlQuery";
import { Request, Response } from 'express';
import validateId from "../middleware/validateId";
import errorBubble from "../lib/errorBubble";
import express from "express";
import {validateCart, validateOrderFilters, validateOrderStatus} from "../middleware/validateRequest";
import {modifyQuery, reshapeOrderFilters} from "../middleware/reshapeData";
import loadOrder from "../middleware/loadOrder";
import { NotFoundError, ValidationError } from "../lib/errors";
import createOrder from "../model/createOrder";
import {CartItem} from "../types/types";

const orderRouter = express.Router();

// --------Functions

    const getOrdersRoute = partial( ( _request : Request, response : Response ) => {
        const { supplier_id, status, from, to } = response.locals.filters;

        return findAll(
            `SELECT * FROM supplier_orders
             WHERE ( ? IS NULL OR supplier_id = ? )
               AND ( ? IS NULL OR status = ? )
               AND ( ? IS NULL OR issued_at >= ? )
               AND ( ? IS NULL OR issued_at < DATE_ADD( ?, INTERVAL 1 DAY ) )
             ORDER BY issued_at DESC, supplier_order_id DESC`,
            [ supplier_id, supplier_id, status, status, from, from, to, to ]
        ) }
    );

    const getOrderItemsRoute = partial(
        ( _request, response ) => response.locals.order.items
    );

    const getOrderRoute = partial(
        ( _request, response ) => response.locals.order
    );

    const updateOrderStatusRoute = partial(
        async ( request : Request ) => {
            const id = Number( request.params.id );
            const { status } = request.body;

            const result = await execute(
                'UPDATE supplier_orders SET status = ? WHERE supplier_order_id = ?',
                [ status, id ]
            );

            if ( result.affectedRows === 0 )
                throw new NotFoundError( 'Order not found' );

            return { supplier_order_id: id, status };
        }
    );

    const createOrderRoute = partial(
        async ( request : Request ) => {
            const supplierId = Number( request.body?.supplier_id );
            const cart : CartItem[] = request.body?.items;

            // TODO: Cut.
            if ( !Number.isInteger( supplierId) || supplierId <= 0 ) {
                throw new ValidationError("Invalid supplier_id route");
            }

            const orderId = await createOrder( supplierId, cart );

            return { order_id: orderId, message: "created" };
        }
    )

// --------Middleware

    export const findOrder = ( id : string ) =>
        findBy( 'SELECT * FROM supplier_orders WHERE supplier_order_id = ?', id );

    export const findOrderItems = ( id : string ) =>
        findAll(
            `SELECT i.part_id, p.part_name, i.quantity, i.unit_price
             FROM supplier_order_items i
             JOIN parts p ON p.part_id = i.part_id
             WHERE i.supplier_order_id = ?
             ORDER BY i.supplier_order_item_id`,
            [ id ]
        );

// --------Routing

orderRouter.route( '/' )
    .get( modifyQuery( reshapeOrderFilters ), validateOrderFilters, getOrdersRoute ) // ✅
    .post( express.json(), validateCart, createOrderRoute ) // body MUST be cart only
;

orderRouter.route( '/:id' )
    .get( validateId(), loadOrder, getOrderRoute ) // ✅
    .patch( validateId(), express.json(), validateOrderStatus, updateOrderStatusRoute ) // ✅
;

orderRouter.route( '/:id/items' )
    .get( validateId(), loadOrder, getOrderItemsRoute ) // ✅
;

// --------Error Bubbling
orderRouter.use( errorBubble );

export default orderRouter;