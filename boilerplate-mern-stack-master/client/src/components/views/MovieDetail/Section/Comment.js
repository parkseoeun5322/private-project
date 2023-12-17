import Axios from 'axios'
import React, { useState } from 'react'
import { useSelector } from 'react-redux'
import { useParams } from 'react-router-dom'
import SingleComment from './SingleComment'

function Comment(props) {
    let {movieId} = useParams()
    const user = useSelector(state => state.user)
    const [commentValue, setcommentValue] = useState("")

    const handleClick = (event) => {
        setcommentValue(event.currentTarget.value)
    }

    const onSubmit = (event) => {
        // onSubmit이 실행됐을 때 페이지가 refresh가 안되게끔
        event.preventDefault();

        if(user.userData.error) {
            alert('댓글 작성은 로그인 후 가능합니다!')
            return false
        }

        const variables = {
            content: commentValue,
            writer: user.userData._id,
            movieId: movieId
        }
        Axios.post('/api/comment/saveComment', variables)
            .then(response => {
                if(response.data.success) {
                    setcommentValue("")
                    props.refreshFunction(response.data.result)

                } else {
                    alert('댓글을 저장하는 데 실패했습니다!')
                }
            })
    }

    return (
        <div>
            <br/>
            <p>Replies</p>
            <hr/>

            {/* Comment Lists */}
            {props.commentLists && props.commentLists.map((comment, index) => (
                (!comment.responseTo && 
                    <SingleComment refreshFunction={props.refreshFunction} comment={comment} movieId={movieId}  />
                )
            ))}

            {/* Root Comment Form */}
            <form style={{ display: 'flex' }} onSubmit={onSubmit}>
                <textarea
                    style={{ width: '100%', borderRadius: '5px' }}
                    onChange={handleClick}
                    value={commentValue}
                    placeholder='코멘트를 작성해 주세요'
                />
                <br/>
                <button style={{ width: '20%', height: '52px' }} onClick={onSubmit}>Submit</button>
            </form>
        </div>
    )
}

export default Comment