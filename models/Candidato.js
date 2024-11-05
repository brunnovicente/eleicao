const banco =require('./banco');
const Eleitor  = require('./Eleitor');
const Eleicao  = require('./Eleicao');

const Candidatura = banco.sequelize.define('candidatos', {
    id: {
        type: banco.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    descricao:{
        type: banco.Sequelize.STRING(45),
        allowNull: false
    },
    votos: {
        type: banco.Sequelize.INTEGER,
        allowNull: true
    },
    status: {
        type: banco.Sequelize.INTEGER,
        allowNull: false
    },
    numero: {
        type: banco.Sequelize.INTEGER,
        allowNull: true
    }
})

Candidatura.belongsTo(Eleitor, {
    foreignKey: 'eleitor_id',
    constraint: true,
    onDelete: 'CASCADE'
});

Candidatura.belongsTo(Eleicao, {
    foreignKey: 'eleicao_id',
    constraint: true,
    onDelete: 'CASCADE'
});

Candidatura.sync()
module.exports = Candidatura