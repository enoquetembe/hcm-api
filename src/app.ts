import fastify from 'fastify'
import { pacinteRotas } from './routes/paciente-route'


export const app = fastify()


app.register(pacinteRotas)