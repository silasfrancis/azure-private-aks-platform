--
-- francis_userQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: francis_user
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO francis_user;

--
-- Name: article; Type: TABLE; Schema: public; Owner: francis_user
--

CREATE TABLE public.article (
    id integer NOT NULL,
    author_id integer NOT NULL,
    slug character varying NOT NULL,
    title character varying NOT NULL,
    description character varying NOT NULL,
    body character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.article OWNER TO francis_user;

--
-- Name: article_id_seq; Type: SEQUENCE; Schema: public; Owner: francis_user
--

CREATE SEQUENCE public.article_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.article_id_seq OWNER TO francis_user;

--
-- Name: article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: francis_user
--

ALTER SEQUENCE public.article_id_seq OWNED BY public.article.id;


--
-- Name: article_tag; Type: TABLE; Schema: public; Owner: francis_user
--

CREATE TABLE public.article_tag (
    article_id integer NOT NULL,
    tag_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.article_tag OWNER TO francis_user;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: francis_user
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    article_id integer NOT NULL,
    author_id integer NOT NULL,
    body character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.comment OWNER TO francis_user;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: francis_user
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_id_seq OWNER TO francis_user;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: francis_user
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: favorite; Type: TABLE; Schema: public; Owner: francis_user
--

CREATE TABLE public.favorite (
    user_id integer NOT NULL,
    article_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.favorite OWNER TO francis_user;

--
-- Name: follower; Type: TABLE; Schema: public; Owner: francis_user
--

CREATE TABLE public.follower (
    follower_id integer NOT NULL,
    following_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.follower OWNER TO francis_user;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: francis_user
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    tag character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.tag OWNER TO francis_user;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: francis_user
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tag_id_seq OWNER TO francis_user;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: francis_user
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: francis_user
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    password_hash character varying NOT NULL,
    bio character varying NOT NULL,
    image_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public."user" OWNER TO francis_user;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: francis_user
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO francis_user;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: francis_user
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: article id; Type: DEFAULT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.article ALTER COLUMN id SET DEFAULT nextval('public.article_id_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: francis_user
--

COPY public.alembic_version (version_num) FROM stdin;
666cc53a93be
\.


--
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: francis_user
--

COPY public.article (id, author_id, slug, title, description, body, created_at, updated_at) FROM stdin;
1	1	new-test-article-vmnvfqxp	New test article	New test article for the fans	New test article for the fans	2026-01-02 23:02:24.512443	2026-01-02 23:02:24.512458
2	1	another-test-article-97-_yxou	Another test article	Person test article	Person test article	2026-01-02 23:03:08.512773	2026-01-02 23:03:08.512784
\.


--
-- Data for Name: article_tag; Type: TABLE DATA; Schema: public; Owner: francis_user
--

COPY public.article_tag (article_id, tag_id, created_at) FROM stdin;
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: francis_user
--

COPY public.comment (id, article_id, author_id, body, created_at, updated_at) FROM stdin;
1	1	1	Yello !	2026-01-02 23:02:32.964269	2026-01-02 23:02:32.964286
2	2	1	Noice!	2026-01-02 23:03:18.056903	2026-01-02 23:03:18.056915
\.


--
-- Data for Name: favorite; Type: TABLE DATA; Schema: public; Owner: francis_user
--

COPY public.favorite (user_id, article_id, created_at) FROM stdin;
\.


--
-- Data for Name: follower; Type: TABLE DATA; Schema: public; Owner: francis_user
--

COPY public.follower (follower_id, following_id, created_at) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: francis_user
--

COPY public.tag (id, tag, created_at) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: francis_user
--

COPY public."user" (id, username, email, password_hash, bio, image_url, created_at, updated_at) FROM stdin;
1	francis	francis@gmail.com	$2b$12$aJb.GPOK0tdGHkPwj.Hs.OaYXdmrX98oetn.ELmdY7y/Qu/Tdn0JK		https://api.realworld.io/images/smiley-cyrus.jpeg	2026-01-02 23:01:10.057443	\N
\.


--
-- Name: article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: francis_user
--

SELECT pg_catalog.setval('public.article_id_seq', 2, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: francis_user
--

SELECT pg_catalog.setval('public.comment_id_seq', 2, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: francis_user
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: francis_user
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: article article_pkey; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_pkey PRIMARY KEY (id);


--
-- Name: article article_slug_key; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_slug_key UNIQUE (slug);


--
-- Name: article_tag article_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.article_tag
    ADD CONSTRAINT article_tag_pkey PRIMARY KEY (article_id, tag_id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: favorite favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_pkey PRIMARY KEY (user_id, article_id);


--
-- Name: follower follower_pkey; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.follower
    ADD CONSTRAINT follower_pkey PRIMARY KEY (follower_id, following_id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tag tag_tag_key; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_tag_key UNIQUE (tag);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: article article_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_author_id_fkey FOREIGN KEY (author_id) REFERENCES public."user"(id);


--
-- Name: article_tag article_tag_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.article_tag
    ADD CONSTRAINT article_tag_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.article(id) ON DELETE CASCADE;


--
-- Name: article_tag article_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.article_tag
    ADD CONSTRAINT article_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: comment comment_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.article(id) ON DELETE CASCADE;


--
-- Name: comment comment_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_author_id_fkey FOREIGN KEY (author_id) REFERENCES public."user"(id);


--
-- Name: favorite favorite_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.article(id) ON DELETE CASCADE;


--
-- Name: favorite favorite_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: follower follower_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.follower
    ADD CONSTRAINT follower_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public."user"(id);


--
-- Name: follower follower_following_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: francis_user
--

ALTER TABLE ONLY public.follower
    ADD CONSTRAINT follower_following_id_fkey FOREIGN KEY (following_id) REFERENCES public."user"(id);


--
-- francis_userQL database dump complete
--

