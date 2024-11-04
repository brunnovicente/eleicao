const express = require('express');
const router = express.Router();
const Eleitor = require('../models/Eleitor');
const Eleicao = require('../models/Eleicao');
const {eAdmin, isLogado} = require('../helpers/permissao');

router.get('/', isLogado, (req, res) => {
    // Eleitor.findByPk(req.user.id).then(function (eleitor) {
    //     req.user.eleitor = eleitor;
    //     res.render('principal/index');
    // })
    Eleicao.findAll({
        where:{
            status: 1
        }
    }).then(function (eleicoes) {
        res.render('principal/index', {eleicoes: eleicoes});
    })

})

module.exports = router;