-- CreateTable
CREATE TABLE "Paciente" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "numeroIdentificacao" TEXT NOT NULL,
    "idade" INTEGER NOT NULL,
    "encarregado" TEXT NOT NULL,
    "endereco" TEXT NOT NULL,
    "telefoneEncarregado" TEXT NOT NULL,
    "sintomas" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Senha" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "cod" TEXT NOT NULL,
    "prioridade" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "posicaoFila" INTEGER NOT NULL,
    "tempoEspera" INTEGER,
    "emitidoEm" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "iniciadoEm" DATETIME,
    "finalizadoEm" DATETIME,
    "pacienteId" TEXT NOT NULL,
    "usuarioId" TEXT NOT NULL,
    CONSTRAINT "Senha_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES "Paciente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Senha_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Atendimento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "senhaId" TEXT NOT NULL,
    "pacienteId" TEXT NOT NULL,
    CONSTRAINT "Atendimento_senhaId_fkey" FOREIGN KEY ("senhaId") REFERENCES "Senha" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Atendimento_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES "Paciente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Relatorio" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "titulo" TEXT NOT NULL,
    "periodo" TEXT NOT NULL,
    "prioridade" TEXT NOT NULL,
    "dataInicio" DATETIME NOT NULL,
    "dataFinal" DATETIME NOT NULL,
    "senhaId" TEXT NOT NULL,
    CONSTRAINT "Relatorio_senhaId_fkey" FOREIGN KEY ("senhaId") REFERENCES "Senha" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Usuario" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'PACIENTE'
);
INSERT INTO "new_Usuario" ("email", "id", "nome", "password", "role") SELECT "email", "id", "nome", "password", "role" FROM "Usuario";
DROP TABLE "Usuario";
ALTER TABLE "new_Usuario" RENAME TO "Usuario";
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Paciente_numeroIdentificacao_key" ON "Paciente"("numeroIdentificacao");

-- CreateIndex
CREATE UNIQUE INDEX "Senha_cod_key" ON "Senha"("cod");

-- CreateIndex
CREATE UNIQUE INDEX "Atendimento_senhaId_key" ON "Atendimento"("senhaId");
