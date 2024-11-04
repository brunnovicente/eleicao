const express = require('express');
const servidor = express();

const handlebars = require('express-handlebars');
const Handlebars = require('handlebars');
const bodyParser = require('body-parser');
const path = require('path');
const { allowInsecurePrototypeAccess } = require('@handlebars/allow-prototype-access');
const session = require('express-session');
const flash = require('connect-flash');
const passport = require('passport');
require('./config/auth')(passport)

///////////////////////////////
//CONFIGURAÇÕES
///////////////////////////////
const PORTA = 8080
//Sessão
servidor.use(session({
    secret: "iambatman",
    resave: true,
    saveUninitialized: false,
}))
servidor.use(passport.initialize())
servidor.use(passport.session())

servidor.use(flash());

servidor.use(function (req, res, next) {
    res.locals.success_msg = req.flash('success_msg')
    res.locals.error_msg = req.flash('error_msg')
    res.locals.error = req.flash('error')
    res.locals.usuario = req.user || null
    next()
});

//Template Engine
servidor.engine('handlebars', handlebars.engine({
    defaultLayout: 'main',
    handlebars: allowInsecurePrototypeAccess(Handlebars),
    'helpers':{
        json: function(context) {
            return JSON.stringify(context, null, 2);
        },
        formatDate: function (date) {
            const d =  new Date(date)
            const day = String(d.getDate()).padStart(2, '0')
            const month = String(d.getMonth() + 1).padStart(2, '0') // Mês começa do 0
            const year = d.getFullYear()
            const hours = String(d.getHours()).padStart(2, '0')
            const minutes = String(d.getMinutes()).padStart(2, '0')
            const seconds = String(d.getSeconds()).padStart(2, '0')
            return `${day}/${month}/${year} ${hours}:${minutes}:${seconds}`
        },
        statusEleicao: function (status) {
            switch (status) {
                case 0: return "Criada";
                case 1: return "Aberto";
                case 2: return "Em apuração";
                case 3: return "Encerrada";
                default: return "Desconhecido";
            }
        },
        statusUrna: function (status) {
            switch (status) {
                case 0: return "Fechada";
                case 1: return "Aberta";
            }
        },
        categoriaUsuario: function (categoria){
            switch (categoria) {
                case 0: return "Discente";
                case 1: return "Administrador";
            }
        },
        igual:function (a,b){
            return a === b
        },
        statusCandidato: function (status){
            switch (status) {
                case 0: return "Em votação";
                case 1: return "Eleito";
                case 2: return "Não Eleito";
            }
        }
    }
}));
servidor.set('view engine', 'handlebars');

//Body Parser
servidor.use(bodyParser.urlencoded({ extended: false }));
servidor.use(bodyParser.json());

//Pasta de Arquivos Estásticos
servidor.use(express.static(path.join(__dirname, 'public')));

///////////////////
//ROTAS DO SISTEMA
///////////////////
servidor.get('/', (req, res) => {
    //res.send('Página Inicial truando...')
    res.redirect('/principal')
})

const principal = require('./routes/principal');
servidor.use('/principal', principal);

const usuario = require('./routes/usuario');
servidor.use('/usuario', usuario);

const eleitor = require('./routes/eleitor');
servidor.use('/eleitor', eleitor);

const eleicao = require('./routes/eleicao');
servidor.use('/eleicao', eleicao);

const urna = require('./routes/urna');
servidor.use('/urna', urna);

const candidato = require('./routes/candidato');
servidor.use('/candidato', candidato);

const voto = require('./routes/voto')
servidor.use('/voto', voto);

servidor.listen(8080, function (){
    console.log("Servidor rodando em http://localhost:"+PORTA)
})