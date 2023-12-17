import React, { useEffect, useState } from 'react'
import {useParams} from 'react-router-dom'
import { API_KEY, API_URL, IMAGE_BASE_URL } from '../../Config';
import MainImage from '../LandingPage/Sections/MainImage';
import MovieInfo from './Section/MovieInfo';
import GridCards from '../commons/GridCards';
import { Row } from 'antd';
import Favorite from './Section/Favorite';
import Comment from './Section/Comment';
import Axios from 'axios';

function MovieDetail(props) {

    let {movieId} = useParams()
    const [Movie, setMovie] = useState([])
    const [Casts, setCasts] = useState([]);
    const [ActorToggle, setActorToggle] = useState(false);
    const [Comments, setComments] = useState([]);

    useEffect(() => {

        let endPointCrew = `${API_URL}movie/${movieId}/credits?api_key=${API_KEY}`
        let endPointInfo = `${API_URL}movie/${movieId}?api_key=${API_KEY}`

        fetch(endPointInfo)
            .then(res => res.json())
            .then(response => {
                setMovie(response)
            })

        fetch(endPointCrew)
            .then(res => res.json())
            .then(response => {
                setCasts(response.cast)
            })

        const variables = { movieId: movieId }

        Axios.post('/api/comment/getComments', variables)
        .then(response => {
            if(response.data.success) {
                setComments(response.data.comments)
                console.log(response.data.comments)
            } else {
                alert('댓글 정보를 가져오는 데 실패했습니다!')
            }
        })
    }, [])

    const toggleActorView = () => {
        setActorToggle(!ActorToggle);
    }

    const refreshFunction = (newComment) => {
        setComments(Comments.concat(newComment))
    }

  return (
    <div>
      {/* Header */}
      <MainImage 
        image={`${IMAGE_BASE_URL}w1280${Movie.backdrop_path}`}
        title={Movie.original_title}
        text={Movie.overview}
      />  

      {/* Body */}
      <div style={{ width: '85%', margin: '1rem auto' }}>

        <Favorite movieInfo={Movie} movieId={movieId} userFrom={localStorage.getItem('userId')} />

        {/* Movie Info */}
        <MovieInfo
            movie={Movie}
        />
        <br />
        
        {/* Actor Grid */}
        <div style={{ display: 'flex', justifyContent: 'center', margin: '2rem' }}>
            <button onClick={toggleActorView}>Toggle Actor View</button>
        </div>

        {ActorToggle && 
            <Row gutter={[16, 16]}>
                {Casts && Casts.map((cast, index) => (
                    <React.Fragment key={index}>
                        <GridCards
                            image={cast.profile_path ? 
                                `${IMAGE_BASE_URL}w500${cast.profile_path}` : null}
                            characterName={cast.name}
                        />
                    </React.Fragment>
                ))}
            </Row>
        }

        <Comment refreshFunction={refreshFunction} commentLists={Comments} />

      </div>
    </div>
  )
}

export default MovieDetail
