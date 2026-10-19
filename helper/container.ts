"use strict";

    const container = function ( x : any ){
        this.__value = x;
    }

    container.of = function ( x : string ) { return new container( x ) };

export default container;