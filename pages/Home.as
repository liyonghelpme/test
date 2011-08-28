import dialogs.FightBeginDialog;
import dialogs.ExitDialog;
import dialogs.AboutDialog;
class Home{
    var dtf;
    var hpn;
    
    var current_dialog;
    var girl_node;
    
    function Home(d){
        dtf = d;
        paint();
    }

    function paint(){
        hpn = dtf.pt.paintBg(dtf.gs,"home/background.jpg");
        hpn.focus(1);
        hpn.setevent(EVENT_KEYDOWN,keydown);

        addgirl();
        contiPage();
        
        var exit_btn = dtf.pt.paintEm(hpn,"home/exit_normal.png",0,493,130,109);
        exit_btn.setevent(EVENT_TOUCH,exitClicked);

        var about_btn = dtf.pt.paintEm(hpn,"home/about_normal.png",130,493,130,109);
        about_btn.setevent(EVENT_TOUCH,aboutClicked);

        var fight_btn = dtf.pt.paintEm(hpn,"home/fight_normal.png",260,493,130,109);
        fight_btn.setevent(EVENT_TOUCH,fightClicked);
        
        current_dialog = 0;
    }

    function pausePage(){
        girl_node.addaction(stop());
    }
    
    function contiPage(){
        girl_node.texture(dtf.cg[38]);
        girl_node.addaction(repeat(delaytime(1500),animate(3000,dtf.cg[39],dtf.cg[38])));
    }
    
    function addgirl(){
        girl_node = dtf.pt.paintEm(hpn,dtf.cg[38],420,150,288,360);
    }
    
    function fightClicked(fnode){
        if(current_dialog == 0){
            current_dialog = new FightBeginDialog(dtf,hpn,fnode,"home/fight");
            current_dialog.showDialog();
        }
    }

    function aboutClicked(anode){
        if(current_dialog == 0){
            current_dialog = new AboutDialog(dtf,hpn,anode,"home/about");
            current_dialog.showDialog();
        }
    }

    function exitClicked(enode){
        if(current_dialog == 0){
            current_dialog = new ExitDialog(dtf,hpn,enode,"home/exit");
            current_dialog.showDialog();
        }
    }
    
    function keydown(n,e,p,kc){
        if(kc == 4){
            current_dialog = new ExitDialog(dtf,hpn,null,"home/exit");
            current_dialog.showDialog();
        }
    }
}