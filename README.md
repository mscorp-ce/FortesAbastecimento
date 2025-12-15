# ⛽ FortesAbastecimento

![[Delphi](https://img.shields.io/badge/Delphi-12-Athena-blue)](https://img.shields.io/badge/Language-Delphi-blue)
![Firebird](https://img.shields.io/badge/Firebird-2.5-orange)
![VCL](https://img.shields.io/badge/Framework-VCL-lightgrey)
![License](https://img.shields.io/badge/License-MIT-green)

O **FortesAbastecimento** é um sistema de gestão de **abastecimentos e tanques de combustíveis** desenvolvido em Delphi, projetado para o posto ABC. O sistema permite controlar cada abastecimento, registrar impostos e gerar relatórios detalhados por dia, tanque e bomba.

---

## 📋 Índice
- [Descrição](#-descrição)
- [Funcionalidades Principais](#-funcionalidades-principais)
- [Arquitetura](#-arquitetura)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Como Instalar](#-como-instalar)
- [Como Usar](#-como-usar)
- [Contribuição](#-contribuição)
- [Licença](#-licença)

---

## 📝 Descrição

O **FortesAbastecimento** permite:

- Controlar tanques e bombas de combustíveis ⛽
- Registrar quantidade de litros e valor total 💰
- Aplicar automaticamente o **imposto de 13%** sobre o valor
- Gerar relatórios agrupados por **dia, tanque e bomba**, com total do período 📊

O sistema foi desenvolvido seguindo **princípios SOLID**, baixo acoplamento e alta coesão, garantindo manutenibilidade e confiabilidade.

---

## ⚡ Funcionalidades Principais

### 🛢 Gestão de Abastecimentos
- Registrar novos abastecimentos
- Atualizar ou excluir registros
- Validar dados obrigatórios: bomba cadastrada, litros > 0, valor > 0

### 📊 Relatórios
- Agrupar abastecimentos por dia, tanque e bomba
- Mostrar o total do período
- Exportar relatórios para análise (opcional)

### ✅ Validação e Regras de Negócio
- Imposto de 13% aplicado automaticamente
- Controle de bombas e tanques: 2 de gasolina e 2 de diesel
- Mensagens de erro claras para guiar o usuário

---

## 🏛 Arquitetura

- **Camadas separadas:** Serviços, Repositórios, Entidades  
- **Repository Pattern:** Abstrai acesso ao banco de dados  
- **Factory Pattern:** Centraliza criação de objetos complexos  
- **Testes Unitários:** Cobertura com **DUnitX**  

---

## 🛠 Tecnologias Utilizadas

- **Linguagem:** Delphi 12 (Athena)  
- **Banco de Dados:** Firebird 2.5  
- **Framework:** VCL (Visual Component Library)  
- **Padrões de Projeto:** Repository, Factory  
- **Coleções Genéricas:** `System.Generics.Collections`  
- **Testes:** DUnitX  

---

## ⚙️ Como Instalar

### Pré-requisitos
- Delphi IDE (compatível com FireDAC)  
- Firebird 2.5 instalado e configurado  
- Conexão ativa com o banco de dados  

### Passos
1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/FortesAbastecimento.git
