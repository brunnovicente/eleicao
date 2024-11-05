const banco =require('./banco');
const Eleicao = require('./Eleicao');

const Urna = banco.sequelize.define('urnas', {
    id: {
        type: banco.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    descricao:{
        type: banco.Sequelize.STRING(45),
        allowNull: false
    },
    status: {
        type: banco.Sequelize.INTEGER,
        allowNull: true
    },
})

Urna.belongsTo(Eleicao, {
    foreignKey: 'eleicao_id',
    constraint: true,
    onDelete: 'CASCADE'
});


Urna.sync()
module.exports = Urna