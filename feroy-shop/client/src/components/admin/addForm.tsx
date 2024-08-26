import { SyntheticEvent } from "react"
import { QueryClient, useMutation } from "react-query"
import { ADD_PRODUCT, MutableProduct, Product, Products } from "../../graphql/products"
import { getClient, graphqlFetcher, QueryKeys } from "../../queryClient"
import arrToObj from "../../util/arrToObj"

const AddForm = () => {
    const queryClient = getClient()
    const { mutate: addProduct } = useMutation(
        ({ title, imageUrl, price, description } : MutableProduct) => 
            graphqlFetcher(ADD_PRODUCT, { title, imageUrl, price, description }),
        {
            onSuccess: () => {
                // (1) 데이터를 stale 처리해서 재요청하게끔 하는 방법
                //      (장점) 코드가 간단하고 쉬움
                //      (단점) 서버요청을 다시 한다는 것
                queryClient.invalidateQueries(QueryKeys.PRODUCTS, {
                    exact: false,
                    refetchInactive: true
                })
                // (2) 응답 결과만으로 캐시를 업데이트하는 방법 => 장단점은 위와 반대
                // const adminData = queryClient.getQueriesData<{
                //     pageParams: (number | undefined)[]
                //     pages: Products[]
                // }>([QueryKeys.PRODUCTS, true])

                // const [adminKey, { pageParams: adminParams, pages: adminPages }] = 
                // adminData[0]
                // const newAdminPages = [...adminPages]
                // newAdminPages[0].products = [addProduct, ...newAdminPages[0].products]
                // queryClient.setQueriesData(adminKey, { pageParams: adminParams, pages: newAdminPages })
            },
        },
    )

    const handleSubmit = (e: SyntheticEvent) => {
        e.preventDefault()
        const formData = arrToObj([...new FormData(e.target as HTMLFormElement)])
        formData.price = Number(formData.price)
        addProduct(formData as MutableProduct)
    }

    return (
        <form onSubmit={handleSubmit}>
            <label>상품명: <input name="title" type="text" required /></label>
            <label>아미지 URL: <input name="imageUrl" type="text" required /></label>
            <label>상품가격: <input name="price" type="number" required min="1000" /></label>
            <label>상세: <textarea name="description" /></label>
            <button type="submit">등록</button>
        </form>
    )
}

export default AddForm