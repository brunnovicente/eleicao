const banco =require('./banco');
const Candidato = require('./Candidato');
const Urna = require('./Urna');

const Voto = banco.sequelize.define('votos', {
    id: {
        type: banco.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    tipo:{
        type: banco.Sequelize.INTEGER,
        allowNull: false
    },
},{
    timestamps: false
})

Voto.belongsTo(Urna, {
    foreignKey: 'urna_id',
    constraint: true,
    onDelete: 'CASCADE'
});

Voto.belongsTo(Candidato, {
    foreignKey: 'candidato_id',
    constraint: true,
    onDelete: 'CASCADE'
})

Voto.sync()
module.exports = Voto