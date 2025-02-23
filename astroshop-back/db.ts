import mysql from 'serverless-mysql';
import dotenv from 'dotenv';
import { ConnectionOptions } from 'mysql2';
dotenv.config();

const db = mysql({
    config: {
        host: process.env.DB_HOST,
        database: process.env.DB_NAME,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        mergeFlags: function (defaultFlags: string[], userFlags: string[] | string): number {
            throw new Error('Function not implemented.');
        },
        getDefaultFlags: function (options?: ConnectionOptions): string[] {
            throw new Error('Function not implemented.');
        },
        getCharsetNumber: function (charset: string): number {
            throw new Error('Function not implemented.');
        },
        getSSLProfile: function (name: string): { ca: string[]; } {
            throw new Error('Function not implemented.');
        },
        parseUrl: function (url: string): { host: string; port: number; database: string; user: string; password: string;[key: string]: any; } {
            throw new Error('Function not implemented.');
        }
    }
});

export async function query(q: string, values?: any) {
    try {
        const results = await db.query(q, values);
        await db.end();
        return results;
    } catch (e) {
        throw Error(e);
    }
}
