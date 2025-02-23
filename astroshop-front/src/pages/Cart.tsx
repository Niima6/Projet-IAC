import { Link } from "react-router-dom";

const Cart = () => {
    // Ici on simulera le panier plus tard avec un contexte global
    const cartItems = [
        { id: 1, name: "Télescope Orion XT8", price: 499, quantity: 1 },
    ];

    return (
        <div>
            <h1>🛒 Votre Panier</h1>
            {cartItems.length === 0 ? (
                <p>Votre panier est vide.</p>
            ) : (
                <ul>
                    {cartItems.map((item) => (
                        <li key={item.id}>
                            {item.name} - ${item.price} x {item.quantity}
                        </li>
                    ))}
                </ul>
            )}
            <br />
            <Link to="/checkout">💳 Passer au paiement</Link>
            <br />
            <Link to="/">⬅ Continuer les achats</Link>
        </div>
    );
};

export default Cart;
