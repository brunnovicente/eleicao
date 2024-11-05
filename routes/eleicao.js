const express = require('express');
const router = express.Router();
const Eleicao = require('../models/Eleicao');
const {eAdmin, isLogado} = require('../helpers/permissao');

router.get('/', isLogado,(req, res) => {
    Eleicao.findAll().then(
        function (eleicoes) {
            res.render('eleicao/index', {eleicoes: eleicoes});
        }
    )
})

router.get('/cadastrar', eAdmin,(req, res) => {
    res.render('eleicao/cadastrar');
})

router.post('/cadastrar', eAdmin, (req, res) => {
    let eleicao = {
        descricao: req.body.descricao,
        inicio: req.body.inicio,
        fim: req.body.fim,
        status: 0
    }
    Eleicao.create(eleicao).then(function () {
        req.flash('success_msg', 'Eleição cadastrada com sucesso');
        res.redirect('/eleicao');
    }).catch(function (error) {
        req.flash('error_msg', error)
        res.redirect('/eleicao');
    })
})

router.get('/iniciar/:id', eAdmin, (req, res) => {
    Eleicao.findByPk(req.params.id).then(function (eleicao) {
        eleicao.update({
            status: 1
        }).then(function () {
            req.flash('success_msg', 'Eleicão iniciada')
            res.redirect('/eleicao')
        })
    })
})

module.exports = router;