import React, { useEffect, useState } from 'react'
import SingleComment from './SingleComment'

function ReplyComment(props) {
    const [ChildCommentNumber, setChildCommentNumber] = useState(0)
    const [OpenReplyComment, setOpenReplyComment] = useState(false)

    useEffect(() => {
        let commentNumber = 0
        {props.commentLists && props.commentLists.map((comment) => {
            if(comment.responseTo === props.parentCommentId) {
                commentNumber++
            }
        })}

        setChildCommentNumber(commentNumber)
    }, [props.commentLists])

    const renderReplyComment = (parentCommentId) =>
        props.commentLists && props.commentLists.map((comment) => (
            <React.Fragment>
                {
                    comment.responseTo === parentCommentId &&
                    <div style={{ width: '80%', marginLeft: '40px' }}>
                        <SingleComment 
                        refreshFunction={props.refreshFunction} 
                        comment={comment} 
                        movieId={props.movieId}  
                        />
                        <ReplyComment 
                            refreshFunction={props.refreshFunction}
                            parentCommentId={comment._id}
                            movieId={props.movieId} 
                            commentLists={props.commentLists}
                        />
                    </div>
                }
                </React.Fragment>
        ))

        const onHandleChange = () => {
            setOpenReplyComment(!OpenReplyComment)
        }
    
    return (
        <div>
            {ChildCommentNumber > 0 && 
                <p style={{ fontSize: '14px', margin: 0, color: 'gray'}} onClick={onHandleChange}>
                    View {ChildCommentNumber} more comment(s)
                </p>
            }
            {OpenReplyComment && 
                renderReplyComment(props.parentCommentId)
            }
        </div>
    )
}

export default ReplyComment
