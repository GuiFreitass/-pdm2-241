# test_requests.py
import requests

# URL base da API
base_url = "http://localhost:8000"

# Função para criar um aluno
def criar_aluno(nome, idade, curso):
    url = f"{base_url}/criar_aluno"
    data = {
        "nome": nome,
        "idade": idade,
        "curso": curso
    }
    response = requests.post(url, json=data)
    print(response.json())

# Função para listar todos os alunos
def listar_alunos():
    url = f"{base_url}/listar_alunos"
    response = requests.get(url)
    print(response.json())

# Função para listar um aluno específico
def listar_um_aluno(aluno_id):
    url = f"{base_url}/listar_um_aluno/{aluno_id}"
    response = requests.get(url)
    print(response.json())

# Função para atualizar um aluno
def atualizar_aluno(aluno_id, nome, idade, curso):
    url = f"{base_url}/atualizar_aluno/{aluno_id}"
    data = {
        "nome": nome,
        "idade": idade,
        "curso": curso
    }
    response = requests.put(url, json=data)
    print(response.json())

# Função para excluir um aluno
def excluir_aluno(aluno_id):
    url = f"{base_url}/excluir_aluno/{aluno_id}"
    response = requests.delete(url)
    print(response.json())

# Testes
criar_aluno("João", 20, "Engenharia")
listar_alunos()
listar_um_aluno(1)
atualizar_aluno(1, "João Silva", 21, "Engenharia de Software")
listar_um_aluno(1)
excluir_aluno(1)
listar_alunos()
