import dialogs.Dialog;
class ExitDialog extends Dialog{
    function ExitDialog(para_dtf,para_fn,para_kn,para_krn){
        super(para_dtf,para_fn,para_kn,para_krn);
    }
    
    function showDialog(){
        showBg("menu2/menu2-bg.png");
        setbackPath("menu2/no");
        showBackbtn(315,430);
        dtf.pt.paintEm(this_node,"menu2/quit_main.png",315,300,400,76).anchor(50,0);
        var exit_btn = dtf.pt.paintEm(this_node,"menu2/yes.png",315,430,170,50).anchor(100,0);
        exit_btn.setevent(EVENT_TOUCH,exit_btnClicked);
    }
    
    function exit_btnClicked(enode){
        enode.texture("menu2/yes_on.png");
        closeDialog(exitgame);
    }
    
    function exitgame(){
        quitgame();
    }
}