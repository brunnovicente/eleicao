const Eleitor = require("../models/Eleitor");
module.exports = {
    eAdmin: function(req, res, next) {
        if(req.isAuthenticated() && req.user.categoria === 1) {
            Eleitor.findByPk(req.user.eleitor_id).then(function (eleitor) {
                 req.user.eleitor = eleitor;
                 //return next()
            })
            return next()
        }
        req.flash('error_msg', 'Você não tem autorização para acessar esse conteúdo')
        res.redirect('/principal')
    },
    isLogado: function(req, res, next) {
        if(req.isAuthenticated()) {
             Eleitor.findByPk(req.user.eleitor_id).then(function (eleitor) {
                 req.user.eleitor = eleitor;
            //     return next()
             })
            return next()
        }
        req.flash('error_msg', 'Você não tem autorização para acessar esse conteúdo')
        res.redirect('/usuario/login')
    }
}