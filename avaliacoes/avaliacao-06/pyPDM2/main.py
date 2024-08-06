# app.py
import sqlite3

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

# Conectar ao banco de dados
conn = sqlite3.connect('alunos.db')
cursor = conn.cursor()

# Definir o modelo de dados para o aluno
class Aluno(BaseModel):
    nome: str
    idade: int
    curso: str

# Endpoint para criar um aluno
@app.post("/criar_aluno")
async def criar_aluno(aluno: Aluno):
    cursor.execute("INSERT INTO tb_aluno (nome, idade, curso) VALUES (?, ?, ?)",
    (aluno.nome, aluno.idade, aluno.curso))
    conn.commit()
    return {"mensagem": "Aluno criado com sucesso"}

# Endpoint para listar todos os alunos
@app.get("/listar_alunos")
async def listar_alunos():
    cursor.execute("SELECT * FROM tb_aluno")
    alunos = cursor.fetchall()
    return [{"id": aluno[0], "nome": aluno[1], "idade": aluno[2], "curso": aluno[3]} 
            for aluno in alunos]

# Endpoint para listar um aluno específico
@app.get("/listar_um_aluno/{id}")
async def listar_um_aluno(id: int):
    cursor.execute("SELECT * FROM tb_aluno WHERE id = ?", (id,))
    aluno = cursor.fetchone()
    if aluno:
        return {"id": aluno[0], "nome": aluno[1], "idade": aluno[2], "curso": aluno[3]}
    else:
        raise HTTPException(status_code=404, detail="Aluno não encontrado")

# Endpoint para atualizar um aluno
@app.put("/atualizar_aluno/{id}")
async def atualizar_aluno(id: int, aluno: Aluno):
    cursor.execute("UPDATE tb_aluno SET nome = ?, idade = ?, curso = ? WHERE id = ?", 
    (aluno.nome, aluno.idade, aluno.curso, id))
    conn.commit()
    return {"mensagem": "Aluno atualizado com sucesso"}

# Endpoint para excluir um aluno
@app.delete("/excluir_aluno/{id}")
async def excluir_aluno(id: int):
    cursor.execute("DELETE FROM tb_aluno WHERE id = ?", (id,))
    conn.commit()
    return {"mensagem": "Aluno excluído com sucesso"}