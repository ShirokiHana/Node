"use strict";

import { fileURLToPath } from "node:url";
import path from "node:path";

export default function getDirname( metaUrl : string ) : string {
    return path.dirname( fileURLToPath( metaUrl ) );
}