CREATE TABLE users (id integer primary key, first_name varchar, last_name varchar);
insert into users (id, first_name, last_name) select i, md5(random()::text), md5(random()::text) from generate_series(1, 10000000) s(i);
insert into users (id, first_name, last_name) values(10000001, 'Denis', 'Korobitsin');
CREATE INDEX CONCURRENTLY user_name on users(first_name);