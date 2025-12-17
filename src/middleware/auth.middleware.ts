import {Request, Response, NextFunction} from 'express';
import jwt from 'jsonwebtoken';

export const authenticateToken = (req: Request, res: Response, next: NextFunction) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1] 
    

    if(!token)
        return res.status(401).json({error: 'Accès refusé, Token manquant ou invalide.'});

    const secret = process.env.JWT_SECRET || '';

    jwt.verify(token, secret, (err: any, decoded: any) => {
        if(err)
            return res.status(401).json({error: 'Accès refusé, Token manquant ou invalide.'});

        req.user = decoded
        next();

    });

    

};