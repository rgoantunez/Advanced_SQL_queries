# 🎬 SQL Data Analysis – Videoclub Database

## 📖 Descripción

Proyecto de análisis de datos utilizando SQL sobre la conocida base de datos 'Sakila' que representa la actividad de una tienda de alquiler de películas.

El objetivo del proyecto es aplicar SQL avanzado sobre una base de datos relacional siguiendo una consigna práctica estructurada, que permite extraer insights de negocio e implementar de forma aplicada conceptos clave de modelado y análisis de datos.

La base de datos contiene **15 tablas relacionales** con información sobre:

- Clientes
- Pagos
- Inventario
- Staff
- Alquileres
- Películas (género, idioma, actores, etc.)

---

## 🗂 Estructura del Proyecto

### 📁 data/
Contiene el archivo `BBDD_Proyecto.sql`, que incluye la creación de tablas y carga de datos.

### 📁 scripts/
Proceso de instalación y consultas SQL ejecutadas mediante **DBeaver** utilizando:

- Conexión local
- Puerto 5432
- Usuario: postgres
- Base de datos creada: `Videoclub`

Pasos realizados:
1. Descarga del archivo `BBDD_Proyecto.sql`
2. Creación de la base de datos `Videoclub`
3. Ejecución del script SQL para generar estructura y cargar datos
4. Exploración del esquema relacional para comprender relaciones entre tablas

### 📁 results/
Contiene consultas y conclusiones obtenidas a partir del análisis.

---

## 📊 Resultados y Conclusiones

La base refleja la actividad de **2 sucursales** durante:

- Mayo – Agosto 2005
- Febrero 2006

### 🔎 Principales insights:

- 2 sucursales con 1 empleado cada una
- 599 clientes registrados
- 1.000 películas disponibles para alquiler
- 16 géneros distintos
- 200 actores/actrices
- 16.044 alquileres registrados

### 📈 Comportamiento del negocio

- Promedio de alquiler: **4,98 días**
- Precio promedio de alquiler: **2,98 (unidad monetaria)**
- Tendencia creciente de alquileres entre Mayo y Julio 2005
- Pico máximo: **31 de julio de 2005 con 679 alquileres**
- Mes con mayor actividad: **Julio 2005 (6.709 alquileres)**
- Mes con menor actividad: **Febrero 2006 (182 alquileres)**

📌 Hipótesis: La estacionalidad sugiere que los datos podrían corresponder al hemisferio sur, donde julio es invierno (temporada alta) y febrero verano.

---

## 🛠 Tecnologías utilizadas

- SQL (PostgreSQL)
- DBeaver
- Base de datos relacional
- Análisis exploratorio mediante consultas

---

## 🔄 Próximos Pasos

- Análisis de frecuencia por día de la semana y franja horaria
- Segmentación de clientes
- Cálculo de rentabilidad por género
- Promedio de consumo mensual por cliente
- Visualización de resultados con herramientas BI

---

## 👨‍💻 Autor

**Rodrigo Antúnez**  
Data Analyst en formación con enfoque en análisis SQL y exploración de datos relacionales.

🔗 GitHub: https://github.com/rgoantunez  
🔗 Repositorio del proyecto: https://github.com/rgoantunez/Advanced_SQL_queries

---
