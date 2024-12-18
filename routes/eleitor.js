const express = require('express');
const router = express.Router();
const {eAdmin, isLogado} = require('../helpers/permissao')
const Eleitor = require('../models/Eleitor')
const Usuario = require('../models/Usuario')
const email = require('../config/email')

router.get('/', eAdmin,(req, res) => {
    Eleitor.findAll().then(
        function (eleitores) {
            //res.json(eleitores);
            res.render('eleitor/index', {eleitores: eleitores});
        })
})

router.get('/gerar', (req, res) => {
    Eleitor.findAll().then(function (eleitores) {
        for(let i = 0; i < eleitores.length; i++) {
            Usuario.create({
                username: eleitores[i].matricula,
                categoria: 0,
                status: 1,
                eleitor_id: eleitores[i].id,
                password: "senha"
            })
        }
        res.redirect('principal')
    })
})

module.exports = router;