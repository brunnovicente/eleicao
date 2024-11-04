const banco = require('./banco');

const Eleitor = banco.sequelize.define("eleitores", {
    id: {
        type: banco.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    matricula: {
        type: banco.Sequelize.STRING(100),
        allowNull: false
    },
    email: {
        type: banco.Sequelize.STRING(100),
        allowNull: false
    },
    nome: {
        type: banco.Sequelize.STRING(100),
        allowNull: false
    },
    status: {
        type: banco.Sequelize.INTEGER,
        allowNull: false
    }
})

Eleitor.sync()

module.exports = Eleitor;