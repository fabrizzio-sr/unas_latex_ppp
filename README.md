# Plantilla LaTeX para Informes de Prácticas Pre Profesionales (PPP) - UNAS

Plantilla oficial, modular y desacoplada para la elaboración de Informes de Prácticas Pre Profesionales en la **Universidad Nacional Agraria de la Selva (UNAS)**, desarrollada bajo principios de ingeniería de software (**DRY** y **Separación de Responsabilidades**) con soporte exclusivo para el motor tipográfico moderno **LuaLaTeX**.

---

## Características Principales

- **Cumplimiento Estricto de la Normativa UNAS**:
  - **Márgenes reglamentarios**: 3.0 cm superior e izquierdo, 2.0 cm inferior y derecho.
  - **Tipografía**: *Times New Roman* a 12 pt en el cuerpo del documento.
  - **Interlineado**: 1.5 líneas reglamentario (`\setstretch{1.5}`).
  - **Sangría**: 1.27 cm en la primera línea de cada párrafo (`indentfirst`).
  - **Jerarquía de títulos**: Secciones en 14 pt mayúsculas negrita centradas; subsecciones en 12 pt negrita; sub-subsecciones en 12 pt negrita e itálica.
  - **Paginación**: Sin numeración en carátula ni preliminares; numeración arábiga en la esquina superior derecha a partir de la página 1 del cuerpo principal.
  - **Índices**: Prefijos reglamentarios `Figura X.` y `Tabla X.` con puntos guía.
- **Motor Tipográfico Exclusivo**: Desarrollado para **LuaLaTeX** utilizando `fontspec` y fuentes OpenType nativas del sistema operativo. Si se intenta compilar con motores antiguos (`pdfLaTeX`), la clase emite un error explicativo bloqueante.
- **Arquitectura Desacoplada y DRY**:
  - Toda la complejidad de formatos y paquetes está encapsulada en la clase maestra [`unas-ppp.cls`](unas-ppp.cls).
  - Los datos personales, títulos y fechas se configuran en un único archivo: [`config/metadata.tex`](config/metadata.tex).
  - La visibilidad de páginas preliminares (actas, constancias, dictámenes, dedicatoria) se controla con banderas booleanas en [`config/opciones.tex`](config/opciones.tex).
  - El archivo raíz [`main.tex`](main.tex) es declarativo y de fácil lectura (< 40 líneas).

---

## Estructura del Proyecto

```
unas_latex_ppp/
├── unas-ppp.cls                  # Clase maestra (estilo, tipografía, márgenes UNAS)
├── main.tex                      # Archivo raíz orquestador
├── config/
│   ├── metadata.tex              # Fuente única de datos (estudiante, asesor, empresa, título)
│   └── opciones.tex              # Interruptores booleanos (mostrar acta, dictamen, etc.)
├── preliminares/                 # Páginas preliminares modulares
│   ├── 00_qr_aviso.tex           # Aviso informativo para código QR institucional
│   ├── 01_dictamen.tex           # Dictamen de aprobación del asesor
│   ├── 02_constancia.tex         # Certificado o constancia de la empresa
│   ├── 03_acta.tex               # Acta de sustentación y evaluación
│   ├── 04_dedicatoria.tex        # Dedicatoria (opcional)
│   ├── 05_agradecimientos.tex    # Agradecimientos (opcional)
│   └── 06_resumen.tex            # Resumen estructurado y palabras clave
├── capitulos/                    # Capítulos del informe según reglamento UNAS
│   ├── 01_aspectos_generales.tex # Introducción, datos de la empresa, área
│   ├── 02_marco_teorico.tex      # Antecedentes, bases teóricas y glosario
│   ├── 03_actividades_realizadas.tex # Objetivos, metodología, cronograma y desarrollo
│   └── 04_conclusiones_recomendaciones.tex # Conclusiones y recomendaciones
├── anexos/                       # Anexos técnicos
│   └── 01_anexos.tex             # Tablas extensas, especificaciones o código
├── assets/
│   ├── logos/                    # Logos institucionales (UNAS y Facultad)
│   ├── documentos/               # Dictámenes, actas o constancias (PDF/PNG)
│   └── figuras/                  # Diagramas e imágenes vectoriales/PNG
├── bib/
│   └── referencias.bib           # Referencias bibliográficas en formato BibTeX (APA)
├── .latexmkrc                    # Configuración de compilación automática con LuaLaTeX
├── compile.ps1                   # Script PowerShell de 1 clic para Windows
└── .gitignore                    # Filtro de archivos auxiliares generados por LaTeX
```

---

## Guía de Inicio Rápido

### 1. Requisitos Previos
- Distribución LaTeX moderna: **MiKTeX** o **TeX Live** instalada en el sistema.
- Fuente tipográfica del sistema: **Times New Roman** (instalada por defecto en Windows).

### 2. Configurar los Metadatos del Informe
Abra el archivo [`config/metadata.tex`](config/metadata.tex) y modifique los campos con su información:

```latex
\universidad{UNIVERSIDAD NACIONAL AGRARIA DE LA SELVA}
\facultad{FACULTAD DE INGENIERÍA EN INFORMÁTICA Y SISTEMAS}
\escuela{ESCUELA PROFESIONAL DE INGENIERÍA EN INFORMÁTICA Y SISTEMAS}
\titulo{SU TÍTULO DE PRÁCTICAS PREPROFESIONALES EN MAYÚSCULAS}
\autor{Sus Nombres y Apellidos}
\asesor{Grado y Nombre de su Asesor}
\empresa{Nombre de la Empresa o Institución Receptora}
\periodo{DD/MM/AAAA al DD/MM/AAAA}
```

### 3. Ajustar las Banderas de Opciones
Abra [`config/opciones.tex`](config/opciones.tex) para activar o desactivar secciones:

```latex
\setbool{mostrarDictamen}{true}      % Si tiene el dictamen del asesor
\setbool{mostrarConstancia}{true}    % Si tiene el certificado de la empresa
\setbool{mostrarActa}{false}         % Activar en 'true' tras sustentar el informe
\setbool{mostrarDedicatoria}{true}   % Activar o desactivar dedicatoria
```

### 4. Adjuntar Documentos Escaneados
Coloque los archivos PDF o imágenes en la carpeta `assets/documentos/`:
- `dictamen_asesor.pdf` (o `.png`)
- `constancia_practicas.pdf` (o `.png`)
- `acta_sustentacion.pdf` (o `.png`)

*Nota: Si aún no tiene los documentos firmados, la plantilla incluirá automáticamente un cuadro de advertencia de sustitución sin generar errores de compilación.*

---

## 💻 Compilación del Documento

### Opción A: Mediante el Script de PowerShell (`compile.ps1`)
Desde la terminal en el directorio del proyecto:

```powershell
# Compilación completa en 1 clic (LuaLaTeX + BibTeX hacia build/)
# Genera informe_ppp_YYYYMMDD_HHMMSS.pdf y main.pdf en la raíz
.\compile.ps1

# Limpieza total de la subcarpeta 'build/' y temporales
.\compile.ps1 -Clean

# Modo observación activa (recompila automáticamente al guardar cambios en build/)
.\compile.ps1 -Watch
```

### Opción B: Mediante Visual Studio Code (LaTeX Workshop)
1. Instale la extensión **LaTeX Workshop**.
2. En su configuración de usuario o espacio de trabajo (`settings.json`), asegúrese de que la receta predeterminada utilice `lualatex` y `bibtex`.
3. Presione `Ctrl + Alt + B` para compilar.

### Opción C: Mediante TeXstudio
1. Diríjase a **Opciones -> Configurar TeXstudio -> Construir**.
2. Cambie el **Compilador por defecto** a **LuaLaTeX**.
3. Presione `F5` para compilar y visualizar.

---

## Buenas Prácticas y Consejos

- **Tablas Académicas**: Utilice el entorno `tabularx` en combinación con las líneas horizontales de `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) y el comando `\fuente{Elaboración propia.}`.
- **Bloques de Código**: Utilice el entorno `\begin{lstlisting}[language=...] ... \end{lstlisting}`.
- **Citas Bibliográficas**:
  - Para citas parentéticas: `\citep{clave_bibtex}` $\rightarrow$ *(Pressman, 2014)*.
  - Para citas narrativas: `\citet{clave_bibtex}` $\rightarrow$ *Pressman (2014)*.
- **Anexos**: Referencie cualquier anexo con el comando `\refanexo{anexo:mi_etiqueta}` $\rightarrow$ *Anexo A*.
