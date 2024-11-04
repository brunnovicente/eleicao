const banco = require('./banco');

const Eleicao = banco.sequelize.define("eleicoes", {
    id: {
        type: banco.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    descricao: {
        type: banco.Sequelize.STRING(45),
        allowNull: false
    },
    inicio: {
        type: banco.Sequelize.DATE,
        allowNull: false
    },
    fim: {
        type: banco.Sequelize.DATE,
        allowNull: false
    },
    status: {
        type: banco.Sequelize.INTEGER,
        allowNull: false
    }
})

Eleicao.sync()

module.exports = Eleicao;