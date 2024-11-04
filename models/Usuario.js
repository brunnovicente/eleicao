const banco =require('./banco');
const Eleitor =require('./Eleitor');

const User = banco.sequelize.define('usuarios', {
    id: {
        type: banco.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    username: {
        type: banco.Sequelize.STRING(45),
        allowNull: false
    },
    password: {
        type: banco.Sequelize.STRING(250),
        allowNull: false
    },
    categoria:{
        type: banco.Sequelize.INTEGER,
        default: 0
    },
    codigo: {
        type: banco.Sequelize.STRING(45),
    },
    status: {
        type: banco.Sequelize.INTEGER,
        default: 0
    },
})

User.belongsTo(Eleitor, {
    foreignKey: 'eleitor_id',
    constraint: true,
});

User.sync()

module.exports = User