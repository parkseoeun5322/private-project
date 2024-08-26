const express = require('express');
const router = express.Router();
const { Favorite } = require('../models/Favorite')

// favorite 숫자 가져오기
router.post('/favoriteNumber', (req, res) => {
    // mogoDB 연결
    Favorite.find({ "movieId": req.body.movieId })
    .exec(( err, info ) => {
        if(err) return res.status(400).send(err)
        
        // 그 다음에 프론트에 다시 숫자 정보를 보내주기
        res.status(200).json({ success:true, favoriteNumber: info.length })
    })
})

// 좋아요 여부 가져오기
router.post('/favorited', (req, res) => {
    
    // 내가 이 영화를 Favorite 리스트에 넣었는 지 정보를 DB에서 가져오기
    Favorite.find({ "movieId": req.body.movieId, "userFrom": req.body.userFrom })
    .exec(( err, info ) => {
        let result = false
        if(info.length != 0) result = true
        
        res.status(200).json({ success: true, favorited: result })
    })
})

// 좋아요 추가
router.post('/addToFavorite', (req, res) => {
    //model을 통해서 document instance를 생성해야함
    const favorite = new Favorite(req.body)

    // save 메소드를 통해 req.body가 favorite document에 저장됨
    favorite.save((err, doc) => {
        if(err) return res.status(400).send(err)
        return res.status(200).json({success: true})
    })
})

// 좋아요 삭제
router.post('/removeFromFavorite', (req, res) => {

    Favorite.findOneAndDelete({ movieId: req.body.movieId, userFrom: req.body.userFrom })
    .exec((err, doc) => {
        if(err) return res.status(400).send(err) 
        res.status(200).json({success: true, doc})
    })
})

// 좋아요 리스트 가져오기
router.post('/getFavoredMovie', (req, res) => {
    Favorite.find({ 'userFrom': req.body.userFrom })
        .exec((err, favorites) => {
            if(err) return res.status(400).send(err)
            return res.status(200).json({ success: true, favorites })
        })
})

// 좋아요 리스트에서 삭제하기
router.post('/removeFromFavorite', (req, res) => {
    Favorite.findOneAndDelete({ movieId: req.body.movieId, userFrom: req.body.userFrom })
        .exec(( err, result ) => {
            if(err) return res.status(400).send(err)
            return res.status(200).json({ success: true })
        })
})

module.exports = router;
