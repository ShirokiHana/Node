// noinspection ExceptionCaughtLocallyJS

"use strict";

import { CartItem }  from "../types/types";
import mysqlConn from "./mysqlConn";
import { ResultSetHeader, RowDataPacket } from "mysql2";
import {ValidationError} from "../lib/errors";

const minutesPerItem = 30;

export default async function( supplier_id : number, cart : CartItem[] ) : Promise<number> {
    // dedicated pool conn
    const connection = await mysqlConn.getConnection();

    try {
        // begin transaction, turn off auto commit, only final upon commit()
        await connection.beginTransaction();

        // return parts based on part id request
        const [ parts ] = await connection.query<RowDataPacket[]>(
            'SELECT part_id, price FROM parts WHERE supplier_id = ? AND part_id IN ( ? )',
            [ supplier_id, cart.map( element => element.part_id ) ]
        );

        if ( parts.length !== cart.length )
            throw new ValidationError( 'Sorry, some items are currently out of stock.' )

        // price lookup table
        const prices = new Map( parts.map( part => [ Number( part.part_id ), part.price ] ) );

        // for arrival time
        const totalUnits = cart.reduce( ( sum, item ) => sum + item.quantity, 0 );

        const [ order ] = await connection.query<ResultSetHeader>(
            `INSERT INTO supplier_orders ( supplier_id, issued_at, expected_arrival_at, status ) 
                    VALUES ( ?, NOW(), DATE_ADD( NOW(), INTERVAL ? MINUTE ), 'pending' )`,
            [ supplier_id, totalUnits * minutesPerItem ]
        );

        await connection.query(
            'INSERT INTO supplier_order_items ( supplier_order_id, part_id, quantity, unit_price ) VALUES ?',
            [ cart.map( item => [ order.insertId, item.part_id, item.quantity, prices.get( item.part_id ) ] ) ]
        )

        // both inserts commits
        await connection.commit();
        return order.insertId;
    } catch ( error ) {
        // undo
        await connection.rollback();
        throw error;
    } finally {
        // return connection to pool
        connection.release();
    }
}