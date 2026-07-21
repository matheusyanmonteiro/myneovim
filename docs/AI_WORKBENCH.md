# Bancada de IA — Codex e Claude dentro do Neovim

O VICARIOUS.NVIM usa o `sidekick.nvim` como ponte entre o editor e os CLIs
oficiais do Codex e do Claude. Nenhuma chave de API fica na configuracao: cada
agente reutiliza a autenticacao do seu proprio programa de terminal.

## Modelo mental

```text
buffer / selecao / diagnosticos
              │
              ▼
       sidekick.nvim
          │       │
          ▼       ▼
       codex     claude
          │       │
          └── arquivos do projeto
```

O Sidekick cuida da janela, do envio de contexto e da deteccao de arquivos
alterados. O Codex ou o Claude continua sendo o agente que raciocina, pede
permissoes, edita arquivos e executa comandos.

Escolhemos uma ponte unica em vez de dois paineis diferentes porque isso mantem
os mesmos atalhos e a mesma forma de enviar contexto para ambos os agentes. O
recurso de sugestoes do GitHub Copilot foi desativado: esta bancada depende
somente dos dois CLIs que voce ja possui.

## Conferencia inicial

No terminal, confirme:

```bash
codex --version
claude --version
```

Depois abra um projeto a partir de sua raiz:

```bash
cd caminho/do/projeto
nvim .
```

O diretorio em que o Neovim foi aberto e o diretorio de trabalho dos agentes.
Isso e importante: abra a raiz correta para que eles encontrem codigo, testes e
documentacao.

Dentro do Neovim, o diagnostico completo e:

```vim
:checkhealth sidekick
```

## Atalhos principais

`<leader>` significa Espaco.

| Atalho | Acao |
| --- | --- |
| `<leader>ac` | abrir ou esconder o Codex |
| `<leader>aC` | abrir ou esconder o Claude (`C` maiusculo) |
| `<leader>aa` | alternar o agente usado mais recentemente |
| `<leader>as` | escolher entre os agentes instalados |
| `<leader>ap` | escolher um prompt pronto |
| `<leader>at` | enviar a posicao ou selecao atual |
| `<leader>af` | enviar a referencia do arquivo atual |
| `<leader>av` | enviar a selecao visual |
| `<leader>ad` | encerrar a sessao de agente atual |
| `Ctrl-.` | focar o agente ou retornar ao editor |

O indicador `AI` aparece na statusline quando existe uma sessao ativa. `AI 2`
significa que Codex e Claude estao abertos ao mesmo tempo.

## Primeiro fluxo com Codex

1. Abra o projeto com `nvim .`.
2. Pressione `<leader>ac`.
3. No painel da direita, descreva uma tarefa e pressione `Enter`.
4. Use `Ctrl-.` para voltar rapidamente ao codigo.
5. Confira as alteracoes com `<leader>gd` ou `:DiffviewOpen`.

Exemplo de pedido:

```text
Explique a arquitetura deste projeto antes de alterar qualquer arquivo.
Depois proponha tres pequenas tarefas para eu praticar.
```

Comandos particularmente uteis no Codex:

```text
/status        mostra diretorio, modelo e configuracao da sessao
/permissions   define o que o agente pode fazer
/model         escolhe modelo e nivel de raciocinio
/review        revisa mudancas locais
/init          cria instrucoes AGENTS.md para o projeto
```

## Primeiro fluxo com Claude

1. Pressione `<leader>aC`.
2. Converse normalmente no painel da direita.
3. Use `Ctrl-.` para alternar entre o painel e o codigo.
4. Digite `/help` dentro do Claude para consultar os comandos da versao
   instalada.

Exemplo de pedido:

```text
Leia este projeto como um professor. Construa um mapa mental dos modulos e me
faca perguntas para verificar se eu entendi.
```

Codex e Claude podem ficar abertos ao mesmo tempo, mas evite pedir que ambos
editem os mesmos arquivos simultaneamente. Use um para implementar e o outro
para revisar somente depois que a primeira tarefa terminar.

## Enviando contexto do editor

### Selecao visual

1. Use `v` ou `V` para selecionar codigo.
2. Pressione `<leader>av`.
3. Complete o pedido no painel do agente, se necessario.

Esse e o melhor fluxo para entender uma funcao pequena ou revisar apenas um
trecho.

### Arquivo atual

Pressione `<leader>af`. O agente recebe a referencia do arquivo e pode le-lo no
projeto. Use isso para revisoes completas ou para pedir testes.

### Posicao atual

Pressione `<leader>at` no modo Normal para enviar arquivo, linha e coluna. No
modo Visual, o mesmo atalho usa a selecao atual. Isso evita colar blocos grandes
na conversa e preserva a localizacao exata do problema.

### Diagnosticos e prompts prontos

Pressione `<leader>ap` e escolha uma receita. Alem das receitas do Sidekick, a
configuracao inclui:

- `estudar`: explicacao progressiva e exercicio final;
- `explicar`: explicacao das decisoes importantes;
- `diagnosticos`: causa e correcao minima para erros do LSP;
- `revisar`: revisao orientada a bugs, riscos e testes;
- `testes`: geracao de testes com a finalidade de cada caso;
- `cpp`: revisao C++23 de ownership, lifetime e complexidade.

## Controles dentro do painel

| Tecla | Acao |
| --- | --- |
| `Ctrl-z` | voltar ao editor sem esconder o agente |
| `Ctrl-.` | esconder o painel |
| `Ctrl-p` | abrir o seletor de prompt ou contexto |
| `Ctrl-f` | escolher arquivos para enviar |
| `Ctrl-b` | escolher buffers para enviar |
| `Ctrl-q` | sair do modo Terminal; pressione novamente para esconder |
| `q` | esconder quando estiver no modo Normal |

Esconder a janela nao encerra o processo. `<leader>ad` encerra a sessao atual.
Como `tmux` nao e obrigatorio nesta configuracao, as sessoes terminam quando o
Neovim e fechado.

## Rotina segura de trabalho

Agentes podem editar varios arquivos e executar comandos. Adote este ciclo:

1. Use Git e comece com `git status` limpo.
2. Diga claramente se quer apenas explicacao, plano, revisao ou implementacao.
3. Leia pedidos de permissao do CLI antes de aceitar.
4. Depois da tarefa, use `<leader>gd` para revisar o diff.
5. Rode testes e compilacao localmente.
6. So entao crie um commit.

As permissoes pertencem ao Codex ou ao Claude; o Sidekick nao ignora nem amplia
essas permissoes. Tambem nao copie senhas, tokens ou dados privados para o chat.

## Rotina de estudo recomendada

1. Inicie `<leader>us` com um assunto.
2. Selecione um trecho dificil com `V`.
3. Envie com `<leader>av`.
4. Abra `<leader>ap` e use `estudar`.
5. Resolva o exercicio sem pedir a resposta imediatamente.
6. Peca ao outro agente para avaliar sua explicacao.
7. Registre as conclusoes em um arquivo Markdown renderizado.

Uma boa divisao de papeis e usar o Codex para executar e testar mudancas e o
Claude para uma segunda explicacao ou revisao conceitual. Isso e uma estrategia
de estudo, nao uma regra tecnica.

## Reinstalacao e autenticacao

O repositorio guarda a configuracao e a versao do plugin, mas nao guarda login,
historico privado ou credenciais. Depois de formatar o sistema:

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
curl -fsSL https://claude.ai/install.sh | bash
codex
claude
```

Siga o login interativo de cada CLI, reinicie o Neovim e execute:

```vim
:checkhealth sidekick
```

Documentacao oficial:

- [Codex CLI](https://developers.openai.com/codex/cli)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code/getting-started)
- [sidekick.nvim](https://github.com/folke/sidekick.nvim)

## Solucao de problemas

Se um agente nao aparecer:

```bash
which codex
which claude
```

O Neovim precisa ser iniciado por um shell cujo `PATH` encontre esses comandos.
Se o comando funciona no terminal mas nao no editor, feche todas as janelas do
Neovim, abra um novo terminal e tente novamente.

Outros diagnosticos:

```vim
:checkhealth sidekick
:messages
:Lazy
```

Se um arquivo alterado externamente nao atualizar, salve ou descarte primeiro
qualquer mudanca local e execute `:checktime`.
