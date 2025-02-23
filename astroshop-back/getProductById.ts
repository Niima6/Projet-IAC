import { APIGatewayProxyHandler } from "aws-lambda";
import { query } from "./db";

export const handler: APIGatewayProxyHandler = async (event) => {
    const { id } = event.pathParameters || {};
    const product = await query("SELECT * FROM products WHERE id = ?", [id]) as any[];

    if (!product.length) {
        return { statusCode: 404, body: "Produit non trouvé" };
    }

    return {
        statusCode: 200,
        body: JSON.stringify(product[0]),
    };
};
