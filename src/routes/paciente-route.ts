import { PacienteController } from "@/controllers/paciente-controller";
import { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";


const pacienteController = new PacienteController()

export async function pacinteRotas(app: FastifyInstance) {
  app.post("/pacientes", async (request: FastifyRequest, reply: FastifyReply) => {
    await  pacienteController.criarPaciente(request, reply)
  })
}