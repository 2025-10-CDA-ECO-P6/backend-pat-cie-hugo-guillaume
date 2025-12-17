import { Request, Response } from 'express';
import prisma from '../prismaClient';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';


export const login = async (req: Request, res: Response) => {
    const {email, password} = req.body;
    try{
        const user = await prisma.utilisateur.findUnique({where: {email}});

        if (!user)
            return res.status(401).json({message: 'Email ou mot de passe incorrect'});

        const salt = process.env.BCRYPT_SALT || '';
        
        const isValidPassword = await bcrypt.compare(password || '', user.mot_de_passe);

        if (!isValidPassword)
            return res.status(401).json({message: 'Email ou mot de passe incorrect'});

        const secret = process.env.JWT_SECRET || '';

        const token = jwt.sign(
            {userId: user.id, role: user.role},
            secret,
            {expiresIn: '24h'}
        );

        res.json({
            message: 'Connexion réussie',
            token,
            user: {
                id: user.id,
                nom: user.nom,
                role: user.role
            }
        });

    }catch(error){
        console.error(error);
        res.status(500).json({message: 'Internal server error'});
    }
};

