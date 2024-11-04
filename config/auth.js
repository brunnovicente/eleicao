const localEstrategy = require('passport-local').Strategy
const bcrypt = require('bcrypt')
const Usuario = require('../models/Usuario')
const Eleitor = require('../models/Eleitor')

module.exports = function (passport) {
    passport.use(new localEstrategy({
        usernameField: "username", passwordField: "password",
    }, function (username, password, done) {
        Usuario.findOne({
            where:{
                username: username
            },
            include:[
                {
                    model: Eleitor,
                }
            ]

        }).then(function (usuario) {
            if(!usuario){
                return done(null, false, {message: 'Usuário não encontrado!'});
            }
            bcrypt.compare(password, usuario.password, function (erro, batem) {
                if(batem){
                    return done(null, usuario)
                }else{
                    return done(null, false, {message: 'Senha Incorreta: '+ erro});
                }
            })
        })
    }));

    passport.serializeUser(function (usuario, done) {
        done(null, usuario.id)
    })

    passport.deserializeUser(function (id, done) {
        Usuario.findByPk(id).then((usuario) => {
            done(null, usuario)
        })
    })



}//Fim do Module Exports