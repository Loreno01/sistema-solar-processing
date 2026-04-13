# 🧩 Projeto: Sistema Solar com Planetas e Luas no Processing

## 📚 **Estrutura da Atividade**

## ⚙️ *Etapa 1 - Leitura guiada e diagrama*
- **Tarefa:** Em duplas, os alunos fazem um **mapa das transformações** executadas do Sol → Planeta → Lua.  
- **Produto:** Um diagrama simples (papel ou quadro digital) com caixas "Sol", "Planeta i", "Lua de i" e **setas** apontando as transformações.

## 🔄 *Etapa 2 - Explanação do fluxo de atualização*
- **Tarefa:** Identificar onde theta é incrementado, como orbitspeed influencia o movimento, e porque as velocidades das luas podem ser positivas ou negativas (órbita horária/anti-horária).  
- **Produto:** 3–5 bullet points que expliquem update() de Planet e Moon.

## 🚀 *Etapa 3 - Extensão*
Cada dupla implementa as seguintes **modificações preservando a arquitetura:**  
- **1. Planeta com duas luas**
  - Duplicar a composição de Moon em um dos planetas e fazer cada uma ter orbitspeed e distance diferentes. (Extensão direta do padrão proposto no código original.)
- **2. Parâmetros visuais**
  - Atribuir **cores** diferentes aos planetas e **tamanhos** diferenciados às luas. Manter a coerência com os campos diameter, distance e orbitspeed já presentes nas classes.

## 📝 *Etapa 4 - Relatório*
- **Tarefa:** Entregar um **README** (5–10 linhas) respondendo:  
  - 1. Onde você aplicou pushMatrix()/popMatrix() e por quê?  
  - 2. O que mudaria se invertêssemos rotate() e translate() no planeta ou na lua?  
  - 3. Como garantiu que cada órbita é independente das demais? (composição/atualização separada em update() e uso de matrizes aninhadas)

---

## 🎯 **Atividade Realizada**

## ⚙️ *Etapa 1 - Leitura guiada e diagrama*
<img width="921" height="601" alt="diagrama_sistema_solar" src="https://github.com/user-attachments/assets/93ca5a1b-5b75-4ef8-8e9e-f287b1a7755b" />

## 🔄 *Etapa 2 - Explanação do fluxo de atualização*
- **1º:** O valor de *theta* é incrementado ao realizar o update do objeto, tanto do planeta quanto da lua, e é baseado no *orbitspeed*, que é gerado aleatoriamente no construtor da classe.
- **2º:** O *orbitspeed* define a velocidade angular do planeta e da lua.
- **3º:** As velocidades podem ser positivas ou negativas, pois os valores definidos no intervalo de *orbitspeed* variam de -0.1 a 0.1.
- **4º:** Valores negativos de *orbitspeed* fazem com que a rotação seja no sentido anti-horário, e valores positivos fazem com que rotacione no sentido horário.
- **5º:** O update de "lua" é realizado apenas quando for feito o update de "planeta", mantendo assim uma estrutura de execução bem definida, onde uma lua só pode ter seu movimento atualizado em função do planeta ao qual está vinculada.

## 🚀 *Etapa 3 - Extensão*
- Ajustes realizados na pasta/projeto **`SistemaSolar`** presente nesse repositório e podem ser visualizados na figura abaixo:

## 📝 *Etapa 4 - Relatório*
### ***Resposta 1ª pergunta:***
- Onde era necessário garantir uma "desconexão" entre instruções, ou seja, impedir que novas instruções sobrescrevessem as anteriores. Um exemplo é a função `rotate()` utilizada no método `display()` da classe **Lua**, que não deveria afetar o `rotate()` da classe **Planeta**, responsável por invocar o `display()` da **Lua**. Funciona quase como um "empilhamento" de contextos, assegurando que as variáveis de execução do planeta não sejam alteradas pelas variáveis de execução da lua. O `pushMatrix()` inicia o contexto e o `popMatrix()` finaliza.
### ***Resposta 2ª pergunta:***
- Invertendo `rotate()`, é alterado o sentido da rotação dos planetas e das luas para o oposto (valores negativos indicam rotação no sentido anti-horário, enquanto valores positivos indicam rotação no sentido horário). Já ao inverter `translate()`, é alterada a posição de criação dos planetas e das luas (valores negativos posicionam à esquerda, enquanto valores positivos posicionam à direita).
### ***Resposta 3ª pergunta:***
- Por conta da separação da lógica com os métodos `update()`, fazendo com que cada **Planeta** e **Lua** possam ter seu comportamento alterado a qualquer momento. E com o uso de matrizes aninhadas criadas por `pushMatrix()` e `popMatrix()`, cada **Planeta** e **Lua** possui seu próprio escopo independente, evitando que um objeto interfira na criação dos demais.
