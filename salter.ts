import * as bcrypt from 'bcrypt';
import * as dotenv from 'dotenv';

dotenv.config();

const args = process.argv;


if(args[2] == undefined){
    const saltRounds = 10;
    bcrypt.genSalt(saltRounds, (err, salt) => {
        if (err) throw err;
        console.log('Generated salt:', salt);
    });
}else{
    const password = args[2];
    const salt = process.env.BCRYPT_SALT || undefined;


    if (!password || !salt) {
        console.error('Both password and salt must be provided.');
        process.exit(1);
    }

    const hashedPassword = await bcrypt.hash(password, salt);

    console.log('Hashed password : ', hashedPassword);
}