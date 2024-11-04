module.exports = {
    gerarSenha: function (){
        const caracteres = 'abcdefghijklmnopqrstuvwxyz0123456789';
        let senha = '';

        for (let i = 0; i < 5; i++) {
            const randomIndex = Math.floor(Math.random() * caracteres.length);
            senha += caracteres[randomIndex];
        }

        return senha;
    }
}