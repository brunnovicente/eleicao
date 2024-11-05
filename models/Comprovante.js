const banco = require('./banco');
const Eleicao = require('./Eleicao');
const Eleitor = require('./Eleitor');

const Comprovante = banco.sequelize.define('comprovantes', {
    id: {
        type: banco.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    }
});

Comprovante.belongsTo(Eleitor, {
    foreignKey: 'eleitor_id',
    constraint: true,
    onDelete: 'CASCADE'
});
Comprovante.belongsTo(Eleicao, {
    foreignKey: 'eleicao_id',
    constraint: true,
    onDelete: 'CASCADE'
});

// Sincroniza o modelo com o banco de dados, criando a tabela se necessário
Comprovante.sync();

module.exports = Comprovante;