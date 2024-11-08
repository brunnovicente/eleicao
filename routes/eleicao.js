const express = require('express');
const router = express.Router();
const Eleicao = require('../models/Eleicao');
const Candidato = require('../models/Candidato');
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

router.get('/encerrar/:id', eAdmin, (req, res) => {
    Eleicao.findByPk(req.params.id).then(function (eleicao) {
        eleicao.update({
            status: 2
        }).then(function () {
            req.flash('success_msg', 'Votação encerrada com sucesso')
            res.redirect('/eleicao')
        })
    })
})

router.get('/resultados/:id', isLogado,(req, res) => {
    Eleicao.findByPk(req.params.id).then(function (eleicao) {
        Candidato.findAll({
            where:{
                eleicao_id: eleicao.id
            },
            order: [
                ['votos', 'DESC'] // Ordena pelo campo "nome" em ordem crescente
            ]
        }).then(function (candidatos) {
            var total = 0;
            for (let i = 0; i < candidatos.length; i++) {
                total += candidatos[i].votos
            }
            for (let i = 0; i < candidatos.length; i++) {
                candidatos[i].porcentagem = ((candidatos[i].votos / total)*100).toFixed(2)
            }
            res.render('eleicao/resultados', {eleicao: eleicao,candidatos: candidatos, total: total});
        })
    })
})

router.get('/excluir/:id', eAdmin, (req, res) => {
    Eleicao.destroy({
        where:{
            id: req.params.id
        }
    }).then(function (){
        req.flash('success_msg', 'Eleicão removida com sucesso.')
        res.redirect('/eleicao')
    })
})

router.get('/editar/:id', eAdmin, (req, res)=>{
    Eleicao.findByPk(req.params.id).then(function (eleicao){
        res.render('eleicao/editar', {eleicao: eleicao})
    })
})

router.post('/editar', eAdmin, (req, res)=>{
    Eleicao.findByPk(req.body.id).then(function (eleicao){
        eleicao.update({
            descricao: req.body.descricao,
            inicio: req.body.inicio,
            fim: req.body.fim
        }).then(function (){
            req.flash('success_msg', 'Eleicão editada com sucesso.')
            res.redirect('/eleicao')
        })
    })
})

module.exports = router;