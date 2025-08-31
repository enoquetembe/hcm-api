import { prisma } from "@/lib/prisma";
import { FastifyReply, FastifyRequest } from "fastify";

export class PacienteController {

  async criarPaciente (request: FastifyRequest, reply: FastifyReply) {
    try {
      const {nome, numeroIdentificacao, idade,encarregado, telefoneEncarregado, endereco, sintomas } = request.body


      const numeroIdentificacaoExiste  = await prisma.paciente.findUnique({
        where: {
          numeroIdentificacao
        }
      })

      if (numeroIdentificacaoExiste) {
        return reply.code(409).send({
          message: "O numero de identifcacao ja existe!"
        })
      }


      await prisma.paciente.create({
        data: {
          nome,
          numeroIdentificacao,
          idade,
          encarregado,
          telefoneEncarregado,
          endereco,
          sintomas,
        }
      })

      return reply.code(201).send({
        message: "paciente criado com sucesso"
      })


    } catch (error) {
      console.log(error)

      return reply.code(400).send({
        message: "Invalid pacient data"
      })
      
    }

  }

    async getPacientes (request: FastifyRequest, reply: FastifyReply) {
    try {
      
      
     

      return reply.code(201).send({
        message: "paciente criado com sucesso"
      })


    } catch (error) {
      console.log(error)

      return reply.code(500).send({
        message: "Internal server error"
      })
      
    }

  }
}
