#!/bin/bash
# Source code by 0xMorte
# Cronômetro que conta o tempo desde a execução até Ctrl+C
# O cigarro é desenhado **a cada segundo** com o tempo atualizado na última linha.

# --- CORES (reutilizáveis) ---
C='\033[96m\033[1m'   # Ciano negrito (mensagem)
G='\033[90m'          # Cinza (corpo)
O='\033[38;5;208m'    # Laranja (fumaça)
W='\033[97m'          # Branco (papel)
Y='\033[33m'          # Amarelo (brasa)
R='\033[31m'          # Vermelho (filtro)
M='\033[35m'          # Magenta (AFK)
B='\033[1m'           # Negrito
N='\033[0m'           # Reset

# ----- captura de Ctrl+C -------------------------------------------------
trap 'finalizar' INT

finalizar() {
    clear                     # limpa a tela para a última impressão
    desenhar_cigarro "$total_segundos"
    exit 0
}

# ----- função que desenha o cigarro com o tempo formatado ----------------
desenhar_cigarro() {
    local secs=$1
    local min=$(( secs / 60 ))
    local seg=$(( secs % 60 ))
    local tempo_str="${min}m${seg}s"

    cat <<EOF

a,  8a
 \`8, \`8)                            ,adPPRg,
  8)  ]8                        ,ad888888888b
 ,8' ,8'                    ,gPPR888888888888
,8' ,8'                 ,ad8""   \`Y888888888P
8)  8)              ,ad8""        (8888888""
8,  8,          ,ad8""            d888""
\`8, \`8,     ,ad8""            ,ad8""
 \`8, \`\" ,ad8""            ,ad8""
    ,gPPR8b        ,ad8""
   dP:::::Yb      ,ad8""
   8):::::(8  ,ad8""
   Yb:;;;:d888""  0xMorte está AFK
    "8ggg8P"      $tempo_str
EOF
}

# ----- início do cronômetro -----------------------------------------------
inicio=$(date +%s)
clear
echo "Cronômetro iniciado – pressione Ctrl+C para parar"

while :; do
    agora=$(date +%s)
    total_segundos=$(( agora - inicio ))

    # limpa a tela e desenha o cigarro com o tempo atual
    clear
    echo "Fui fumar, já volto!"
    desenhar_cigarro "$total_segundos"

    sleep 1
done