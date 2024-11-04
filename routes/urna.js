const express = require('express');
const router = express.Router();
const Urna = require('../models/Urna');
const Eleicao = require('../models/Eleicao');
const {eAdmin, isLogado} = require('../helpers/permissao')

router.get('/:id', isLogado, (req, res) => {
    Eleicao.findByPk(req.params.id).then(function (eleicao){
        Urna.findAll({
            where:{
                eleicao_id: req.params.id
            }
        }).then(function (urnas) {
            res.render('urna/index', {eleicao: eleicao, urnas: urnas});
        })
    })

})//Fim da Rota

router.get('/cadastrar/:id', eAdmin, (req, res) => {
    Eleicao.findByPk(req.params.id).then(function (eleicao){
        res.render('urna/cadastrar', {eleicao: eleicao});
    })
})

router.post('/cadastrar', eAdmin, (req, res) => {
    let urna = {
        descricao: req.body.descricao,
        eleicao_id: req.body.eleicao_id,
        status: 0
    }
    Urna.create(urna).then(function () {
        req.flash('success_msg', 'Urna criada com sucesso');
        res.redirect('/urna/'+urna.eleicao_id);
    }).catch(function (error) {
        req.flash(error)
        res.redirect('/urna/'+urna.eleicao_id);
    })
})

router.get('/excluir/:id', eAdmin, (req, res) => {
    Urna.findByPk(req.params.id).then(function (urna) {
        if(urna.status > 0){
            req.flash('error_msg', 'Não é possível excluir urna após iniciar a eleição');
            res.redirect('/urna/'+urna.eleicao_id);
        }
        Urna.destroy({
            where:{
                id: req.params.id
            }
        }).then(function () {
            req.flash('success_msg', 'Urna deletada com sucesso');
            res.redirect('/urna/'+urna.eleicao_id);
        })
    })
})

module.exports = router;