const express = require('express');
const router = express.Router();
const Cargo = require('../models/Cargo');
const Eleicao = require('../models/Eleicao');

router.get('/cadastrar/:id', (req, res) => {
    Eleicao.findByPk(req.params.id).then(function (eleicao){
        res.render('cargo/cadastrar', {eleicao: eleicao});
    })
})

router.post('/cadastrar', (req, res) => {
    let cargo = {
        descricao: req.body.descricao,
        vagas: req.body.vagas,
        eleicao_id: req.body.eleicao_id,
    }
    Cargo.create(cargo).then(function () {
        req.flash('success_msg', 'Cargo criado com sucesso');
        res.redirect('/eleicao/view/'+cargo.eleicao_id);
    }).catch(function (error) {
        req.flash(error)
        res.redirect('/eleicao/view/'+cargo.eleicao_id);
    })
})

module.exports = router;