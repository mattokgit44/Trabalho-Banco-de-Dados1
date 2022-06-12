/* https://github.com/mattokgit44/Trabalho-Banco-de-Dados1 */
DROP TABLE IF EXISTS JOGO, JOGADOR, CONTA, PERSONAGEM, INVENTARIO, MOCHILA_TEM_ITENS, MOCHILA, ITENS, GUILD_BANK, GUILDA, SITE, ABAS, PAINEL_USUARIO, FUNCIONARIO, FUNCIONARIO_MONITORA_JOGADOR, ADMINISTRADOR, GAMEMASTER;
CREATE TABLE JOGO(
servidor VARCHAR(10),
mapa VARCHAR(10),
status_jogo INTEGER, /*1-ON 0-OFF 2-MANUTENCAO*/
missoes INTEGER,
tasks INTEGER,
PRIMARY KEY(servidor)
);
CREATE TABLE JOGADOR(
codigo_usuario INTEGER,
email VARCHAR(30),
nome VARCHAR(20),
cpf BIGINT,
data_nascimento DATE,
PRIMARY KEY(codigo_usuario, email)
);
CREATE TABLE CONTA(
codigo_usuario INTEGER,
status_acc VARCHAR(10), /*FREE/PREMIUM*/
login VARCHAR(15),
senha VARCHAR(20),
PRIMARY KEY(codigo_usuario),
FOREIGN KEY(codigo_usuario) REFERENCES JOGADOR(codigo_usuario) ON DELETE CASCADE
);
CREATE TABLE PERSONAGEM(
codigo_person INTEGER,
vocacao VARCHAR(10),
nivel INTEGER,
skills INTEGER,
money INTEGER,
status_person VARCHAR(10),
PRIMARY KEY(codigo_person),
FOREIGN KEY(codigo_person) REFERENCES CONTA(codigo_usuario) ON DELETE CASCADE
);
CREATE TABLE INVENTARIO(
ref_person INTEGER,
capacete VARCHAR(20),
peitoral VARCHAR(20),
calca VARCHAR(20),
bota VARCHAR(20),
mao_prim VARCHAR(20),
mao_sec VARCHAR(20),
PRIMARY KEY(ref_person),
FOREIGN KEY(ref_person) REFERENCES PERSONAGEM(codigo_person) ON DELETE CASCADE
);
CREATE TABLE MOCHILA(
ID integer,
volume INTEGER,
capacidade INTEGER,
skin VARCHAR(10),
peso INTEGER,
PRIMARY KEY(ID),
FOREIGN KEY(ID) REFERENCES INVENTARIO(ref_person) ON DELETE CASCADE
);
CREATE TABLE ITENS(
ID INTEGER,
peso INTEGER,
utilidade VARCHAR(10),
unidades INTEGER,
PRIMARY KEY(ID)
);
CREATE TABLE MOCHILA_TEM_ITENS(
ID_item INTEGER,
ID_mochila INTEGER,
PRIMARY KEY(ID_item, ID_mochila),
FOREIGN KEY(ID_item) REFERENCES ITENS(ID),
FOREIGN KEY(ID_mochila) REFERENCES MOCHILA(ID)
);
CREATE TABLE GUILDA(
ID INTEGER,
mestre_id INTEGER,
rank_guild INTEGER,
membros INTEGER,
PRIMARY KEY(ID, mestre_id),
FOREIGN KEY(mestre_id) REFERENCES PERSONAGEM(codigo_person) ON DELETE CASCADE
);
CREATE TABLE GUILD_BANK(
n_banco INTEGER,
saldo INTEGER,
player_permitido INTEGER,
limite INTEGER,
PRIMARY KEY(n_banco),
FOREIGN KEY (n_banco) REFERENCES GUILDA(ID) ON DELETE CASCADE
);
CREATE TABLE SITE(
url VARCHAR(50),
design VARCHAR(10),
status_site INTEGER, /*1-ON 2-OFF 3-MANUTENCAO*/
PRIMARY KEY (url)
);
CREATE TABLE ABAS(
url VARCHAR(50),
donation VARCHAR(50),
news VARCHAR(50),
forum VARCHAR(50),
shop VARCHAR(50),
PRIMARY KEY(url),
FOREIGN KEY(url) REFERENCES SITE(url) ON DELETE CASCADE
);
CREATE TABLE PAINEL_USUARIO(
person_id INTEGER,
infos VARCHAR(20),
acc_status INTEGER, /*1-OK 2-SUSPENSO*/
gerenciamento_conta VARCHAR(10), /*NORMAL - DELETADO*/
PRIMARY KEY(person_id),
FOREIGN KEY(person_id) REFERENCES JOGADOR(codigo_usuario)
);
CREATE TABLE FUNCIONARIO(
ID INTEGER,
senha VARCHAR(20),
login VARCHAR(15),
PRIMARY KEY(ID)
);
CREATE TABLE FUNCIONARIO_MONITORA_JOGADOR(
ID_funcionario INTEGER,
ID_jogador INTEGER,
PRIMARY KEY(ID_funcionario, ID_jogador),
FOREIGN KEY(ID_funcionario) REFERENCES FUNCIONARIO(ID),
FOREIGN KEY(ID_jogador) REFERENCES JOGADOR(codigo_usuario)
);
CREATE TABLE GAMEMASTER(
ID INTEGER,
nivel_acesso INTEGER, /*NORMALMENTE 3*/
PRIMARY KEY(ID),
FOREIGN KEY(ID) REFERENCES FUNCIONARIO(ID)
);
CREATE TABLE ADMINISTRADOR(
ID INTEGER,
nivel_acesso INTEGER, /*NORMALMENTE 2*/
PRIMARY KEY(ID),
FOREIGN KEY(ID) REFERENCES FUNCIONARIO(ID)
);

INSERT INTO JOGO(servidor, mapa, status_jogo, missoes, tasks) VALUES ("Kronera", "tibia", 1, 36, 68), ("Ocera", "tibia", 1, 52, 124), ("Serenebra", "tibia", 0, 0, 0), ("Descubra", "tibia", 1, 4, 16), ("Antica", "tibia", 2, 27, 0), ("Pacembra", "tibia", 1, 104, 312), ("Luminera", "tibia", 0, 56, 124), ("Belobra", "tibia", 2, 0, 48), ("Relembra", "tibia", 1, 31, 70), ("Ferobra", "tibia", 0, 0, 0);
INSERT INTO JOGADOR (codigo_usuario, email, nome, cpf, data_nascimento) VALUES (131102, "nairbarrela@gmail.com", "Nair Barrela", 11111111111, (STR_TO_DATE("06-12-2003", "%m-%d-%Y"))), (654327, "ariansouza@gmail.com", "Arian Souza", 22222222222, (STR_TO_DATE("01-04-2002", "%m-%d-%Y"))), (851351, "josiasrico@gmail.com", "Josias Rico", 33333333333, (STR_TO_DATE("07-15-1997", "%m-%d-%Y"))), (358421, "lucasneves@gmail.com", "Luvas Neves", 44444444444, (STR_TO_DATE("11-13-1996", "%m-%d-%Y"))), (657611, "diegotoledo@gmail.com", "Diego Toledo", 55555555555, (STR_TO_DATE("09-18-2001", "%m-%d-%Y"))), (843298, "gabrielvenancio@gmail.com", "Gabriel Venancio", 66666666666, (STR_TO_DATE("05-16-2003", "%m-%d-%Y"))), (321482, "cleberpilla@gmail.com", "Cleber Pilla", 77777777777, (STR_TO_DATE("04-20-2004", "%m-%d-%Y"))), (984651, "rubenmadeira@gmail.com", "Ruben Madeira", 88888888888, (STR_TO_DATE("05-18-2000", "%m-%d-%Y"))), (476285, "julionagaita@gmail.com", "Julio Nagaita", 99999999999, (STR_TO_DATE("06-14-1998", "%m-%d-%Y"))), (794612, "ismailstort@gmail.com", "Ismail Storti", 12345678912, (STR_TO_DATE("04-20-2003", "%m-%d-%Y")));
INSERT INTO CONTA (codigo_usuario, status_acc, login, senha) VALUES (131102, "FREE", "131102", "201131"), (654327 , "FREE", "654327", "723456"), (851351 , "PREMIUM", "851351", "153158"), (358421 , "FREE", "358421", "124853"), (657611 , "FREE", "657611", "116756"), (843298 , "PREMIUM", "843298", "892348"), (321482 , "PREMIUM", "321482", "284123"), (984651, "FREE", "984651", "156489"), ( 476285, "FREE", "476285", "582674"), (794612 , "PREMIUM", "794612", "216497");
INSERT INTO PERSONAGEM (codigo_person, vocacao, nivel, skills, money, status_person) VALUES (131102, "Sorcerer", 118, 82, 148202103, "OFFLINE"), (654327, "Druid", 284, 98, 284702103, "ONLINE"), (851351, "Knight", 52, 60, 300846, "ONLINE"), (358421, "Sorcerer", 42, 52, 100310, "ONLINE"), (657611, "Sorcerer", 21, 8, 12450, "OFFLINE"), (843298, "Paladin", 514, 112, 305210210, "ONLINE"), (321482, "Knight", 12, 4, 38652, "OFFLINE"), (984651, "Druid", 38, 40, 3845124, "ONLINE"), (476285, "Sorcerer", 8, 4, 22103, "OFFLINE"), (794612, "Paladin", 510, 113, 268420213, "OFFLINE");
INSERT INTO INVENTARIO (ref_person, capacete, peitoral, calca, bota, mao_prim, mao_sec) VALUES (131102, "HOTM", "FC", "BL", "BOH", "IW", "SB"), (654327 , "HOTM", "FC", "BL", "BOH", "NR", "MSB"), (851351, "SH", "DA", "DL", "LB", "FS", "DS"), (358421 , "MC", "MT", "TL", "WB", "FW", "SB"), (657611 , "HOTM", "SC", "GL", "BOH", "VW", "SB"), (843298 , "RH", "MPA", "GL", "BOH", "EB", "BQ"), (321482, "BH", "BA", "BL", "LB", "SS", "SSH"), (984651 , "MC", "MR", "LL", "LB", "SR", "SB"), (476285 , "PH", "PC", "PL", "LB", "SR", "SB"), (794612 , "SH", "MPA", "BL", "BOH", "EB", "RQ");
INSERT INTO MOCHILA (ID, volume, capacidade, skin, peso) VALUES (131102, 25, 1000, "NB", 618), (654327, 25, 1000, "NB", 340), (851351, 25, 1000, "NB", 884), (358421, 25, 1000, "NB", 212), (657611, 25, 1000, "NB", 416), (843298, 30, 2000, "DB", 1463), (321482, 25, 1000, "NB", 174), (984651, 25, 1000, "NB", 700), (476285, 30, 2000, "LB", 708), (794612, 25, 1000, "NB", 314);
INSERT INTO ITENS (ID, peso, utilidade, unidades) VALUES (1 , 100, "Ferramenta", 1), (2 , 315, "Ataque", 60), (3 , 615, "Missao", 2), (4 , 10, "Espolio", 100), (5 , 120, "Equipavel", 1), (6 , 240, "Equipavel", 1), (7 , 500, "Consumivel", 50), (8 , 324, "Consumivel", 20), (9 , 115, "Decorativo", 57), (10 , 5, "Consumivel", 5);
INSERT INTO MOCHILA_TEM_ITENS(ID_item, ID_mochila) VALUES (1 , 131102), (2 , 654327), (3 , 851351), (4 , 358421), (5 , 657611), (6 , 843298), (7 , 321482), (8 , 984651), (9 , 476285), (10 , 794612);
INSERT INTO GUILDA (ID, mestre_id, rank_guild, membros) VALUES (111 , 131102, 3, 1), (112 , 654327, 8, 1), (113 , 851351, 1, 1), (114 , 358421, 4, 1), (115 , 657611, 2, 1), (116 , 843298, 5, 1), (117 , 321482, 9, 1), (118 , 984651, 7, 1), (119 , 476285, 6, 1), (120 , 794612, 10, 1);
INSERT INTO GUILD_BANK (n_banco, saldo, player_permitido, limite) VALUES (111, 1000000, 131102, 10000000), (112, 500000, 654327, 10000000), (113, 35000000, 851351, 10000000), (114, 990000, 358421, 10000000), (115, 20000000, 657611, 10000000), (116, 600000, 843298, 10000000), (117, 320000, 321482, 10000000), (118, 3100000, 984651, 10000000), (119, 150000, 476285, 10000000), (120, 10000000, 794612, 10000000);
INSERT INTO SITE (url, design, status_site) VALUES ("jogo.com.br", "dark", 1), ("jogo.com.uk", "dark", 1), ("jogo.com.de", "dark", 1), ("jogo.com.jp", "dark", 1), ("jogo.com.eu", "dark", 1), ("jogo.com.au", "dark", 1), ("jogo.com.site", "dark", 3), ("jogo.com.xyz", "dark", 3), ("jogo.com.io", "dark", 3), ("jogo.github.io", "dark", 2);
INSERT INTO ABAS (url, donation, news, forum, shop) VALUES ("jogo.com.br", "/donation", "/news", "/forum", "/shop"), ("jogo.com.uk", "/donation", "/news", "/forum", "/shop"), ("jogo.com.de", "/donation", "/news", "/forum", "/shop"), ("jogo.com.jp", "/donation", "/news", "/forum", "/shop"), ("jogo.com.eu", "/donation", "/news", "/forum", "/shop"), ("jogo.com.au", "/donation", "/news", "/forum", "/shop"), ("jogo.com.site", "/donation", "/news", "/forum", "/shop"), ("jogo.com.xyz", "/donation", "/news", "/forum", "/shop"), ("jogo.com.io", "/donation", "/news", "/forum", "/shop"), ("jogo.github.io", "/donation", "/news", "/forum", "/shop");
INSERT INTO PAINEL_USUARIO (person_id, infos, acc_status, gerenciamento_conta) VALUES (131102 , "OFF", 1, "NORMAL"), (654327 , "ON", 1, "NORMAL"), (851351 , "ON", 1, "NORMAL"), (358421 , "ON", 1, "NORMAL"), (657611 , "OFF", 1, "NORMAL"), (843298 , "ON", 1, "NORMAL"), (321482 , "OFF", 1, "NORMAL"), (984651 , "ON", 1, "NORMAL"), (476285 , "OFF", 1, "NORMAL"), (794612 , "OFF", 1, "NORMAL");
INSERT INTO FUNCIONARIO (ID, senha, login) VALUES (0111 , "AAAA", "BBBB"), (0112 , "BBBB", "CCCC"), (0113 , "CCCC", "DDDD"), (0114 , "DDDD", "EEEE"), (0115 , "EEEE", "FFFF"), (0116 , "FFFF", "GGGG"), (0117 , "GGGG", "HHHH"), (0118 , "HHHH", "IIII"), (0119 , "IIII", "JJJJ"), (0120 , "JJJJ", "Walter");
INSERT INTO FUNCIONARIO_MONITORA_JOGADOR (ID_funcionario, ID_jogador) VALUES (0111 , 131102), (0112 , 654327), (0113 , 851351), (0114 , 358421), (0115 , 657611), (0116 , 843298), (0117 , 321482), (0118 , 984651), (0119 , 476285), (0120 , 794612);
INSERT INTO GAMEMASTER (ID, nivel_acesso) VALUES (0111, 3), (0112, 3), (0113, 3);
INSERT INTO ADMINISTRADOR (ID, nivel_acesso) VALUES (0114, 2), (0115, 2), (0116, 2), (0117, 2), (0118, 2), (0119, 2), (0120, 2);