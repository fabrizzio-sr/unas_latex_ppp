# =========================================================================
# .latexmkrc
# Configuración de compilación desatendida con LuaLaTeX para LaTeXmk
# =========================================================================
$pdf_mode = 4; # 4 = Generar PDF directamente con LuaLaTeX
$postscript_mode = 0;
$dvi_mode = 0;
$bibtex_use = 2;
$out_dir = 'build'; # Carpeta de salida para aislar archivos auxiliares
$lualatex = 'lualatex -interaction=nonstopmode -synctex=1 %O %S';
$clean_ext = 'aux bbl bcf blg fdb_latexmk fls lof log lot out run.xml synctex.gz toc nav snm vrb';
