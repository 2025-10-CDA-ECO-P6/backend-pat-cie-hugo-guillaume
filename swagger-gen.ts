import swaggerAutogen from 'swagger-autogen';

const doc = {
  info: {
    title: 'API Patte & Cie',
    description: 'Documentation générée automatiquement',
    version: '1.0.0',
  },
  host: 'localhost:3000',
  schemes: ['http'],
};

const outputFile = './src/swagger-output.json';
const routes = ['./src/app.ts']; 

swaggerAutogen({ openapi: '3.0.0' })(outputFile, routes, doc).then(() => {
    console.log('Documentation générée avec succès !');
});