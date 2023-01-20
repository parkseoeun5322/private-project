import { SyntheticEvent } from "react"
import { useNavigate } from "react-router-dom"
import { useRecoilValue } from "recoil"
import { checkedCartState } from "../../recoils/cart"
import ItemData from "../cart/itemData"

const WillPay = ({
    submitTitle,
    handleSubmit
}: {
    submitTitle: string
    handleSubmit: (e: SyntheticEvent) => void
}) => {
    const checkedItems = useRecoilValue(checkedCartState)
    const totalPrice = checkedItems.reduce((res, { product: { price, createdAt }, amount}) => {
        if(createdAt) res += price * amount
        return res
    }, 0)

    // const handleSubmit = () => {
    //     if(checkedItems.length) {
    //         navigate('/payment')
    //     } else {
    //         alert('결제할 대상이 없어요')
    //     }
    // }

    return (
        <div className="cart-willpay">
            <ul>
                {checkedItems.map(({ product: {imageUrl, price, title, createdAt}, id, amount}) => (
                    <li key={id}>
                        <ItemData imageUrl={imageUrl} price={price} title={title} />
                        <p>수량 : {amount}</p>
                        <p>금액 : {price * amount}</p>
                        {!createdAt && '삭제된 상품입니다.'}
                    </li>
                ))}
            </ul>
            <p>총 예상결재액: {totalPrice}</p>
            <button onClick={handleSubmit}>{submitTitle}</button>
        </div>
    )
}

export default WillPay