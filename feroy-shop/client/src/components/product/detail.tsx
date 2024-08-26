import { Product } from "../../graphql/products"

const ProductDetail = ({
    item: {
        id,
        title,
        imageUrl,
        description,
        price,
        createdAt
    }
}: {
    item: Product
}) => (
    <div className="product-detail">
        <p className="product-detail__title">{title}</p>
        <img className="product-detail__image" src={imageUrl} />
        <p className="product-detail__description">{description}</p>
        <span className="product-detail__price">${price}</span>
    </div>   
)

export default ProductDetail