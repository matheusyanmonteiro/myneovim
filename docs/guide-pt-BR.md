# Guia de estudos — VICARIOUS.NVIM

Este documento ensina a usar a configuração localizada em `~/.config/nvim`.
Ela foi construída em Lua, sem usar uma distribuição pronta como LazyVim,
NvChad ou AstroNvim.

> Neste guia, `<leader>` significa a tecla `Espaço`.

## 1. Começando

Abra o Neovim no diretório de um projeto:

```bash
cd caminho/do/projeto
nvim .
```

Abra somente o dashboard:

```bash
nvim
```

Abra um arquivo específico:

```bash
nvim main.cpp
```

Dentro do Neovim, use `:VicariousDashboard` ou `<leader>ud` para voltar ao
dashboard.

## 2. Como pensar no Vim

O Vim é um editor modal. A mesma tecla faz coisas diferentes dependendo do
modo atual.

| Modo | Para que serve | Como entrar | Como sair |
| --- | --- | --- | --- |
| Normal | navegar e executar comandos | `Esc` | entre em outro modo |
| Inserção | escrever texto | `i`, `a`, `o` | `Esc` |
| Visual | selecionar texto | `v`, `V`, `Ctrl-v` | `Esc` |
| Comando | executar comandos `:` | `:` | `Esc` ou `Enter` |
| Terminal | interagir com o shell | abra o terminal | `Esc Esc` |

Se estiver perdido, pressione `Esc` uma ou duas vezes. Isso normalmente leva
de volta ao modo Normal.

### Formas comuns de começar a escrever

- `i`: inserir antes do cursor.
- `a`: inserir depois do cursor.
- `I`: inserir no começo da linha.
- `A`: inserir no final da linha.
- `o`: criar uma linha abaixo.
- `O`: criar uma linha acima.

## 3. Navegação básica

No modo Normal:

- `h`, `j`, `k`, `l`: esquerda, baixo, cima e direita.
- `w`: próxima palavra.
- `b`: palavra anterior.
- `e`: final da palavra.
- `0`: começo físico da linha.
- `^`: primeiro caractere da linha.
- `$`: final da linha.
- `gg`: primeira linha do arquivo.
- `G`: última linha do arquivo.
- `25G` ou `:25`: ir para a linha 25.
- `%`: alternar entre parênteses, colchetes ou chaves correspondentes.
- `Ctrl-u` e `Ctrl-d`: subir ou descer meia página.
- `Ctrl-o` e `Ctrl-i`: voltar ou avançar no histórico de posições.

A coluna à esquerda usa numeração absoluta: `1, 2, 3...`.

## 4. Editando texto

Os comandos do Vim costumam seguir a ideia `operador + movimento`.

Exemplos:

- `dw`: apagar até a próxima palavra.
- `d$`: apagar até o final da linha.
- `dd`: apagar a linha inteira.
- `cw`: trocar a palavra atual.
- `ci"`: trocar o conteúdo entre aspas.
- `ci{`: trocar o conteúdo entre chaves.
- `yy`: copiar uma linha.
- `p`: colar depois do cursor.
- `P`: colar antes do cursor.
- `u`: desfazer.
- `Ctrl-r`: refazer.
- `.`: repetir a última alteração.

### Seleção visual

- `v`: seleção por caracteres.
- `V`: seleção por linhas.
- `Ctrl-v`: seleção em bloco/coluna.
- `<` e `>`: diminuir ou aumentar indentação mantendo a seleção.
- `y`: copiar a seleção.
- `d`: apagar a seleção.

## 5. Salvar, fechar e sair

- `<leader>w` ou `:write`: salvar.
- `<leader>q` ou `:quit`: fechar a janela atual.
- `:wq`: salvar e sair.
- `:qa`: sair de todas as janelas.
- `:qa!`: sair descartando alterações. Use com cuidado.
- `<leader>bd`: fechar o buffer atual.

O Neovim se recusa a fechar um arquivo modificado sem avisar. Isso protege
trabalho ainda não salvo.

## 6. Dashboard

No dashboard VICARIOUS:

- `N`: criar um buffer vazio.
- `F`: procurar um arquivo.
- `R`: abrir arquivos recentes.
- `P`: pesquisar arquivos do projeto atual.
- `S`: iniciar uma sessão de estudo.
- `Q`: encerrar o Neovim.

O desenho do dashboard se adapta ao tamanho do terminal. Em janelas altas, a
arte completa é exibida; em janelas menores, ela é compactada.

## 7. Arquivos, janelas e buffers

Esses conceitos são diferentes:

- **Arquivo:** conteúdo salvo no disco.
- **Buffer:** arquivo carregado na memória do Neovim.
- **Janela:** uma visualização de um buffer.
- **Tabpage:** um conjunto de janelas.

Atalhos:

- `<leader>e`: abrir ou fechar o Neo-tree.
- `<leader>ff`: procurar arquivos com Telescope.
- `<leader>fg`: procurar texto dentro do projeto.
- `<leader>fb`: listar buffers abertos.
- `<leader>fh`: pesquisar a documentação interna.
- `]b` e `[b`: próximo buffer e buffer anterior.
- `<leader>bl`: último buffer usado.
- `<leader>bd`: fechar o buffer atual.
- `Ctrl-h/j/k/l`: navegar entre janelas.

No Neo-tree, use `Enter` para abrir um arquivo e `?` para consultar os atalhos
disponíveis naquele painel.

## 8. Busca e substituição

- `/texto`: procurar para frente.
- `?texto`: procurar para trás.
- `n`: próxima ocorrência.
- `N`: ocorrência anterior.
- `Esc`: remover o destaque da busca.
- `*`: procurar a palavra sob o cursor.

Substituir na linha atual:

```vim
:s/antigo/novo/g
```

Substituir no arquivo inteiro, pedindo confirmação:

```vim
:%s/antigo/novo/gc
```

Pesquisar texto em todo o projeto:

```text
<leader>fg
```

O Telescope usa `ripgrep` para essa busca.

## 9. Terminal integrado

- `<leader>tt`: abrir ou esconder o terminal inferior.
- `Ctrl-\`: alternar o terminal no modo Normal ou Terminal.
- `Esc Esc`: sair do modo Terminal e voltar ao modo Normal.

O terminal é persistente: escondê-lo não encerra o processo em execução.

## 10. Treesitter e sintaxe

Treesitter cria uma árvore sintática do código. Isso permite destacar funções,
tipos, strings e blocos com mais precisão do que expressões regulares.

Comandos úteis:

```vim
:Inspect
:InspectTree
:TSUpdate
```

- `:Inspect`: mostra os grupos de destaque sob o cursor.
- `:InspectTree`: abre a árvore sintática do arquivo.
- `:TSUpdate`: atualiza os parsers instalados.
- `[c`: sobe para o contexto estrutural atual.

### Visualização Markdown como Obsidian

Arquivos `.md` são renderizados automaticamente no modo Normal. Títulos,
listas, checkboxes, tabelas, links, callouts e blocos de código recebem uma
apresentação visual integrada ao tema VICARIOUS.

- `<leader>mr`: alternar entre Markdown renderizado e texto cru.
- `<leader>mp`: abrir uma pré-visualização renderizada ao lado.
- `:RenderMarkdown toggle`: alternar usando um comando.
- `:RenderMarkdown preview`: abrir a pré-visualização lateral.

Ao entrar no modo Inserção, a linha volta a mostrar a sintaxe Markdown real
para que os caracteres `#`, `*`, `[]` e delimitadores possam ser editados.

Exemplo de callout compatível com Obsidian:

```markdown
> [!NOTE]
> Esta observação será exibida como um bloco destacado.
```

Exemplo de tarefas:

```markdown
- [ ] Estudar movimentos do Vim
- [-] Estudo em andamento
- [x] Instalar o renderizador Markdown
```

## 11. LSP e clangd

LSP significa *Language Server Protocol*. O Neovim é o cliente; `clangd` é o
servidor que entende C e C++.

Atalhos principais:

- `gd`: ir para a definição.
- `gD`: ir para a declaração.
- `gr`: listar referências.
- `gI`: ir para a implementação.
- `K`: mostrar documentação do símbolo.
- `<leader>rn`: renomear um símbolo no projeto.
- `<leader>ca`: mostrar ações de código.
- `<leader>lf`: formatar pelo LSP.
- `<leader>ld`: explicar o diagnóstico da linha.
- `]d` e `[d`: próximo diagnóstico e diagnóstico anterior.

Para conferir se o `clangd` está conectado:

```vim
:LspInfo
:checkhealth vim.lsp
```

O indicador da statusline muda de `LSP OFFLINE` para `LSP CLANGD` quando o
servidor está conectado ao buffer atual.

## 12. Autocomplete e snippets

- `Ctrl-Space`: abrir sugestões manualmente.
- `Tab` e `Shift-Tab`: navegar nas sugestões ou campos de snippet.
- `Enter`: confirmar o item selecionado.
- `Ctrl-b` e `Ctrl-f`: rolar a documentação da sugestão.
- `Ctrl-e`: fechar o menu.

As responsabilidades estão separadas:

- `nvim-cmp`: desenha e controla o menu.
- `cmp-nvim-lsp`: recebe sugestões do LSP.
- `LuaSnip`: expande snippets.
- `friendly-snippets`: fornece snippets prontos.
- `nvim-autopairs`: fecha parênteses, colchetes, chaves e aspas.

## 13. C++

Arquivos C++ usam quatro espaços de indentação. Para compilar o arquivo atual:

```text
<leader>cc
```

O comando usa aproximadamente:

```bash
g++ -std=c++23 -Wall -Wextra -Wpedantic -g arquivo.cpp -o arquivo
```

Erros são enviados para a lista Quickfix:

- `:cwindow`: abrir a lista de erros.
- `:cnext`: próximo erro.
- `:cprevious`: erro anterior.
- `:cclose`: fechar a lista.

Fluxo recomendado:

1. Abra o projeto com `nvim .`.
2. Edite o arquivo `.cpp`.
3. Salve com `<leader>w`.
4. Compile com `<leader>cc`.
5. Corrija erros usando `:cnext` e `:cprevious`.
6. Execute no terminal ou inicie o debugger.

## 14. Git

Gitsigns mostra alterações na coluna de sinais.

- `]h` e `[h`: próximo hunk e hunk anterior.
- `<leader>hs`: adicionar ou remover o hunk do stage.
- `<leader>hr`: descartar o hunk. Confira antes de usar.
- `<leader>hp`: visualizar o hunk.
- `<leader>gb`: blame da linha atual.
- `<leader>gB`: alternar blame contínuo.
- `<leader>gd`: abrir a comparação do projeto com Diffview.
- `<leader>gH`: histórico do arquivo atual.
- `<leader>gc`: fechar o Diffview.

Um **hunk** é um bloco contínuo de linhas modificadas.

## 15. Debug com DAP

Compile o programa com informações de debug (`-g`) antes de iniciar.

- `F5`: iniciar ou continuar.
- `F10`: executar a linha sem entrar em funções.
- `F11`: entrar na função atual.
- `F12`: sair da função atual.
- `<leader>db`: adicionar ou remover breakpoint.
- `<leader>dB`: criar breakpoint condicional.
- `<leader>du`: abrir ou fechar a interface do debugger.
- `<leader>dr`: abrir o REPL.
- `<leader>dt`: encerrar a sessão.

Fluxo de prática:

1. Coloque o cursor numa linha executável.
2. Pressione `<leader>db`.
3. Compile com `<leader>cc`.
4. Pressione `F5`.
5. Escolha o executável sugerido.
6. Observe variáveis, stack e scopes na interface.

## 16. Produtividade

### Comentários

- `gcc`: comentar ou descomentar uma linha.
- `gc` seguido de um movimento: comentar uma região.
- No modo Visual, selecione linhas e use `gc`.

### Surround

- `ys`: adicionar delimitadores.
- `ds`: remover delimitadores.
- `cs`: trocar delimitadores.

Exemplo: com o cursor dentro de `"texto"`, digite `cs"'` para trocar aspas
duplas por simples.

### Flash

- `s`: saltar rapidamente para um texto visível.
- `S`: selecionar uma estrutura do Treesitter.

### Which-key

- `<leader>?`: mostrar os atalhos disponíveis no buffer atual.
- Pressione `<leader>` e aguarde para visualizar grupos de comandos.

## 17. Sessões e Study Mode

Sessões restauram buffers, janelas e diretório de trabalho.

- `<leader>ss`: restaurar a sessão do diretório atual.
- `<leader>sS`: escolher uma sessão.
- `<leader>sl`: restaurar a última sessão.
- `<leader>sd`: não salvar a sessão atual ao sair.

Study Mode:

- `<leader>us`: iniciar ou encerrar.
- `<leader>ui`: mostrar assunto e tempo decorrido.
- `:StudyMode C++`: iniciar diretamente com o assunto `C++`.
- `:StudyStatus`: consultar o estado.

Durante o Study Mode, o cronômetro aparece na statusline.

## 18. Bancada de IA — Codex e Claude

Os dois agentes rodam em terminais controlados pelo Sidekick e reutilizam os
logins dos CLIs instalados na máquina. Nenhuma chave de API fica neste
repositório.

- `<leader>ac`: abrir ou esconder Codex.
- `<leader>aC`: abrir ou esconder Claude (`C` maiúsculo).
- `<leader>aa`: alternar o agente mais recente.
- `<leader>as`: escolher um agente instalado.
- `<leader>ap`: escolher um prompt pronto para estudo, revisão ou testes.
- `<leader>af`: enviar a referência do arquivo atual.
- No modo Visual, `<leader>av`: enviar a seleção.
- `Ctrl-.`: alternar o foco entre código e agente.

Abra o Neovim na raiz do projeto com `nvim .`, pois esse diretório será o
contexto de trabalho da IA. Sempre revise alterações com `<leader>gd` e rode os
testes antes de criar um commit.

O tutorial completo, incluindo exemplos, controles do terminal, segurança e
recuperação depois de formatar o sistema, está em
[`docs/AI_WORKBENCH.md`](AI_WORKBENCH.md).

## 19. Tema e interface VICARIOUS

Arquivos importantes:

```text
~/.config/nvim/
├── init.lua
├── colors/vicarious.lua
├── lua/config/
│   ├── options.lua
│   ├── keymaps.lua
│   ├── lazy.lua
│   └── terminal.lua
├── lua/plugins/
└── lua/vicarious/
    ├── study.lua
    ├── theme/
    │   ├── palette.lua
    │   └── highlights.lua
    └── ui/
        ├── dashboard.lua
        ├── statusline.lua
        └── winbar.lua
```

- `palette.lua`: valores das cores.
- `highlights.lua`: relação entre cores e elementos da interface.
- `dashboard.lua`: desenho e ações da tela inicial.
- `statusline.lua`: barra inferior.
- `winbar.lua`: caminho mostrado acima do arquivo.
- `lua/plugins/*.lua`: configuração de cada plugin.

Depois de editar a configuração, reinicie o Neovim. Para recarregar somente um
módulo durante experiências, é possível usar:

```vim
:lua package.loaded["vicarious.theme.palette"] = nil
```

Reiniciar continua sendo mais seguro enquanto você está aprendendo.

## 20. Lazy e Mason

```vim
:Lazy
:Mason
```

- Lazy instala e atualiza plugins Lua.
- Mason instala ferramentas externas, como `clangd` e `codelldb`.
- O arquivo `lazy-lock.json` fixa os commits dos plugins.

Antes de atualizar tudo, é recomendável manter uma cópia ou commit da
configuração. Se uma atualização quebrar algo, o lockfile ajuda a identificar
o que mudou.

## 21. Ajuda e diagnóstico

O sistema de ajuda do Neovim é uma das ferramentas mais importantes:

```vim
:help
:help motion.txt
:help :substitute
:help lua-guide
:help diagnostic
:checkhealth
```

Dicas:

- Use `<leader>fh` para pesquisar tópicos de ajuda com Telescope.
- Em comandos, pressione `Tab` para completar nomes.
- `:messages` mostra avisos e erros recentes.
- `<leader>un` abre o histórico visual de notificações.
- `:checkhealth` verifica plugins, provedores e ferramentas externas.

## 22. Exercícios progressivos

### Nível 1 — fundamentos

1. Abra este documento no Neovim.
2. Navegue usando somente `hjkl`, `w`, `b`, `gg` e `G`.
3. Crie um arquivo com `:edit treino.txt`.
4. Escreva cinco linhas usando `i`, `o` e `O`.
5. Salve com `<leader>w`.
6. Apague e recupere uma linha usando `dd` e `u`.

### Nível 2 — movimentos e operadores

1. Pratique `dw`, `d$`, `ciw` e `ci"`.
2. Copie três linhas com `3yy` e cole com `p`.
3. Use Visual Line (`V`) para mover ou indentar um bloco.
4. Repita uma edição com `.`.

### Nível 3 — projeto

1. Abra uma pasta com `nvim .`.
2. Encontre um arquivo com `<leader>ff`.
3. Procure uma palavra no projeto com `<leader>fg`.
4. Alterne entre três buffers com `[b` e `]b`.
5. Abra dois arquivos em janelas e navegue com `Ctrl-h/j/k/l`.

### Nível 4 — C++ e LSP

1. Crie um programa C++ pequeno.
2. Confira `LSP CLANGD` na statusline.
3. Use `K`, `gd` e `gr` em um símbolo.
4. Renomeie uma função com `<leader>rn`.
5. Crie um erro, compile e navegue pelo Quickfix.

### Nível 5 — Git e debug

1. Inicialize um repositório de treino.
2. Modifique linhas e navegue pelos hunks.
3. Visualize um hunk antes de adicioná-lo ao stage.
4. Coloque um breakpoint num programa C++.
5. Acompanhe uma variável usando `F10` e `F11`.

### Nível 6 — estudo com IA

1. Abra um projeto de treino com `nvim .`.
2. Selecione uma função e envie com `<leader>av`.
3. Use o prompt `estudar` em `<leader>ap`.
4. Resolva o exercício proposto sem copiar uma resposta pronta.
5. Peça uma revisão ao outro agente e compare as explicações.

## 23. Regra de ouro para aprender

Não tente memorizar tudo de uma vez. Escolha dois ou três comandos, use-os
durante alguns dias e só então acrescente outros. Quando uma ação parecer
repetitiva, procure na ajuda como expressá-la usando um operador e um movimento.

Uma boa rotina diária:

1. Inicie `:StudyMode Neovim`.
2. Escolha um exercício deste guia.
3. Trabalhe por 20 a 30 minutos sem trocar de editor.
4. Anote uma dúvida.
5. Consulte `:help` e experimente a resposta.
6. Encerre com `<leader>us`.
