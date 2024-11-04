const express = require('express');
const router = express.Router();
const Eleicao = require('../models/Eleicao');
const Candidato = require('../models/Candidato');
const Eleitor = require('../models/Eleitor');
const {eAdmin, isLogado} = require('../helpers/permissao')

router.get('/:id', isLogado, (req, res) => {
    Eleicao.findByPk(req.params.id).then((eleicao) => {
        Candidato.findAll({
            include:[
                {
                    model: Eleicao,
                },
                {
                    model: Eleitor,
                }
            ],
            where:{
                eleicao_id: eleicao.id
            }
        }).then(function (candidatos) {
            res.render('candidato/index', {eleicao: eleicao, candidatos: candidatos});
        })
    })
})

router.get('/cadastrar/:id', eAdmin, (req, res) => {
    Eleitor.findAll().then(function (eleitores) {
        Eleicao.findByPk(req.params.id).then((eleicao) => {
            res.render('candidato/cadastrar', { eleitores, eleicao});
        })
    })
});

router.post('/cadastrar/', eAdmin,(req, res) => {
    const candidato = {
        descricao: req.body.descricao,
        votos: 0,
        numero: req.body.numero,
        status: 0,
        eleitor_id: req.body.responsavel,
        eleicao_id: req.body.eleicao_id,
    }
    Candidato.create(candidato).then(function () {
        req.flash('success_msg', 'Candidato cadastrado com sucesso')
        res.redirect('/candidato/'+candidato.eleicao_id)
    }).catch(function (error) {
        req.flash('error_msg', error)
    })
})

module.exports = router;