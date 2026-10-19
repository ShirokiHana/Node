"use strict";

export interface Supplier {
    "supplier_id" : number,
    "supplier_name" : string,
}

export interface CartItem {
    part_id : number,
    quantity : number,
    price? : number
}

export interface Parts {
    "part_id" : number,
    "part_type" : string,
    "part_name" : string,
    "price" : number,
    "supplier_id" : number,
    "supplier_name" : string
}