
set formatoptions=
set noautoindent

" Make the line a paragraph
"
map H ^i<h3><ESC>A</h3><ESC>^
map P ^i<p><ESC>}i</p><cr><ESC>kkgq}j


" Close the tag under the cursor
map <C-P> ly/>/eA</"^

ab ufma <div class="uf-activityContainer"><CR><TAB><h3>Multimedia Activity</h3><CR><TAB><CR></div> 
ab ufla <div class="uf-activityContainer"><CR><TAB><h3>Learning Activity</h3><CR><TAB><CR></div> 
ab ufia <?php echo $this->ufActivity('01'); ?>
ab ufss <?php echo $this->ufSlideshow('01'); ?>
ab ufvid <?php echo $this->ufVideo('01'); ?>
ab ufaud <?php echo $this->ufAudio('01'); ?>

abbr ufic <?php<CR><TAB>echo $this->ufImageCentered(<CR><TAB>'images/',<CR><TAB>'<CR><TAB>',<CR><TAB>'<CR><TAB>'<CR><TAB>);<CR><CR>?>
abbr ufil <?php<CR><TAB>echo $this->ufImageLeft(<CR><TAB>'images/',<CR><TAB>'<CR><TAB>',<CR><TAB>'<CR><TAB>'<CR><TAB>);<CR><CR>?>
abbr ufir <?php<CR><TAB>echo $this->ufImageRight(<CR><TAB>'images/',<CR><TAB>'<CR><TAB>',<CR><TAB>'<CR><TAB>'<CR><TAB>);<CR><CR>?>

abbr ufst <?php echo $view->ufStrategy('');?>
abbr ufdef <?php echo $view->ufDefinition('');?><ESC>hhhhi
abbr ufbq <blockquote>

map <C-D> dei<?php echo $view->ufDefinition('');?><ESC>hhhhhp
