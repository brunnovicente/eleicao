const express = require('express');
const router = express.Router();
const Urna = require('../models/Urna');
const Eleicao = require('../models/Eleicao');
const Voto = require('../models/Voto');
const Candidato = require('../models/Candidato');
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
        Eleicao.findByPk(urna.eleicao_id).then(function (eleicao){
            if(eleicao.status > 0){
                req.flash('error_msg', 'Não é possível excluir urna após iniciar a eleição');
                res.redirect('/urna/'+urna.eleicao_id);
            }else{
                Urna.destroy({
                    where:{
                        id: req.params.id
                    }
                }).then(function () {
                    req.flash('success_msg', 'Urna deletada com sucesso');
                    res.redirect('/urna/'+urna.eleicao_id);
                })
            }
        })
    })
})

router.get('/abrir/:id', eAdmin, (req, res)=>{
    Urna.findByPk(req.params.id).then(function (urna){
        Eleicao.findByPk(urna.eleicao_id).then(function (eleicao){
            if(eleicao.status < 2){
                req.flash('error_msg', 'Não é permitido abrir urna antes de encerrar a votação')
                res.redirect('/urna/'+eleicao.id)
            }
            if(urna.status == 0){
                urna.update({
                    status: 1,
                })
            }
            Voto.findAll({
                where:{
                    urna_id: urna.id
                },
                include:{
                    model: Candidato,
                    alias: 'candidato'
                }
            }).then(function (votos){
                urna.eleicao = eleicao
                res.render('urna/abrir', {urna: urna, votos: votos})
            })

        })
    })
})

router.get('/apurar/:id', eAdmin,(req, res)=>{
    Voto.findAll({
        where:{
            urna_id: req.params.id
        },
        include:{
            model: Candidato,
            alias: 'candidato'
        }
    }).then(function (votos){
        //req.flash('success_msg', 'Votos buscados: '+votos.length)
        Urna.findOne({
            where:{
                id: req.params.id
            },
        }).then(function (urna){
            Candidato.findAll({
                where:{
                    eleicao_id: urna.eleicao_id
                }
            }).then(function (candidatos){
                for (let i=0; i < candidatos.length; i++){
                    let qtd = contar(votos, candidatos[i].id) + candidatos[i].votos
                    //req.flash('success_msg', 'QTD: '+qtd)
                    candidatos[i].update({
                        votos: qtd
                    })
                }
                urna.update({
                    status: 2
                })
                req.flash('success_msg', 'Urna apurada com sucesso')
                res.redirect('/urna/abrir/'+urna.id)
            })
        })

    })
})

function contar(votos, id){
    var qtd = 0
    for(let i = 0; i < votos.length; i++){
        if(votos[i].candidato_id === id)
            qtd++
    }
    return qtd
}

module.exports = router;