# Script de Pós-Instalação do Fedora

Um script abrangente de automação para configurar uma nova instalação do Fedora 41 com softwares essenciais, configurações e ferramentas de desenvolvimento.

>Nota: O script foi projetado para o Fedora Workstation, mas também pode funcionar em outras distribuições baseadas no Fedora. No entanto, tenha cautela e verifique a compatibilidade antes de executá-lo em outros sistemas.

>Importante: Embora o script tenha como objetivo automatizar tarefas de configuração, é essencial revisar o código e entender o que ele faz antes de executá-lo em sua máquina. Certifique-se de fazer backup dos dados críticos antes de prosseguir. O script fornecido é para fins educacionais e não vem com garantia ou suporte.

[Pop!_OS (22.04) - Pós-Instalação](https://github.com/geraldohomero/post-install-pop-os)

## Funcionalidades

- 🔄 Atualizações e Otimização do Sistema
- 📦 Instalação de Softwares Essenciais (DNF & Flatpak)
- 🗂️ Habilitar repositórios RPM Fusion
- 🛠️ Configuração do Ambiente de Desenvolvimento
- 🔧 Configuração de Aliases Personalizados
- 🔐 Integração com GitHub
- 🎮 Suporte para Jogos e Multimídia
- 🎯 Configuração para Desenvolvimento Android

## Estrutura de Diretórios

```bash
post-install-fedora/
├── src/
│ ├── alias.sh # Configuração de aliases personalizados do shell
│ ├── devEnv.sh # Configuração do ambiente de desenvolvimento
│ ├── dnf-config.sh # Otimização do gerenciador de pacotes DNF
│ ├── githubCloneAndConfig.sh # Configuração de repositórios GitHub
│ ├── homeScript.sh # Utilitários de configuração do diretório home para `misc`
│ └── post-install.sh # Script principal de instalação
├── misc/
│ ├── update.sh # Utilitário de atualização do sistema
│ ├── syncthingStatus.sh # Verificador de status do Syncthing
│ └── swapAudio.sh # Utilitário de troca de canais de áudio
└── run.sh # Script principal de execução
```

## Descrição dos Scripts

### Scripts Principais

1. **run.sh**
  - Ponto de entrada para o processo de instalação
  - Orquestra a execução de todos os outros scripts
  - Lida com a configuração inicial e permissões

2. **post-install.sh**
  - Gerencia a instalação de softwares
  - Configura repositórios RPM Fusion
  - Instala pacotes DNF e Flatpak
  - Configura o ambiente SDK do Android

### Scripts Utilitários

3. **alias.sh**
  - Configura aliases personalizados do shell
  - Cria e gerencia o arquivo `.bash_aliases`
  - Integra com o `.bashrc`

4. **dnf-config.sh**
  - Otimiza as configurações do gerenciador de pacotes DNF
  - Melhora a velocidade de download e gerenciamento de pacotes
  - Cria backup da configuração original

5. **devEnv.sh**
  - Configura ferramentas de desenvolvimento
  - Instala Node.js, NVM e outros pacotes de desenvolvimento

6. **githubCloneAndConfig.sh**
  - Configura o CLI do GitHub
  - Clona repositórios do usuário
  - Configurações globais do Git

### Utilitários Diversos

7. **misc/update.sh**
  - Utilitário de atualização do sistema
  - Lida com atualizações DNF e Flatpak
  - Realiza limpeza do sistema

8. **misc/syncthingStatus.sh**
  - Verifica o status do serviço Syncthing

9. **misc/swapAudio.sh**
  - Utilitário para troca de canais de áudio

## Personalizando Aliases

O script inclui vários aliases predefinidos que você pode personalizar. Para modificá-los, edite o array `CUSTOM_ALIASES` em `src/alias.sh`:

```bash
CUSTOM_ALIASES=(
'alias ips="ip -c -br a"'
'alias his="history|grep"'
'alias ports="netstat -tulanp"'
# Adicione seus aliases personalizados aqui
)
```
Aliases comuns incluídos:
- `update`, `upd`, `up`: Executa atualizações do sistema `misc/update.sh`
- `ips`: Mostra endereços IP
- `his`: Pesquisa no histórico de comandos
- `ports`: Mostra portas de rede
- `swap`: Troca a saída de áudio
- `syncstatus`: Verifica o status do Syncthing `misc/syncThingStatus.sh`

## Personalizando a Instalação de Pacotes

Para modificar quais pacotes são instalados, edite os arrays em `src/post-install.sh`:

1. Pacotes DNF:

```bash
PROGRAMS_TO_INSTALL_DNF=(
btop
vim
# Adicione/remova pacotes aqui
)
```

2. Pacotes Flatpak:

```bash
PROGRAMS_TO_INSTALL_FLATPAK=(
org.qbittorrent.qBittorrent
# Adicione/remova pacotes aqui
)
```

## Uso

1. Clone o repositório:

```bash
git clone https://github.com/geraldohomero/post-install-fedora.git
```

2. Torne o script executável:

```bash
chmod +x run.sh
```

3. Execute o script:

```bash
sudo ./run.sh
```

## Pré-requisitos

- Instalação nova do Fedora
- Conexão com a internet
- Privilégios de sudo

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para enviar um Pull Request.