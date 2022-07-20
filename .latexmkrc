#this would set all tex commands to use -synctex=1 (and only this)
#set_tex_cmds( '-synctex=1 %O %S' );

#add -synctex=1 option to pdflatex
push @extra_pdflatex_options, '-synctex=1' ;
push @extra_pdflatex_options, '-interaction=nonstopmode' ;
push @extra_pdflatex_options, '-shell-escape' ;

#generate pdf instead of dvi
$pdf_mode=1;

##additionally clean this with -c (spaced separated string)
#$clean_ext = "aux";
##additionally clean this with -C (spaced separated string)
$clean_full_ext = "synctex.gz";

##set default file(s) to use
@default_files = ( 'paper.tex' );
