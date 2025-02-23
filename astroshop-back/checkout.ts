import { APIGatewayProxyHandler } from "aws-lambda";

export const handler: APIGatewayProxyHandler = async () => {
    return {
        statusCode: 200,
        body: JSON.stringify({ message: "Paiement réussi", orderId: Date.now() }),
    };
};
