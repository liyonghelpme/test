import dialogs.Dialog;
class AboutDialog extends Dialog{
    function AboutDialog(para_dtf,para_fn,para_kn,para_krn){
        super(para_dtf,para_fn,para_kn,para_krn);
    }
 
    function showDialog(){
        showBg("menu2/menu2-bg2.png");
        setbackPath("menu2/back");
        showBackbtn(315,480);
        showTitle("menu2/menu2-about_title.png",258);
        dtf.pt.paintEm(this_node,"menu2/menu2-about_main.png",315,295,471,198).anchor(50,0);
    }
}
