create database pedido_compra;
go

use pedido_compra
go

create table cliente
(
    id_clie int identity (1,1) primary key not null,
    nm_clie varchar (60) not null,
    doc_clie varchar (15) not null,
    dtnas_clie date
);
go

create table pagamento 
(
    id_pgto int identity (5,5) primary key not null,
    dsc_pgto varchar(30) not null
);
go

create table produto 
(
    id_prod int identity (1,1) primary key not null,
    dsc_prod varchar(40) not null,
    vl_prod numeric (9,2)
);
go

create table pedido
(
    id_ped int identity (10,10) primary key not null,
    id_pgto int not null,
    id_clie int not null,
    dt_ped date,
    tot_ped numeric (10,2),
    constraint pagamento_id_pgto foreign key (id_pgto) references pagamento(id_pgto),
    constraint  cliente_id_clie foreign key (id_clie) references cliente(id_clie)
);
go

create table item_pedido
(
	id_ped int not null,
    id_prod int not null,
    qtd_item_ped numeric(7,2) not null,
    vl_item_ped numeric(9,2) not null,
    constraint pedido_id_ped foreign key (id_ped) references pedido (id_ped),
    constraint produto_id_prod foreign key (id_prod) references produto (id_prod)
);
go

insert into cliente (id_clie,nm_clie,doc_clie,dtnas_clie)
values ('1','Valeria Silva','4332488565','1994-05-20'),
('2','Diego Douglas','14857769875','1998-02-07'),
('3','Larissa Xavier','57863314798','1996-06-11'),
('4','Arthur Silveira','45632178919','2001-07-15'),
('5','Fabiana Yoshida','14725836907','1999-04-02')
go

select * from cliente
go 


insert into pagamento (id_pgto,dsc_pgto)
values ('5','cartao credito'),
('10','cartao debito'),
('15','dinheiro')
go

select * from pagamento
go

insert into produto (id_prod,dsc_prod,vl_prod)
values ('1','Camiseta Feminina','25.50'),
('2','Celular','995.00'),
('3','Oculos de Sol','15.00'),
('4','Jogo de Toalha','30.00'),
('5','Chinelo Slide','35.00'),
('6','Sandalia','44.99'),
('7','Bolsa de Viagem','200.00'),
('8','Blusa de moletom','70.00'),
('9','Camiseta Masculina','25.00'),
('10','Sapato  All Star Couro Feminino','85.00')
go

select * from produto
go


insert into pedido (id_ped,id_pgto,id_clie,dt_ped,tot_ped)
values 
('10','5','1','25-04-2019','2.985.00'),
('20','10','5','24-05-2019','25.00'),
('30','15','3','18-02-2019','200.00'),
('40','10','2','29-04-2019','44.99'),
('50','15','4','30-04-2018','30.00'),
('60','5','6','19-04-2018','170.00'),
('70','10','5','17-02-2019','102.00'),
('80','15','1','15-01-2019','70.00')
go

select * from pedido
go

insert into item_pedido(id_ped,id_prod,qtd_item_ped,vl_item_ped)
values ('60','10','2','85.00'),
('70','1','4','25.00'),
('10','2','3','995.00')
go

select * from item_pedido
go

/*C*/
select nm_clie from cliente order by nm_clie asc 
go

/*D*/
select id_pgto from pagamento order by id_pgto desc
GO

/*E*/
select id_pgto from pagamento where id_pgto = 2;
GO

/*F*/
select nm_clie from cliente where nm_clie like 'M%'
GO

/*G*/
select dsc_pgto from pagamento where dsc_pgto like '%e'
GO

/*H*/
select vl_prd from produto where vl_prd >= 10.00 
GO

/*I*/

select dt_ped from pedido where dt_ped between '10-02-2019' AND '10-05-2019';
GO

/*J*/
select nm_clie,id_ped from cliente  order by nm_clie,id_ped
GO

/*K*/
select id_ped,dt_ped,nm_clie,dsc_pgto,tot_ped
FROM item_pedido
WHERE id_clie > (SELECT id_ped,dt_ped,nm_clie,dsc_pgto,tot_ped
			    FROM item_pedido
			    WHERE id_clie = 2)
go
/*L*/
select dsc_prod from prdoduto order by dsc_prod asc 
go

/*M*/
SELECT id_prod,dsc_prod,vl_prod
FROM produto
WHERE vl_prod < (SELECT avg (vl_prod)
					    FROM produto)
go

/*N*/
SELECT id_prod,dsc_prod,vl_prod
FROM produto
WHERE vl_prod > (SELECT avg (vl_prod)
					    FROM produto)
go

/*O*/
SELECT id_ped,tot_ped
FROM pedido
WHERE tot_ped > (SELECT avg (tot_ped)
					    FROM pedido)
GO

/*P*/

select id_prod 'Id Produto',dsc_prod 'Descrição do Produto',vl_prod	'Valor do Produto' , id_clie 'Id Cliente'
from produto p join item_pedido i on p.id_prod = i.produto 
			   join pedido pe on i.pedido = pe.id_ped
			   join cliente c on c.id_clie = pe.cliente 
GO

/*Q*/
select id_ped,dsc_pgto
FROM item_pedido
WHERE id_clie > (SELECT id_ped,dsc_pgto
			    FROM item_pedido
			    WHERE id_clie = 1)
GO

/*R*/

select pe.id_ped, pe.dt_ped, c.id_clie, c.nm_clie, pa.dsc_pgto, pr.dsc_prod, pr.vl_prod, pe.tot_ped, it.vl_item_ped
from pedido pe	join cliente c on pe.cliente = c.id_clie
				join pagamento pa on pa.id_pgto = pe.pagamento
				join item_pedido it on it.pedido = pe.id_ped
				join produto pr on pr.id_prod = it.produto
order by 
	c.nm_clie,
	pe.id_ped;


/*S*/
SELECT id_ped,tot_ped
FROM pedido
WHERE tot_ped < (SELECT count (tot_ped)
					    FROM pedido
                        WHERE id_clie = 3 )
/*T*/
SELECT id_ped,tot_ped,id_prod,vl_item_ped
FROM item_pedido
WHERE tot_ped < (SELECT sum (tot_ped)
					    FROM produto
                        WHERE id_prod = 4 )
/*U*/

select * from cliente
go 

/*V*/
select * from produto pr 
left join item_pedido it on it.produto = pr.id_prod
left join pedido pe on pe.id_ped = it.pedido;

/*W*/

 select * from cliente c left join pedido pe on pe.cliente = c.id_clie
left join item_pedido it on it.pedido = pe.id_ped;

/*X*/

alter table item_ped
add colummn vl_tot_item 
GO

alter table item_ped 
add colummn qtd_item_ped 
GO

alter table item_ped 
add colummn vl_item_ped
go 
update item_pedido
set vl_tot_item = (qtd_item_ped) * (vl_item_ped)

/*Y*/
create view cliente_pedido as select id_clie, nm_clie, id_ped, dt_ped, vl_tot_ped FROM pedido
GO

SELECT * FROM cliente_pedido
GO

SP_HELP cliente_pedido
GO

/*Z*/
drop database pedido_compra