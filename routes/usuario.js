const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs')
const Usuario = require('../models/usuario');
const Eleitor = require('../models/eleitor');
const passport = require('passport');
const transporter = require("../config/email");
const seguranca = require("../helpers/senha");

router.get('/', (req, res) => {
    res.render('usuario/index')
})

router.get('/cadastrar', (req, res) => {
    res.render('usuario/cadastrar')
})

router.post('/cadastrar', (req, res) => {
    var usuario = {
        username: req.body.username,
        password: req.body.password,
        categoria: 0,
        status: 0
    }
    bcrypt.genSalt(10, function (erro, salt) {
        bcrypt.hash(usuario.password, salt, function (erro, hash) {
            if(erro){
                req.flash('error_msg', erro)
                res.redirect('/principal')
            }
            usuario.password = hash
            Usuario.create(usuario).then(function () {
                req.flash('success_msg', 'Usuário criado com sucesso');
                res.redirect('/principal')
            })
        })
    })
})

router.get('/login', (req, res) => {
    if(req.isAuthenticated()){
        req.flash('success_msg', 'Usuário já logado')
        res.redirect('/principal')
    }
    res.render('usuario/login', {layout: 'secundario'})
})

router.post('/login', (req, res, next) => {
    passport.authenticate('local', {
        successRedirect: '/principal',
        failureRedirect: '/usuario/login',
        failureFlash: true
    })(req, res, next);

})

router.get('/esqueceu', (req, res) => {
    res.render('usuario/esqueceu', {layout: 'secundario'})
})

router.post('/esqueceu', (req, res) => {
    const matricula = req.body.matricula
    Usuario.findOne({
        where:{
            username: matricula,
        },
        include:{
            model: Eleitor
        }
    }).then(function (usuario) {
        if(!usuario){
            req.flash('error_msg', 'Usuário não encontrado')
            res.redirect('/usuario/login')
        }
        usuario.password = seguranca.gerarSenha()

        bcrypt.genSalt(10, function (erro, salt) {
            bcrypt.hash(usuario.password, salt, function (erro, hash) {
                if(erro){
                    req.flash('error_msg', erro)
                    res.redirect('/usuario/login')
                }
                let senha = usuario.password
                usuario.password = hash

                usuario.update({
                    password: hash
                }).then(function () {
                    const config = {
                        from: 'coordenacao@gestaoedu.com',
                        to: usuario.eleitore.email,
                        subject: 'Nova Senha - Eleição',
                        text: 'Segue a senha atualizada: '+senha
                    }
                    transporter.sendMail(config).then(function () {
                        req.flash('success_msg', 'Senha enviado para o e-mail '+usuario.eleitore.email)
                        res.redirect('/usuario/login')
                    })
                })
            })
        })
    })
})



router.get('/logout', (req, res) => {
    req.logout(function (erro){
        req.flash('success_msg', 'Usuário deslogado com sucesso.')
        res.redirect('/usuario/login')
    })
})

module.exports = router;