import { APIGatewayProxyHandler } from "aws-lambda";
import { query } from "./db";

export const handler: APIGatewayProxyHandler = async () => {
    const products = await query("SELECT * FROM products");

    return {
        statusCode: 200,
        body: JSON.stringify(products),
    };
};
