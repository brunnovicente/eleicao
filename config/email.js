// config/nodemailerConfig.js
const nodemailer = require('nodemailer');

// Looking to send emails in production? Check out our Email API/SMTP product!
var transport = nodemailer.createTransport({
    host: "smtp.hostinger.com",
    port: 465,
    auth: {
        user: "coordenacao@gestaoedu.com",
        pass: "Bat#1104"
    }
});

module.exports = transport;