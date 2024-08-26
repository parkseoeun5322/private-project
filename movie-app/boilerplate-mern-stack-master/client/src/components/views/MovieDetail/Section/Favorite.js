import React, { useEffect, useState } from 'react'
import Axios from 'axios'
import { Button } from 'antd'

function Favorite(props) {
    const movieId = props.movieId
    const userFrom = props.userFrom
    const movieTitle = props.movieInfo.title
    const moviePost = props.movieInfo.backdrop_path
    const movieRunTime = props.movieInfo.runtime

    const [FavoriteNumber, setFavoriteNumber] = useState(0)
    const[Favorited, setFavorited] = useState(false)

    let variables = {
      userFrom: userFrom,
      movieId: movieId,
      movieTitle: movieTitle,
      moviePost: moviePost,
      movieRunTime: movieRunTime
    }

    useEffect(() => {

      // 좋아요 수 가져오기
      Axios.post('/api/favorite/favoriteNumber', variables)
        .then(res => {
          if(res.data.success) {
            setFavoriteNumber(res.data.favoriteNumber)
          } else {
            alert('숫자 정보를 가져오는데 실패하였습니다.')
          }
        })

        // 내가 좋아요 했는 지에 대한 여부 가져오기
        Axios.post('/api/favorite/favorited', variables)
        .then(res => {
          if(res.data.success) {
            setFavorited(res.data.favorited)
          } else {
            alert('정보를 가져오는 데 실패했습니다.')
          }
        })

    }, [])

    const onClickFavorite = () => {
      if(Favorited) {
        Axios.post('/api/favorite/removeFromFavorite', variables)
        .then(res => {
          if(res.data.success) {
            setFavoriteNumber(FavoriteNumber - 1)
            setFavorited(!Favorited)
          } else {
            alert('Favorite 리스트에서 삭제하는 데 실패했습니다.')
          }
        })
      } else {
        Axios.post('/api/favorite/addToFavorite', variables)
        .then(res => {
          if(res.data.success) {
            setFavoriteNumber(FavoriteNumber + 1)
            setFavorited(!Favorited)
          } else {
            alert('Favorite 리스트에서 추가하는 데 실패했습니다.')
          }
        })
      }
    }

  return (
    <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
      <Button onClick={onClickFavorite}>
        {Favorited? "Not Favorite" : "Add to Favorite"} {FavoriteNumber}
      </Button>
    </div>
  )
}

export default Favorite
