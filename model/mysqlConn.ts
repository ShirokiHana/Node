"use strict";

import mysql, { PoolOptions } from "mysql2/promise";

const options : PoolOptions = {
    host: process.env.DB_HOST,
    port: Number( process.env.DB_PORT ),
    user: process.env.DB_USER,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,

    waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 10,
    idleTimeout: 60000,
    queueLimit: 10,
    enableKeepAlive: true,
    namedPlaceholders: false
};

export default mysql.createPool( options );