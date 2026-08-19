# Data Warehouse RSUD

Data warehouse simulasi untuk analisis logistik dan aset RSUD. Project ini mengolah data operasional dalam format CSV menjadi model dimensional PostgreSQL dan menyajikannya melalui dashboard Streamlit.

## Fitur Dashboard

Dashboard pada `dashboard.py` menyediakan beberapa kebutuhan fungsional:

- **FR01:** total aset per periode
- **FR02:** distribusi aset berdasarkan kategori
- **FR03:** distribusi aset berdasarkan lokasi
- **FR04:** total nilai aset per periode
- **FR05:** tren perubahan nilai aset dari waktu ke waktu
- **FR06:** lima unit dengan total nilai aset tertinggi

## Arsitektur Data

Warehouse menggunakan skema bintang dengan satu tabel fakta dan empat dimensi:

- `fact_aset`: jumlah dan total nilai aset
- `dim_aset`: identitas, kategori, tipe, dan status aset
- `dim_lokasi`: lokasi penyimpanan aset
- `dim_supplier`: informasi pemasok
- `dim_waktu`: tanggal, bulan, dan tahun

Relasi dan definisi tabel tersedia pada `schema_dw_rsud.sql`. `dw_rsud.sql` merupakan dump database PostgreSQL lain yang dapat digunakan sebagai alternatif untuk memulihkan database.

## Struktur Project

```text
.
├── dashboard.py                         # Aplikasi dashboard Streamlit
├── dw_rsud.sql                          # Dump database PostgreSQL
├── schema_dw_rsud.sql                   # Schema dan constraint warehouse
├── notebook1.ipynb                      # Eksplorasi/pengolahan data inventori
└── STG_EHP_DATASET/
    ├── ERD Relationship Text.txt       # Dokumentasi relasi data sumber
    ├── STG_EHP__*.csv                  # Data staging operasional
    └── Data yang Diperlukan/
        ├── penyatuan.ipynb             # Penyatuan data inventori
        └── STG_EHP__INVN_combined.csv  # Data inventori gabungan
```

## Teknologi

- Python 3
- PostgreSQL
- Streamlit
- pandas
- SQLAlchemy
- psycopg2
- Jupyter Notebook

## Persiapan

1. Buat dan aktifkan virtual environment:

   ```bash
   python -m venv .venv
   source .venv/bin/activate
   ```

2. Instal dependency:

   ```bash
   pip install streamlit pandas sqlalchemy psycopg2-binary jupyter
   ```

3. Buat database PostgreSQL, kemudian pulihkan schema dan data:

   ```bash
   createdb rsud_dw
   psql -d rsud_dw -f schema_dw_rsud.sql
   ```

   Jika menggunakan dump lengkap, gunakan `dw_rsud.sql` sebagai pengganti perintah di atas:

   ```bash
   psql -d rsud_dw -f dw_rsud.sql
   ```

   Pastikan tabel `dim_aset`, `dim_lokasi`, `dim_supplier`, `dim_waktu`, dan `fact_aset` tersedia serta telah berisi data sebelum menjalankan dashboard.

## Konfigurasi Koneksi

Dashboard membaca koneksi database dari Streamlit Secrets. Buat file `.streamlit/secrets.toml` yang diabaikan oleh Git:

```toml
DATABASE_URL = "postgresql+psycopg2://username:password@localhost:5432/rsud_dw"
```

Jangan commit file secrets atau password database ke repository.

## Menjalankan Dashboard

Dari direktori project, jalankan:

```bash
streamlit run dashboard.py
```

Streamlit akan menampilkan URL lokal, biasanya `http://localhost:8501`.

## Alur Pengolahan Data

1. Letakkan atau gunakan data sumber pada `STG_EHP_DATASET/`.
2. Gunakan `STG_EHP_DATASET/Data yang Diperlukan/penyatuan.ipynb` untuk menggabungkan potongan data inventori menjadi `STG_EHP__INVN_combined.csv`.
3. Lakukan transformasi dan pemuatan data ke tabel dimensi serta tabel fakta PostgreSQL.
4. Jalankan `dashboard.py` untuk membaca data warehouse dan menampilkan metrik aset.

## Catatan Data

Data lokasi pada sumber saat ini belum representatif. Dashboard menggunakan satu lokasi default, yaitu **Emergency**, untuk aset yang belum memiliki pemetaan lokasi yang memadai. Karena itu, hasil FR03 dan FR06 berdasarkan unit/lokasi perlu ditafsirkan dengan hati-hati.

## Status Project

Project ini merupakan project akademik Data Warehouse. Dashboard dan model PostgreSQL berfokus pada analisis aset, jumlah aset, nilai aset, kategori aset, pemasok, lokasi, dan periode waktu.
