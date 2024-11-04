const express = require('express');
const router = express.Router();
const Urna = require('../models/Urna');
const Candidato = require('../models/Candidato');
const Voto = require('../models/Voto');
const Comprovante = require('../models/Comprovante');
const transporter = require("../config/email");
const Eleicao = require("../models/Eleicao");

router.get('/votar/:id/:ur', (req, res) => {
    Comprovante.findOne({
        where:{
            eleitor_id: req.user.eleitor_id
        }
    }).then(function (comprovante) {
        if(comprovante){
            req.flash('error_msg', 'Você já votou nessa eleição');
            res.redirect('/principal')
        }else{
            Candidato.findAll({
                    where: {
                        eleicao_id: req.params.id
                    }
                }).then((candidatos) => {
                    Eleicao.findByPk(req.params.id).then((eleicao) => {
                        Urna.findByPk(req.params.ur).then(function (urna) {
                            res.render('voto/votar', { candidatos: candidatos, urna: urna, eleicao: eleicao});
                        })
                    })
                })
        }
    })


    // Candidato.findAll({
    //     where: {
    //         eleicao_id: req.params.id
    //     }
    // }).then((candidatos) => {
    //     Urna.findByPk(req.params.ur).then(function (urna) {
    //         res.render('voto/votar', { candidatos: candidatos, urna: urna });
    //     })
    // })
})

router.post('/votar', (req, res) => {
    let tipo;
    if(req.body.candidato){
        tipo = 1
    }else{
        tipo = 0
    }
    const voto = {
        urna_id: req.body.urna,
        candidato_id: req.body.candidato,
        tipo: tipo
    }
    Voto.create(voto).then(() => {
        Comprovante.create({
            eleitor_id: req.user.eleitor_id,
            eleicao_id: req.body.eleicao
        }).then(function () {
            req.flash('success_msg', 'Voto depositado com sucesso')
            res.redirect('/principal')
        })
    })
})

router.get('/email', (req, res) => {
    const config = {
        from: 'coordenacao@gestaoedu.com',
        to: 'brunovicente.lima@ifma.edu.br',
        subject: 'Votação',
        text: 'Testando o sistema de Votação'
    }
    transporter.sendMail(config).then(function () {
        req.flash('success_msg', 'Email enviado com sucesso')
        res.redirect('/principal')
    })
})

module.exports = router;