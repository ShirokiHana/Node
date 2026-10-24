"use strict";

import "./helper/loadEnv";

import supplierRouter from "./routes/supplier";
import express, { Express } from "express";
import * as http from "node:http";
import morgan from "./morgan";
// import getDirname from "./helper/getDirname";
import orderRouter from "./routes/order";
// import appRouter from "./routes/app";

const app : Express = express();


// --------Middleware
app.use( morgan )
app.use( express.json() )

// --------Serve Static
// const __dirname = getDirname( import.meta.url );
// app.use( serveStatic( path.join( __dirname, 'public' ) ) );

// --------Auth

// --------Routing
app.use( '/supplier', supplierRouter );
app.use( '/order', orderRouter );

// app.use( '/restock', appRouter );

// --------Server

const server = http.createServer( app );
server.listen( 3030, () => console.log( 'Server is up and running!' ) );