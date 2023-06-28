--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Ubuntu 15.3-1.pgdg22.04+1)
-- Dumped by pg_dump version 15.3 (Ubuntu 15.3-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: locations; Type: TABLE; Schema: public; Owner: brunodb
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    local integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.locations OWNER TO brunodb;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: brunodb
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO brunodb;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brunodb
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: migration_versions; Type: TABLE; Schema: public; Owner: brunodb
--

CREATE TABLE public.migration_versions (
    id integer NOT NULL,
    version character varying(17) NOT NULL
);


ALTER TABLE public.migration_versions OWNER TO brunodb;

--
-- Name: migration_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: brunodb
--

CREATE SEQUENCE public.migration_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migration_versions_id_seq OWNER TO brunodb;

--
-- Name: migration_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brunodb
--

ALTER SEQUENCE public.migration_versions_id_seq OWNED BY public.migration_versions.id;


--
-- Name: travel_locations; Type: TABLE; Schema: public; Owner: brunodb
--

CREATE TABLE public.travel_locations (
    id integer NOT NULL,
    location_id integer NOT NULL,
    travel_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.travel_locations OWNER TO brunodb;

--
-- Name: travel_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: brunodb
--

CREATE SEQUENCE public.travel_locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.travel_locations_id_seq OWNER TO brunodb;

--
-- Name: travel_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brunodb
--

ALTER SEQUENCE public.travel_locations_id_seq OWNED BY public.travel_locations.id;


--
-- Name: travels; Type: TABLE; Schema: public; Owner: brunodb
--

CREATE TABLE public.travels (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.travels OWNER TO brunodb;

--
-- Name: travels_id_seq; Type: SEQUENCE; Schema: public; Owner: brunodb
--

CREATE SEQUENCE public.travels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.travels_id_seq OWNER TO brunodb;

--
-- Name: travels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brunodb
--

ALTER SEQUENCE public.travels_id_seq OWNED BY public.travels.id;


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: brunodb
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: migration_versions id; Type: DEFAULT; Schema: public; Owner: brunodb
--

ALTER TABLE ONLY public.migration_versions ALTER COLUMN id SET DEFAULT nextval('public.migration_versions_id_seq'::regclass);


--
-- Name: travel_locations id; Type: DEFAULT; Schema: public; Owner: brunodb
--

ALTER TABLE ONLY public.travel_locations ALTER COLUMN id SET DEFAULT nextval('public.travel_locations_id_seq'::regclass);


--
-- Name: travels id; Type: DEFAULT; Schema: public; Owner: brunodb
--

ALTER TABLE ONLY public.travels ALTER COLUMN id SET DEFAULT nextval('public.travels_id_seq'::regclass);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: brunodb
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: migration_versions migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: brunodb
--

ALTER TABLE ONLY public.migration_versions
    ADD CONSTRAINT migration_versions_pkey PRIMARY KEY (id);


--
-- Name: travel_locations travel_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: brunodb
--

ALTER TABLE ONLY public.travel_locations
    ADD CONSTRAINT travel_locations_pkey PRIMARY KEY (id);


--
-- Name: travels travels_pkey; Type: CONSTRAINT; Schema: public; Owner: brunodb
--

ALTER TABLE ONLY public.travels
    ADD CONSTRAINT travels_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

