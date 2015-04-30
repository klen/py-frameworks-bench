--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.message DROP CONSTRAINT message_pkey;
ALTER TABLE public.message ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.message_id_seq;
DROP TABLE public.message;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: message; Type: TABLE; Schema: public; Owner: benchmark; Tablespace: 
--

CREATE TABLE message (
    id integer NOT NULL,
    content character varying(512) NOT NULL
);


ALTER TABLE public.message OWNER TO benchmark;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: benchmark
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO benchmark;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: benchmark
--

ALTER SEQUENCE message_id_seq OWNED BY message.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: benchmark
--

ALTER TABLE ONLY message ALTER COLUMN id SET DEFAULT nextval('message_id_seq'::regclass);


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: benchmark
--

COPY message (id, content) FROM stdin;
1	Saepe accusantium excepturi tenetur unde beatae sit. Tenetur id doloremque aspernatur repellendus. Ipsa consequatur dolore sed magni. Suscipit repellendus alias corrupti sunt aut culpa.
2	Ut consectetur id debitis nostrum deserunt. Mollitia qui illum ea qui. Delectus dolor minima ab aliquam voluptatem. Distinctio velit illum et molestias.
3	Quis laboriosam autem error itaque et culpa accusantium aliquid. Quo corrupti debitis tenetur maxime. Consequuntur sed autem dicta molestiae perferendis.
4	Quisquam velit eos repellendus optio repellat rerum. Quaerat saepe qui quia doloribus. Porro dolorem necessitatibus numquam architecto qui illum voluptate.
5	Possimus assumenda cum voluptatem et deserunt debitis voluptas ab. Ea odio placeat provident ut. Nulla occaecati molestiae vel. Aperiam et ipsam adipisci.
6	Id qui placeat aperiam non quod sed consequatur. Voluptas provident eum provident impedit nisi omnis. Ipsam porro ratione voluptatem natus aliquid. Et laboriosam ut beatae libero ipsum.
7	Veniam et soluta iure vel. Et praesentium voluptate laboriosam. Sed provident ipsum quia totam enim maxime accusamus voluptas.
8	Est molestiae tempora dicta voluptatem aspernatur tempora. Itaque mollitia vero nulla beatae. Voluptatem quia adipisci odio ea.
9	Asperiores voluptatem dignissimos voluptates quia. Magni cupiditate labore animi eveniet deserunt. Quidem fugiat distinctio et.
10	Dolorem rem quia porro explicabo iste dolor. Aspernatur natus hic voluptatem possimus voluptatem iste iure sit.
11	Vel aut quo architecto recusandae earum illum. Sequi voluptatem reiciendis deserunt facilis enim distinctio. Voluptatem maxime officia eveniet omnis quia id est quos.
12	Aut facere unde et sint. Autem necessitatibus laudantium labore facere cum blanditiis aut reprehenderit. Quam aut aut dicta quia.
13	Sapiente pariatur sequi eveniet voluptatem quia perspiciatis blanditiis. Quae corrupti excepturi sed similique et optio. Et similique cupiditate odit eos dolorem.
14	Libero rerum quibusdam mollitia fugit id et. Assumenda fugit et sed eligendi beatae expedita quam alias. Dolorem expedita animi ab velit. Sed voluptas beatae deleniti soluta nemo.
15	Qui magni repellendus rem sit facilis numquam nostrum omnis. Eum voluptate sit sit consequuntur. Harum officia occaecati rem iusto ipsum repellendus.
16	Accusantium non iste rem consequatur qui ducimus soluta. Numquam voluptas quis iusto esse. Facere ut aut numquam rerum.
17	Voluptatem et voluptatem tenetur saepe illo facilis. Dolore eaque qui sit voluptas officia. Quo omnis ipsam dolor impedit. Quo vitae delectus quia sunt.
18	Unde ut distinctio aperiam quia. Quas repellendus magni fugit non qui nihil. Et omnis minus reiciendis exercitationem in nesciunt ex et. Et aut aut labore quod.
19	Corrupti laborum voluptatem dolores laudantium et. Ipsum amet minima quia. Et blanditiis impedit aperiam libero et facilis in. Ut quo ipsam fugiat.
20	Dolorum culpa voluptates ea numquam iste aut ratione. Sequi quia quas quia. Qui nam unde et nemo porro nisi molestiae.
21	Sed dignissimos sint consequatur et ad voluptatem perferendis. Maxime ad soluta ut eligendi. Aut aut qui voluptatem odio libero. Perspiciatis quidem aut impedit cumque neque.
22	Sint deleniti excepturi aspernatur ipsum. Odit qui eum nulla. Omnis maiores nostrum qui vel necessitatibus ut sit.
23	Et alias harum placeat velit fugit molestiae sed sed. Hic expedita aliquid consequatur unde aperiam. Molestias sint voluptates sunt ipsa excepturi. Corporis consequuntur rerum quia.
24	Dolores dignissimos accusantium eaque quos. Cupiditate natus laborum ut ad. Qui suscipit fuga quam praesentium sit vitae. Autem et qui architecto adipisci.
25	Quia est adipisci id fugiat qui. Eaque dignissimos inventore ducimus enim eos quia nihil. Beatae aut sint voluptates id exercitationem. Quae nostrum ad sit quasi sunt.
26	Dolore deserunt eos dolorem recusandae voluptatem. Et qui cupiditate ipsam accusamus voluptates. Et sint consequuntur at impedit. Aperiam architecto quibusdam culpa nisi fugit soluta ex.
27	Officiis ut eveniet deserunt. Repellat expedita non minima omnis voluptatibus nisi voluptas.
28	Aut nulla eum labore eum occaecati eius. Et voluptas qui quia nihil aut iure. Qui dolorem maiores ea vero in consequatur.
29	Repellendus at vel minima aut. Exercitationem aperiam eum ducimus. Et odio minima optio atque. Alias perferendis deserunt quo et.
30	Ipsum et explicabo alias eligendi. Nobis praesentium molestias quos dignissimos ipsum id. Et fuga non quod labore. Perferendis non voluptatem autem omnis quaerat.
31	Quia doloremque et fuga qui. Velit officiis ut quia eligendi labore dolorum. Numquam et porro culpa perspiciatis eos. Sed beatae illo alias.
32	Eius sint ea quas sed et ad odit aut. Unde in officia quaerat nisi. Voluptatem harum aspernatur distinctio sunt iure asperiores sit.
33	Necessitatibus quo dolor qui. Suscipit voluptas doloremque provident omnis et harum molestias. Harum fuga et repellat omnis et animi.
34	Pariatur debitis modi neque ducimus recusandae. Ad ut exercitationem eum est quia voluptatum. Nihil ducimus est velit est architecto modi nemo.
35	Mollitia molestiae sunt error asperiores ea voluptatem exercitationem. Ipsum eaque voluptatum qui quas facilis. Qui quia unde delectus vitae nostrum dolores. Sapiente vel possimus quod dolorum.
36	Ut alias expedita aliquid et omnis quam. Debitis nesciunt animi nemo error et omnis. Fuga occaecati aspernatur soluta sunt.
37	Porro enim esse consequatur sit dolorum in laborum itaque. Debitis quis quas fugit qui impedit beatae. Illum sunt esse delectus quisquam dolore ratione vitae blanditiis.
38	Voluptatem voluptate tempore ipsa alias voluptatum voluptas. Soluta qui vitae adipisci dolor quidem. Rerum sit adipisci quia minima. Et magnam iusto qui nemo repudiandae eos.
39	Saepe quo repellendus porro optio unde quas. Molestiae earum et beatae corporis voluptatem. Ab hic dolorum soluta aperiam aspernatur earum. Tempore quasi quia dolor voluptatum.
40	Ea aspernatur eum totam. Porro odio vitae sunt deleniti quasi rerum.
41	Cupiditate pariatur aut nihil sit voluptatem aspernatur. Voluptatibus adipisci quas non.
42	Ut facere et et voluptatibus. Sit nesciunt ipsum deserunt.
43	Ut iste ut in in et. Consequatur ut mollitia occaecati qui consectetur. Dignissimos repellat suscipit earum voluptatem explicabo ipsum dolor. Officiis natus sit ad voluptatibus neque repellendus eos.
44	Illo non quam repellat minus deserunt repudiandae at et. Provident a laborum in velit consequatur sint. Aut aliquid ex in tempora.
45	Provident saepe sapiente repudiandae veritatis soluta dolores labore. Explicabo optio consequatur nisi. Ex occaecati qui ducimus assumenda ea non tenetur. Aut numquam sed autem modi.
46	Aspernatur veniam voluptas est laboriosam molestiae. Voluptas consequuntur vel accusantium quam doloremque. Facere id omnis temporibus rem.
47	Impedit explicabo distinctio quia esse. Sit asperiores est vel est. Dolorem qui ut tempore. Qui officiis officiis minus consequatur temporibus enim.
48	Nostrum odit et est voluptatum dolor qui. Earum eius praesentium qui labore. Non omnis repellat quibusdam corrupti maxime reprehenderit.
49	Eveniet soluta incidunt tempora aut voluptas qui sunt sapiente. Aspernatur sequi doloribus praesentium sapiente quisquam libero qui. Eos ullam quos voluptatem ut id est.
50	Reprehenderit voluptate eum eligendi qui. Quia reprehenderit sed voluptatem sed est ut sunt.
51	Et quia esse quasi aut. Nesciunt dolorem molestias pariatur aspernatur.
52	Minus iste esse veniam ex. Autem ut aut voluptas quo voluptates est. Molestiae repellendus et fugiat provident a ut. Odio qui quisquam amet debitis omnis aliquam suscipit.
53	Beatae asperiores sapiente delectus omnis eos impedit. Distinctio illum dignissimos sint architecto quas. Ut ab expedita et.
54	Quae in dolorem sed. Nihil enim at totam. Sunt quae facilis adipisci occaecati delectus ea. Illo modi qui quia odit non enim sit. Occaecati esse voluptatem labore odit pariatur dolor.
55	Corrupti aliquid consequatur nemo voluptas est. Aut necessitatibus et sed autem.\nVoluptatem rerum doloribus beatae architecto. Animi esse et sunt ab nulla.
56	Deleniti rerum enim perspiciatis eos qui. Possimus architecto placeat quia omnis. Quidem suscipit ipsa est dolor.
57	Ratione laboriosam sed amet facilis. Omnis enim veniam ut eos exercitationem est sint. Explicabo quo dolor odio totam deleniti dolor sit.
58	Nulla porro eos repellendus voluptatem et soluta. Expedita autem ullam blanditiis. Voluptatibus et ipsa enim recusandae itaque et occaecati. Vel sed laboriosam quo qui optio dolorum sunt.
59	Est non rerum dolorem cumque quo suscipit. Quia et itaque doloremque. Voluptate cum quod dignissimos incidunt sed facilis. Alias explicabo recusandae adipisci eaque quia natus.
60	At fugiat doloremque quibusdam delectus. Quasi doloribus reiciendis et vero repellendus ea quis. Fugit sunt magnam ut molestiae quis molestiae officia qui.
61	Consectetur aut ea vel provident laboriosam. Non in iure temporibus in rerum quam. Aliquam quibusdam necessitatibus eius nemo iure.
62	Neque qui optio qui. Eveniet et consequatur iusto ut. Quod quam est quia ex. Inventore sed est sint repellendus.
63	Ducimus atque rerum error incidunt. Saepe rerum repellat suscipit. Corrupti exercitationem voluptas facilis reiciendis ullam rem placeat.
64	Dolore occaecati magni tempore illum iure. Ut sed placeat ut placeat ut. Omnis assumenda a tempora voluptatibus quod molestiae.
65	Voluptatum quasi laborum in aliquid. Quisquam aperiam laudantium eum vel tenetur. Maxime est et saepe perferendis est culpa. Eius sit qui vel qui dignissimos debitis iste et.
66	Et corporis atque dolores corporis. Et quia autem unde quisquam nihil.
67	Explicabo voluptatem voluptas saepe dolore saepe. Qui tenetur numquam quia occaecati velit id.
68	Consequuntur dolores non expedita veritatis. Tenetur magni architecto architecto unde illum sequi tempore. Consequatur impedit voluptatem in aut qui pariatur pariatur.
69	Qui debitis animi ab et non. Aperiam nihil veritatis veniam id omnis explicabo iusto odio. Sint laudantium et ipsa itaque architecto saepe.
70	Ut dolorum qui omnis debitis odit qui atque neque. Sapiente quam quae unde quasi aut veniam quae. Nemo at amet omnis quia est beatae aut. In aut tenetur minus molestiae harum consequatur soluta.
71	Nobis dolorem quisquam voluptatem unde illo. Commodi eum voluptatibus vel ut natus qui praesentium. Dolores dolorum nisi est maiores maxime.
72	Voluptas est sequi aut dolores. Veritatis voluptate officiis vel corrupti nemo officia. Sapiente eos ipsam dicta quos id.
73	Doloremque consequuntur dolore et sint. Sunt cumque voluptas vitae qui. Est dolores ut ex voluptate qui. In eveniet illo quibusdam aspernatur sit eaque.
74	Id atque et iste beatae deleniti laudantium. Exercitationem sit voluptatem inventore distinctio placeat voluptas quibusdam. Facilis ea velit aspernatur accusantium blanditiis nam laboriosam.
75	Rerum provident temporibus quidem praesentium expedita dolorum sequi. Repellendus deserunt qui voluptas. Itaque qui similique vel sapiente.
76	Doloremque quo et earum doloremque. Distinctio illum maiores quia beatae laborum provident ut. Repellat ut sit dolorem et.
77	Iusto odit distinctio ullam. Ex nostrum aut nesciunt. Odit et praesentium illum veniam ut. Qui veritatis asperiores debitis ut et rerum.
78	Velit commodi corporis ipsa totam et numquam eveniet. Fuga doloremque laborum et autem voluptatem. In eveniet et harum. Earum non laborum exercitationem saepe.
79	Et sapiente voluptates expedita aliquid officiis totam. Laudantium dicta dolor distinctio rem. Distinctio ut voluptate nihil quas.
80	Non dolore exercitationem officia. Placeat cupiditate quo pariatur vel nulla et sed. Quas perspiciatis aut odit sed tempora iste quisquam.
81	Tempore pariatur quidem distinctio accusamus modi ut dolore. Cupiditate corporis sequi eligendi laboriosam voluptatum.
82	Numquam veritatis unde iste itaque accusantium autem veritatis. Nihil beatae excepturi error harum pariatur. Nemo quaerat voluptates quod accusantium quia et sint.
83	Eveniet asperiores laborum omnis voluptas consequatur ipsa numquam. Et nemo quibusdam sunt facere. Non quisquam sequi beatae omnis.
84	Molestiae ut minus sit. Quasi nihil tenetur autem enim aut accusamus laborum. Ea doloribus minima eligendi hic molestias et.
85	Laboriosam tempora aspernatur tempora beatae voluptate et et. Quam iusto aliquam voluptas autem laboriosam enim.
86	Vero sit pariatur possimus consequatur. Commodi quia vitae omnis. Non eius labore repellat error.
87	Architecto non deleniti sit dolores. Inventore vero quia ut unde incidunt alias ipsa.
88	Magni illo error numquam et aut. Consectetur sunt voluptatibus suscipit ex unde omnis. Corrupti nesciunt aut consequatur et aut et vitae.
89	Ut unde quia magni tempore minima. Deleniti rerum ullam laudantium eum quos fugit. Voluptatem consequatur voluptate adipisci.
90	Quae quae id laudantium. Accusamus unde non eum ex placeat. Voluptatem aut est laboriosam earum.
91	Rerum cumque amet tempora soluta similique ut. Consequatur maxime tempore assumenda quo tempora. Qui aut earum rerum impedit velit. Libero aperiam exercitationem nulla.
92	Voluptas et facere illum cupiditate necessitatibus placeat quia. Quia sunt animi ratione provident eveniet. At animi eos officia exercitationem provident maxime corrupti.
93	Velit voluptatem ut amet quia fugit temporibus id sed. Et debitis est voluptas. Minus labore omnis et et nihil a adipisci.
94	Sed natus laboriosam hic in quibusdam iure. Non autem labore numquam nobis.\nUt quo est consequatur et eaque voluptatem est. Omnis eligendi eligendi molestias repellat quidem.
95	Et eligendi ratione dicta omnis aperiam. Amet est earum quaerat delectus facilis. Possimus omnis ut amet qui sint.
96	Est maxime placeat laborum et facere iure aut. Et voluptate vel ipsam sit in aperiam iste. Et nulla vero modi rerum consequatur veniam. In quos cumque accusantium.
97	Est sed quae veniam quis id. Voluptas culpa maxime debitis et dolorum tempora eveniet eaque. Blanditiis necessitatibus esse aut enim totam veritatis eligendi.
98	Adipisci magni est ea magnam facilis ea adipisci. Cumque vel culpa magnam deserunt. Provident non dolorem adipisci tempora repellat.
99	Occaecati commodi id qui assumenda dolorem accusantium. Alias aut illo quibusdam. Voluptas a et ipsa.
100	Mollitia et est minima totam voluptatibus id sequi earum. Facere voluptates officia cumque illum non amet nobis. Exercitationem maiores doloribus quia cum fugiat expedita.
\.


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: benchmark
--

SELECT pg_catalog.setval('message_id_seq', 100, true);


--
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: benchmark; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

