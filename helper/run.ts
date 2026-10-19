"use strict";

export default ( ...functions : any[] ) => ( x : any ) => {
    functions.reverse().forEach( func => x = func( x ) );
    return x;
};