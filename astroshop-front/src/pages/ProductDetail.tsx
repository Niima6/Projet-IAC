import { useParams, Link } from "react-router-dom";
import { useEffect, useState } from "react";
import axios from "axios";
import Product from "../interfaces/Product";
import API_BASE_URL from "../config/config";

const ProductDetail = () => {
    const { id } = useParams();
    const [product, setProduct] = useState<Product>();

    useEffect(() => {
        axios.get(`${API_BASE_URL}/${id}`)
            .then((response) => setProduct(response.data))
            .catch(() => setProduct(undefined));
    }, [id]);

    if (!product) return <p>Produit non trouvé</p>;

    return (
        <div>
            <h1>{product.name}</h1>
            <p>{product.description}</p>
            <p>Prix : ${product.price}</p>
            <button onClick={() => alert("Ajouté au panier !")}>Ajouter au panier</button>
            <br />
            <Link to="/">⬅ Retour à la liste</Link>
        </div>
    );
};

export default ProductDetail;