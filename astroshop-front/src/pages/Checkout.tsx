import { Link } from "react-router-dom";

const Checkout = () => {
    return (
        <div>
            <h1>💳 Paiement</h1>
            <p>Ce paiement est fictif. Merci d'avoir utilisé Astroshop !</p>
            <button onClick={() => alert("Commande validée !")}>Confirmer l'achat</button>
            <br />
            <Link to="/">⬅ Retour à l'accueil</Link>
        </div>
    );
};

export default Checkout;
