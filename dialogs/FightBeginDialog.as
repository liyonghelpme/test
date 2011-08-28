import dialogs.Dialog;
import pages.Fight;
class FightBeginDialog extends Dialog{    
    var stage_node;
    
    function FightBeginDialog(para_dtf,para_fn,para_kn,para_krn){
        super(para_dtf,para_fn,para_kn,para_krn);
    }

    function showDialog(){
        showBg("menu2/menu2-bg.png");
        setbackPath("menu2/back");
        showBackbtn(315,440);

        var go_btn = dtf.pt.paintEm(this_node,"menu2/go.png",315,440,170,50).anchor(100,0);
        go_btn.setevent(EVENT_TOUCH,goClicked);
        
        dtf.pt.paintEm(this_node,"menu2/menu2-fight_stage.png",315,300,238,70).anchor(50,0);
        setStage();

        var the_last = dtf.pt.paintEm(this_node,"menu2/menu2-fight_left.png",100,300,98,70);
        the_last.setevent(EVENT_TOUCH,the_last_level);
        var the_next = dtf.pt.paintEm(this_node,"menu2/menu2-fight_right.png",530,300,98,70).anchor(100,0);
        the_next.setevent(EVENT_TOUCH,the_next_level);
    }

    function setStage(){
        if(dtf.fclev >= 10){
            stage_node = dtf.pt.paintEm(this_node,dtf.cg[50+dtf.fclev/10],379,305,44,60);
            dtf.pt.paintEm(stage_node,dtf.cg[50+dtf.fclev%10],33,0,44,60);
        }
        else{
            stage_node = dtf.pt.paintEm(this_node,dtf.cg[50+dtf.fclev],390,305,44,60);
        }
    }
    
    function the_last_level(lnode){
        lnode.addaction(animate(500,"menu2/menu2-fight_left_on.png","menu2/menu2-fight_left.png"));
        if(dtf.fclev >1){
            dtf.fclev = dtf.fclev - 1;
            stage_node.removefromparent();
            setStage();
            Fwr.writeF(str(dtf.flev)+"a"+str(dtf.fclev)+"a"+str(dtf.best));
        }
    }
    
    function the_next_level(nnode){
        nnode.addaction(animate(500,"menu2/menu2-fight_right_on.png","menu2/menu2-fight_right.png"));
        if(dtf.fclev < dtf.flev){
            dtf.fclev = dtf.fclev+1;
            stage_node.removefromparent();
            setStage();
            Fwr.writeF(str(dtf.flev)+"a"+str(dtf.fclev)+"a"+str(dtf.best));
        }
    }
    
    function goClicked(gnode){
        gnode.texture("menu2/go_on.png");
        closeDialog(gotofight);
    }
    
    function gotofight(){
        exitDialog();
        dtf.home.pausePage();
        dtf.home.hpn.visible(0);
        dtf.fight = new Fight(dtf);
    }
}