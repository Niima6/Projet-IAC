import { APIGatewayProxyHandler } from "aws-lambda";
import { query } from "./db";

export const handler: APIGatewayProxyHandler = async (event) => {
    const { action, productId, quantity } = JSON.parse(event.body || "{}");

    if (action === "add") {
        await query("INSERT INTO cart (product_id, quantity) VALUES (?, ?)", [productId, quantity]);
    } else if (action === "remove") {
        await query("DELETE FROM cart WHERE product_id = ?", [productId]);
    }

    const cart = await query("SELECT * FROM cart");
    return {
        statusCode: 200,
        body: JSON.stringify(cart),
    };
};
