"use strict";

import { NextFunction, Response, Request } from "express";
import mysqlConn from "./mysqlConn";
import {NotFoundError} from "../lib/errors";
import {ResultSetHeader} from "mysql2";

export const partial = (
    fn : ( request : Request, response : Response ) => Promise<any>,
    status = 200
    ) =>
    async (
        request : Request,
        response : Response,
        next : NextFunction
    ) => {
        try {
            response.status( status ).send( await fn( request, response ) );
        } catch ( error ) {
            next( error );
        }
    }

    export const findAll = async (
        query: string, params : any[] = []
        ) : Promise<any> => {
            const [ rows ] = await mysqlConn.execute( query, params );
            return rows;
    }

    export const findBy = async (
        query : string,
        wildcard : string | string[]
    ) => {
        const [ rows ] = await mysqlConn.execute( query, [ wildcard ].flat() );

        if ( !Array.isArray( rows ) || rows.length === 0 )
            throw new NotFoundError();
        return rows[ 0 ];
    }

    export const execute = async (
        query : string,
        params : any[] = []
    ) => {
        const [ result ] = await mysqlConn.execute<ResultSetHeader>(
            query, params
        );

        return {
            insertedId: result.insertId,
            affectedRows: result.affectedRows
        };
    }