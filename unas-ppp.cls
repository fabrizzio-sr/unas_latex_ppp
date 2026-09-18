% =========================================================================
% unas-ppp.cls
% Clase LaTeX para Informes de Prácticas Pre Profesionales (PPP)
% Universidad Nacional Agraria de la Selva (UNAS)
% =========================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unas-ppp}[2026/09/18 v1.0.0 Plantilla de Informe de PPP UNAS - LuaLaTeX]

% --- VERIFICACIÓN ESTRICTA DEL MOTOR LUALATEX ---
\RequirePackage{ifluatex}
\ifluatex\else
    \ClassError{unas-ppp}{%
        Este documento debe compilarse exclusivamente con LuaLaTeX.%
    }{%
        Configure su editor (VS Code, TeXstudio, MiKTeX, etc.) para utilizar 'lualatex'.%
    }
\fi

% --- CLASE BASE ---
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt, a4paper]{article}

% --- MÁRGENES Y GEOMETRÍA NORMATIVA UNAS ---
% Margen superior e izquierdo: 3.00 cm
% Margen inferior y derecho: 2.00 cm
% Separador de cabecera: 0.50 cm
\RequirePackage[
    left=3.00cm,
    right=2.00cm,
    top=3.00cm,
    bottom=2.00cm,
    headsep=0.50cm,
    headheight=15pt
]{geometry}

% --- TIPOGRAFÍA Y LENGUAJE ---
\RequirePackage{fontspec}
\IfFontExistsTF{Times New Roman}{%
    \setmainfont{Times New Roman}%
}{%
    \IfFontExistsTF{TeX Gyre Termes}{%
        \setmainfont{TeX Gyre Termes}%
    }{%
        \IfFontExistsTF{Liberation Serif}{%
            \setmainfont{Liberation Serif}%
        }{}%
    }%
}

\RequirePackage[bidi=basic, provide=*]{babel}
\babelprovide[import, main, onchar=ids fonts]{spanish}
\babelprovide[import, onchar=ids fonts]{english}

% --- INTERLINEADO Y SANGRÍA ---
% Interlineado 1.5 normativo
\RequirePackage{setspace}
\setstretch{1.5}

% Sangría de primera línea normativo (1.27 cm)
\RequirePackage{indentfirst}
\setlength{\parindent}{1.27cm}

% --- PAQUETES AUXILIARES FUNDAMENTALES ---
\RequirePackage{etoolbox}
\RequirePackage{xstring}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage[table]{xcolor}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{ragged2e}
\RequirePackage{pdflscape}
\RequirePackage{pdfpages}
\RequirePackage{listings}
\RequirePackage[toc, page]{appendix}
\RequirePackage[round, authoryear]{natbib}

% Tipo de columna flexible y justificada a la izquierda para tablas
\newcolumntype{L}{>{\RaggedRight\arraybackslash\footnotesize}X}

% --- CONFIGURACIÓN DE LISTAS ---
\RequirePackage{enumitem}
\setlist[itemize]{label=-, leftmargin=*, labelindent=1.27cm}
\setlist[enumerate]{leftmargin=*, labelindent=1.27cm}

% --- CONFIGURACIÓN DE TÍTULOS (UNAS) ---
% Secciones principales (Capítulos): 14pt, Negrita, Centrado, Mayúsculas
% Subsecciones: 12pt, Negrita, Izquierda
% Sub-subsecciones: 12pt, Negrita, Cursiva, Izquierda
\RequirePackage{titlesec}
\titleformat{\section}%
{\normalfont\fontsize{14pt}{16pt}\selectfont\bfseries\centering}%
{\thesection.}%
{1em}%
{\MakeUppercase}

\titleformat{\subsection}%
{\normalfont\fontsize{12pt}{14pt}\selectfont\bfseries}%
{\thesubsection.}%
{1em}%
{}

\titleformat{\subsubsection}%
{\normalfont\fontsize{12pt}{14pt}\selectfont\bfseries\itshape}%
{\thesubsubsection.}%
{1em}%
{}

% --- ENCABEZADOS Y NUMERACIÓN DE PÁGINA (UNAS) ---
% Numeración en la esquina superior derecha sin líneas
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\rhead{\thepage}
\renewcommand{\headrulewidth}{0pt}

% --- CONFIGURACIÓN DE LEYENDAS (CAPTIONS) ---
\RequirePackage{caption}
\captionsetup{
    justification=justified,
    singlelinecheck=false,
    labelfont=bf,
    font=normalsize
}

% --- FORMATO DE BLOQUES DE CÓDIGO (LISTINGS) ---
\definecolor{codebg}{rgb}{0.98,0.98,0.98}
\definecolor{codegray}{rgb}{0.45,0.45,0.45}
\definecolor{codeblue}{rgb}{0.10,0.20,0.75}
\definecolor{codegreen}{rgb}{0.12,0.50,0.15}

\lstset{
    backgroundcolor=\color{codebg},
    basicstyle=\ttfamily\small,
    breaklines=true,
    frame=single,
    framesep=3pt,
    rulecolor=\color{black!30},
    breakatwhitespace=true,
    keepspaces=true,
    columns=fullflexible,
    postbreak=\mbox{\textcolor{gray}{$\hookrightarrow$}\space},
    commentstyle=\color{codegreen},
    keywordstyle=\color{codeblue}\bfseries,
    numberstyle=\tiny\color{codegray},
    numbers=left,
    numbersep=7pt,
    showstringspaces=false
}

% --- CONFIGURACIÓN DE ÍNDICES (TOCLOFT) ---
\RequirePackage[titles]{tocloft}
\renewcommand{\cftfigpresnum}{Figura~}
\setlength{\cftfignumwidth}{2.3cm}
\renewcommand{\cftfigaftersnum}{.}
\renewcommand{\cfttabpresnum}{Tabla~}
\setlength{\cfttabnumwidth}{2.0cm}
\renewcommand{\cfttabaftersnum}{.}

% Denominaciones reglamentarias en español
\renewcommand{\contentsname}{ÍNDICE}
\renewcommand{\refname}{REFERENCIAS}
\renewcommand{\listtablename}{ÍNDICE DE TABLAS}
\renewcommand{\listfigurename}{ÍNDICE DE FIGURAS}
\renewcommand{\tablename}{Tabla}
\renewcommand{\figurename}{Figura}

% --- HIPERVÍNCULOS Y METADATA PDF ---
\RequirePackage[
    hidelinks,
    bookmarks=true,
    pdfencoding=auto,
    pdfstartview=FitH
]{hyperref}
\RequirePackage{bookmark}

% --- DEFINICIÓN DE METADATOS DEL DOCUMENTO (API DECLARATIVA) ---
\newcommand{\universidad}[1]{\def\@universidad{#1}}
\newcommand{\facultad}[1]{\def\@facultad{#1}}
\newcommand{\escuela}[1]{\def\@escuela{#1}}
\newcommand{\titulo}[1]{\def\@titulo{#1}}
\newcommand{\autor}[1]{\def\@autor{#1}}
\newcommand{\asesor}[1]{\def\@asesor{#1}}
\newcommand{\periodo}[1]{\def\@periodo{#1}}
\newcommand{\empresa}[1]{\def\@empresa{#1}}
\newcommand{\ciudad}[1]{\def\@ciudad{#1}}
\newcommand{\pais}[1]{\def\@pais{#1}}
\newcommand{\anio}[1]{\def\@anio{#1}}
\newcommand{\logoUniversidad}[1]{\def\@logoUniversidad{#1}}
\newcommand{\logoFacultad}[1]{\def\@logoFacultad{#1}}

% Valores por defecto
\universidad{UNIVERSIDAD NACIONAL AGRARIA DE LA SELVA}
\facultad{FACULTAD DE INGENIERÍA EN INFORMÁTICA Y SISTEMAS}
\escuela{ESCUELA PROFESIONAL DE INGENIERÍA EN INFORMÁTICA Y SISTEMAS}
\titulo{[TÍTULO DEL INFORME DE PRÁCTICAS PREPROFESIONALES]}
\autor{[NOMBRES Y APELLIDOS DEL PRACTICANTE]}
\asesor{[GRADO Y NOMBRE DEL ASESOR]}
\periodo{[FECHA INICIO AL FECHA FIN]}
\empresa{[NOMBRE DE LA INSTITUCIÓN O EMPRESA RECEPTORA]}
\ciudad{TINGO MARÍA}
\pais{PERÚ}
\anio{\the\year}
\logoUniversidad{assets/logos/unas.png}
\logoFacultad{assets/logos/fiis_unas.jpg}

% --- MACROS PÚBLICAS DE ESTRUCTURA Y NAVEGACIÓN ---

% 1. Portada reglamentaria UNAS
\newcommand{\makecaratula}{
    \hypersetup{pageanchor=false}
    \begin{titlepage}
        \centering
        \setstretch{1.15}

        {\fontsize{14pt}{16pt}\selectfont\bfseries \@universidad} \par
        \vspace{0.35cm}
        {\fontsize{12pt}{14pt}\selectfont\bfseries \@facultad} \par
        \vspace{0.35cm}
        {\fontsize{12pt}{14pt}\selectfont\bfseries \@escuela} \par

        \vspace{1.2cm}
        \begin{minipage}{0.85\textwidth}
            \centering
            \ifdefempty{\@logoUniversidad}{}{%
                \includegraphics[width=3.2cm]{\@logoUniversidad}%
            }%
            \hspace{0.8cm}%
            \ifdefempty{\@logoFacultad}{}{%
                \includegraphics[width=3.2cm]{\@logoFacultad}%
            }%
        \end{minipage}

        \vspace{1.2cm}
        {\fontsize{14pt}{16pt}\selectfont\bfseries INFORME DE PRÁCTICAS PREPROFESIONALES} \par
        \vspace{0.8cm}
        {\fontsize{12pt}{14pt}\selectfont\bfseries ``\@titulo''} \par

        \vspace{2.2cm}
        \begin{flushleft}
            \fontsize{12pt}{14pt}\selectfont
            \textbf{Presentado por:} \@autor \par
            \vspace{0.4cm}
            \textbf{Asesor:} \@asesor \par
            \vspace{0.4cm}
            \textbf{Periodo de prácticas preprofesionales:} \@periodo \par
            \vspace{0.4cm}
            \textbf{Lugar de las prácticas preprofesionales:} \@empresa
        \end{flushleft}

        \vfill
        {\fontsize{12pt}{14pt}\selectfont \@ciudad\ -- \@pais \par \@anio}
    \end{titlepage}
    \clearpage
}

% 2. Inicio de secciones preliminares
\newcommand{\iniciarpreliminares}{
    \clearpage
    \pagenumbering{roman}
    \pagestyle{empty}
    \hypersetup{pageanchor=true}
}

% 3. Generador de índices automáticos
\newcommand{\makepreliminares}{
    \clearpage
    \pagestyle{empty}
    \tableofcontents
    \ifbool{mostrarIndiceTablas}{%
        \clearpage
        \listoftables
    }{}
    \ifbool{mostrarIndiceFiguras}{%
        \clearpage
        \listoffigures
    }{}
    \clearpage
}

% 4. Inicio del cuerpo del documento (Página 1 arábiga)
\newcommand{\iniciarcuerpo}{
    \clearpage
    \pagestyle{fancy}
    \pagenumbering{arabic}
    \setcounter{page}{1}
}

% 5. Configuración del bloque de anexos
\newcommand{\iniciaranexos}{
    \clearpage
    \appendix
    \addcontentsline{toc}{section}{ANEXOS}
    \renewcommand{\thesubsection}{\Alph{subsection}}
    \setcounter{subsection}{0}
}

% --- MACROS DE UTILIDAD ---

% Referencia cruzada a anexos estandarizada (ej: \refanexo{anexo:cronograma})
\newcommand{\refanexo}[1]{\hyperref[#1]{Anexo~\ref*{#1}}}

% Atribución de fuentes en tablas y figuras
\newcommand{\fuente}[1]{%
    \vspace{0.15cm}%
    \begin{flushleft}%
        \footnotesize\textit{Fuente: #1}%
    \end{flushleft}%
}

% Inclusión de documentos externos institucionales (PDF o imagen)
\newcommand{\incluirdocumento}[3][]{%
    \clearpage
    \thispagestyle{empty}
    \IfSubStr{#3}{.pdf}{%
        \includepdf[pages=-, #1]{#3}%
    }{%
        \vspace*{\fill}
        \begin{center}
            \makebox[\textwidth][c]{\includegraphics[#1]{#3}}
        \end{center}
        \vspace*{\fill}
    }%
    \clearpage
}

\endinput
