--
-- PostgreSQL database dump
--

\restrict hF5LRpUzc8e0EcKWmda6UJKvL5avpAhjbwNv7aME5LyJ3OR8rcGzdAJJca21odV

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

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
-- Name: dim_aset; Type: TABLE; Schema: public; Owner: yoshiesql
--

CREATE TABLE public.dim_aset (
    id_aset integer NOT NULL,
    eqp_id character varying(20) NOT NULL,
    eqp_name character varying(100),
    type_des character varying(100),
    eqp_cat_1 character varying(50),
    eqp_cat_2 character varying(50),
    eqp_cat_3 character varying(50),
    modl_no character varying(50),
    estat_des character varying(100),
    type_cd integer,
    strg_loc character varying(100),
    estat_cd integer
);


ALTER TABLE public.dim_aset OWNER TO yoshiesql;

--
-- Name: dim_aset_id_aset_seq; Type: SEQUENCE; Schema: public; Owner: yoshiesql
--

CREATE SEQUENCE public.dim_aset_id_aset_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_aset_id_aset_seq OWNER TO yoshiesql;

--
-- Name: dim_aset_id_aset_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yoshiesql
--

ALTER SEQUENCE public.dim_aset_id_aset_seq OWNED BY public.dim_aset.id_aset;


--
-- Name: dim_lokasi; Type: TABLE; Schema: public; Owner: yoshiesql
--

CREATE TABLE public.dim_lokasi (
    id_lokasi integer NOT NULL,
    whs_loc character varying(20) NOT NULL,
    gedung character varying(10),
    zona character varying(10),
    rak character varying(10)
);


ALTER TABLE public.dim_lokasi OWNER TO yoshiesql;

--
-- Name: dim_lokasi_id_lokasi_seq; Type: SEQUENCE; Schema: public; Owner: yoshiesql
--

CREATE SEQUENCE public.dim_lokasi_id_lokasi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_lokasi_id_lokasi_seq OWNER TO yoshiesql;

--
-- Name: dim_lokasi_id_lokasi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yoshiesql
--

ALTER SEQUENCE public.dim_lokasi_id_lokasi_seq OWNED BY public.dim_lokasi.id_lokasi;


--
-- Name: dim_supplier; Type: TABLE; Schema: public; Owner: yoshiesql
--

CREATE TABLE public.dim_supplier (
    id_supplier integer NOT NULL,
    ven_acc character varying(20) NOT NULL,
    ven_name character varying(100),
    ven_type character varying(50),
    ctry_name character varying(50),
    lcns_no character varying(30),
    ctry_cd character varying(10),
    ctry_con_no character varying(20),
    vstat_cd integer,
    vstat_des character varying(100),
    ingst_tmstmp timestamp without time zone
);


ALTER TABLE public.dim_supplier OWNER TO yoshiesql;

--
-- Name: dim_supplier_id_supplier_seq; Type: SEQUENCE; Schema: public; Owner: yoshiesql
--

CREATE SEQUENCE public.dim_supplier_id_supplier_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_supplier_id_supplier_seq OWNER TO yoshiesql;

--
-- Name: dim_supplier_id_supplier_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yoshiesql
--

ALTER SEQUENCE public.dim_supplier_id_supplier_seq OWNED BY public.dim_supplier.id_supplier;


--
-- Name: dim_waktu; Type: TABLE; Schema: public; Owner: yoshiesql
--

CREATE TABLE public.dim_waktu (
    id_waktu integer NOT NULL,
    tanggal date NOT NULL,
    bulan integer,
    nama_bulan character varying(20),
    tahun integer
);


ALTER TABLE public.dim_waktu OWNER TO yoshiesql;

--
-- Name: dim_waktu_id_waktu_seq; Type: SEQUENCE; Schema: public; Owner: yoshiesql
--

CREATE SEQUENCE public.dim_waktu_id_waktu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_waktu_id_waktu_seq OWNER TO yoshiesql;

--
-- Name: dim_waktu_id_waktu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yoshiesql
--

ALTER SEQUENCE public.dim_waktu_id_waktu_seq OWNED BY public.dim_waktu.id_waktu;


--
-- Name: fact_aset; Type: TABLE; Schema: public; Owner: yoshiesql
--

CREATE TABLE public.fact_aset (
    id_fakta integer NOT NULL,
    id_aset integer NOT NULL,
    id_supplier integer NOT NULL,
    id_lokasi integer NOT NULL,
    id_waktu integer NOT NULL,
    jumlah_aset numeric(10,2) NOT NULL,
    total_nilai_aset numeric(18,2) NOT NULL,
    CONSTRAINT fact_aset_jumlah_aset_check CHECK ((jumlah_aset >= (0)::numeric)),
    CONSTRAINT fact_aset_total_nilai_aset_check CHECK ((total_nilai_aset >= (0)::numeric))
);


ALTER TABLE public.fact_aset OWNER TO yoshiesql;

--
-- Name: fact_aset_id_fakta_seq; Type: SEQUENCE; Schema: public; Owner: yoshiesql
--

CREATE SEQUENCE public.fact_aset_id_fakta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fact_aset_id_fakta_seq OWNER TO yoshiesql;

--
-- Name: fact_aset_id_fakta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yoshiesql
--

ALTER SEQUENCE public.fact_aset_id_fakta_seq OWNED BY public.fact_aset.id_fakta;


--
-- Name: dim_aset id_aset; Type: DEFAULT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_aset ALTER COLUMN id_aset SET DEFAULT nextval('public.dim_aset_id_aset_seq'::regclass);


--
-- Name: dim_lokasi id_lokasi; Type: DEFAULT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_lokasi ALTER COLUMN id_lokasi SET DEFAULT nextval('public.dim_lokasi_id_lokasi_seq'::regclass);


--
-- Name: dim_supplier id_supplier; Type: DEFAULT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_supplier ALTER COLUMN id_supplier SET DEFAULT nextval('public.dim_supplier_id_supplier_seq'::regclass);


--
-- Name: dim_waktu id_waktu; Type: DEFAULT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_waktu ALTER COLUMN id_waktu SET DEFAULT nextval('public.dim_waktu_id_waktu_seq'::regclass);


--
-- Name: fact_aset id_fakta; Type: DEFAULT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.fact_aset ALTER COLUMN id_fakta SET DEFAULT nextval('public.fact_aset_id_fakta_seq'::regclass);


--
-- Name: dim_aset dim_aset_eqp_id_key; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_aset
    ADD CONSTRAINT dim_aset_eqp_id_key UNIQUE (eqp_id);


--
-- Name: dim_aset dim_aset_pkey; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_aset
    ADD CONSTRAINT dim_aset_pkey PRIMARY KEY (id_aset);


--
-- Name: dim_lokasi dim_lokasi_pkey; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_lokasi
    ADD CONSTRAINT dim_lokasi_pkey PRIMARY KEY (id_lokasi);


--
-- Name: dim_lokasi dim_lokasi_whs_loc_key; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_lokasi
    ADD CONSTRAINT dim_lokasi_whs_loc_key UNIQUE (whs_loc);


--
-- Name: dim_supplier dim_supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_supplier
    ADD CONSTRAINT dim_supplier_pkey PRIMARY KEY (id_supplier);


--
-- Name: dim_supplier dim_supplier_ven_acc_key; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_supplier
    ADD CONSTRAINT dim_supplier_ven_acc_key UNIQUE (ven_acc);


--
-- Name: dim_waktu dim_waktu_pkey; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_waktu
    ADD CONSTRAINT dim_waktu_pkey PRIMARY KEY (id_waktu);


--
-- Name: dim_waktu dim_waktu_tanggal_key; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.dim_waktu
    ADD CONSTRAINT dim_waktu_tanggal_key UNIQUE (tanggal);


--
-- Name: fact_aset fact_aset_pkey; Type: CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.fact_aset
    ADD CONSTRAINT fact_aset_pkey PRIMARY KEY (id_fakta);


--
-- Name: fact_aset fact_aset_id_aset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.fact_aset
    ADD CONSTRAINT fact_aset_id_aset_fkey FOREIGN KEY (id_aset) REFERENCES public.dim_aset(id_aset);


--
-- Name: fact_aset fact_aset_id_lokasi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.fact_aset
    ADD CONSTRAINT fact_aset_id_lokasi_fkey FOREIGN KEY (id_lokasi) REFERENCES public.dim_lokasi(id_lokasi);


--
-- Name: fact_aset fact_aset_id_supplier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.fact_aset
    ADD CONSTRAINT fact_aset_id_supplier_fkey FOREIGN KEY (id_supplier) REFERENCES public.dim_supplier(id_supplier);


--
-- Name: fact_aset fact_aset_id_waktu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yoshiesql
--

ALTER TABLE ONLY public.fact_aset
    ADD CONSTRAINT fact_aset_id_waktu_fkey FOREIGN KEY (id_waktu) REFERENCES public.dim_waktu(id_waktu);


--
-- PostgreSQL database dump complete
--

\unrestrict hF5LRpUzc8e0EcKWmda6UJKvL5avpAhjbwNv7aME5LyJ3OR8rcGzdAJJca21odV

