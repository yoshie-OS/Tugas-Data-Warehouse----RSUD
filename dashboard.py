import streamlit as st
import pandas as pd
from sqlalchemy import create_engine

conn = create_engine(st.secrets["DATABASE_URL"])

st.title("Dashboard Logistik dan Aset")
st.caption("RSUD")

# KPI01 — Total Aset per Periode
st.subheader("KPI01 — Total Aset per Periode")
kpi01 = pd.read_sql("""
    SELECT dw.tahun, dw.bulan, dw.nama_bulan, SUM(fa.jumlah_aset) as total_aset
    FROM fact_aset fa
    JOIN dim_waktu dw ON fa.id_waktu = dw.id_waktu
    GROUP BY dw.tahun, dw.bulan, dw.nama_bulan
    ORDER BY dw.tahun, dw.bulan
""", conn)
st.bar_chart(kpi01.set_index("nama_bulan")["total_aset"])

# KPI02 — Distribusi Aset per Kategori
st.subheader("KPI02 — Distribusi Aset per Kategori")
kpi02 = pd.read_sql("""
    SELECT da.eqp_cat_1, COUNT(*) as jumlah_aset
    FROM fact_aset fa
    JOIN dim_aset da ON fa.id_aset = da.id_aset
    GROUP BY da.eqp_cat_1
    ORDER BY jumlah_aset DESC
""", conn)
st.bar_chart(kpi02.set_index("eqp_cat_1")["jumlah_aset"])

# KPI03 — Distribusi Aset per Lokasi
st.subheader("KPI03 — Distribusi Aset per Lokasi")
st.warning("Data lokasi belum representatif — seluruh aset teralokasi ke satu lokasi default (Emergency) karena keterbatasan data source.")
kpi03 = pd.read_sql("""
    SELECT dl.dep_name, COUNT(*) as jumlah_aset
    FROM fact_aset fa
    JOIN dim_lokasi dl ON fa.id_lokasi = dl.id_lokasi
    GROUP BY dl.dep_name
    ORDER BY jumlah_aset DESC
""", conn)
st.dataframe(kpi03)

# KPI04 — Total Nilai Aset per Periode
st.subheader("KPI04 — Total Nilai Aset per Periode")
kpi04 = pd.read_sql("""
    SELECT dw.tahun, dw.bulan, dw.nama_bulan, SUM(fa.total_nilai_aset) as total_nilai
    FROM fact_aset fa
    JOIN dim_waktu dw ON fa.id_waktu = dw.id_waktu
    GROUP BY dw.tahun, dw.bulan, dw.nama_bulan
    ORDER BY dw.tahun, dw.bulan
""", conn)
st.line_chart(kpi04.set_index("nama_bulan")["total_nilai"])

# KPI05 — Tren Nilai Aset per Waktu
st.subheader("KPI05 — Tren Pertumbuhan Nilai Aset")
kpi05 = pd.read_sql("""
    SELECT dw.tahun, dw.bulan, dw.nama_bulan,
        SUM(fa.total_nilai_aset) as total_nilai,
        SUM(fa.total_nilai_aset) - LAG(SUM(fa.total_nilai_aset))
            OVER (ORDER BY dw.tahun, dw.bulan) as perubahan
    FROM fact_aset fa
    JOIN dim_waktu dw ON fa.id_waktu = dw.id_waktu
    GROUP BY dw.tahun, dw.bulan, dw.nama_bulan
    ORDER BY dw.tahun, dw.bulan
""", conn)
st.line_chart(kpi05.set_index("nama_bulan")["perubahan"])

# KPI06 — Top-N Unit Nilai Aset Tertinggi
st.subheader("KPI06 — Top-N Unit dengan Nilai Aset Tertinggi")
st.warning("Data lokasi belum representatif — sama seperti KPI03.")
kpi06 = pd.read_sql("""
    SELECT dl.dep_name, SUM(fa.total_nilai_aset) as total_nilai
    FROM fact_aset fa
    JOIN dim_lokasi dl ON fa.id_lokasi = dl.id_lokasi
    GROUP BY dl.dep_name
    ORDER BY total_nilai DESC
    LIMIT 5
""", conn)
st.dataframe(kpi06)

conn.close()