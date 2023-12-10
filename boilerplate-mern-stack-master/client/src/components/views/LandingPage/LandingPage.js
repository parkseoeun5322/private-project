import React, { useEffect, useState } from 'react'
import { API_KEY, API_URL, IMAGE_BASE_URL } from '../../Config';
import MainImage from './Sections/MainImage';
import GridCards from '../commons/GridCards';
import { Row } from 'antd';

function LandingPage() {

    const [Movies, setMovies] = useState([])
    const [MainMovieImage, setMainMovieImage] = useState(null)
    const [CurrentPage, setCurrentPage] = useState(0)
    
    useEffect(() => {
        const endPoint = `${API_URL}movie/popular?api_key=${API_KEY}&language=en-US&page=1`;
        fetchMovies(endPoint)
    }, [])

    const fetchMovies = (endPoint) => {
        fetch(endPoint)
        .then(res => res.json())
        .then(response => {
            setMovies([...Movies, ...response.results])
            setMainMovieImage(response.results[0])
            setCurrentPage(response.page)
        })
    }

    // 더보키 버튼 클릭 이벤트
    const loadMoreItems = () => {
        const endPoint = `${API_URL}movie/popular?api_key=${API_KEY}&language=en-US&page=${CurrentPage + 1}`;
        fetchMovies(endPoint)
    }

    return (
        <div style={{ width: '100%', margin: '0' }}>

            {/* Main Image */}

            {/* 아래의 코드(MainMovie Image && ~~ )를 사용하지 않으면 
                setMainMovieImage를 하기 전에 컴포넌트를 랜더링하므로 
                MainMovieImage의 backdrop_path를 찾지 못하게 된다. */}
            {MainMovieImage &&         
                <MainImage 
                    image={`${IMAGE_BASE_URL}w1280${MainMovieImage.backdrop_path}`}
                    title={MainMovieImage.original_title}
                    text={MainMovieImage.overview}
                />
            }

            <div style={{ width: '85%', margin: '1rem auto' }}>

                <h2>Movies by latest</h2>
                <hr/>

                {/* Movie Grid Cards */}
                <Row gutter={[16, 16]}>
                    {Movies && Movies.map((movie, index) => (
                        <React.Fragment key={index}>
                            <GridCards
                                landingPage
                                image={movie.poster_path ? 
                                    `${IMAGE_BASE_URL}w500${movie.poster_path}` : null}
                                movieId={movie.id}
                                movieName={movie.original_title}
                                test='test'
                            />
                        </React.Fragment>
                    ))}
                </Row>

            </div>
            <div style={{ display: 'flex', justifyContent: 'center' }}>
                <button onClick={loadMoreItems}>Load More</button>
            </div>

        </div>
    )
}

export default LandingPage
