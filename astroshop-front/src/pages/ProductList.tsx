import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import Product from "../interfaces/Product";
import API_BASE_URL from "../config/config";

const ProductList = () => {
    const [products, setProducts] = useState<Product[]>([]);

    useEffect(() => {
        axios.get(API_BASE_URL)
            .then((response) => {
                setProducts(response.data);
            })
            .catch((error) => {
                console.error("Erreur lors de la récupération des produits:", error);
            });
    }, []);

    return (
        <div>
            <h1>Astroshop - Liste des Produits</h1>
            <ul>
                {products.map((product) => (
                    <li key={product.id}>
                        <Link to={`/product/${product.id}`}>
                            {product.name} - ${product.price}
                        </Link>
                    </li>
                ))}
            </ul>
            <Link to="/cart">🛒 Voir le panier</Link>
        </div>
    );
};

export default ProductList;
