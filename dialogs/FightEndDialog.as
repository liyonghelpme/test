class FightEndDialog{
    var dtf;
    var father_node; 
    
    var this_node;
    var dark_node;
    
    var again_path;
    var back_path;

    var is_win;

    function FightEndDialog(para_dtf,para_fn){
        dtf = para_dtf;
        father_node = para_fn;
    }

    function showBg(bg){
        dark_node = dtf.pt.paintEm(father_node,"dark.png",0,0,800,600);
        this_node = dtf.pt.paintEm(father_node,bg,85,-600,630,596);
        this_node.focus(1);
        this_node.setevent(EVENT_KEYDOWN,keydown);
        this_node.addaction(sequence(delaytime(100),moveby(600,0,dtf.pt.a[0]/2),moveby(400,0,3*dtf.pt.a[0]/16)));
    }

    function showBackbtn(w,h){
        var back_btn = dtf.pt.paintEm(this_node,back_path+".png",w,h,170,50);
        back_btn.setevent(EVENT_TOUCH,back_btnClicked);
    }

    function back_btnClicked(bnode){
        bnode.texture(back_path+"_on.png");
        closeDialog(exitDialog);
    }

    function showDialog(){
        showBg("menu2/menu2-bg.png");
        back_path ="menu2/quit";
        showBackbtn(315,460);
    }
    
    function resetGame(anode){
        anode.texture(again_path+"_on.png");
        closeDialog(restart);
    }

    function restart(){
        dark_node.removefromparent();
        this_node.removefromparent();
        father_node.focus(1);
        dtf.fight.restart();
    }

    function closeDialog(f){
        this_node.addaction(sequence(moveby(700,0,-3*dtf.pt.a[0]/16),moveby(800,0,-dtf.pt.a[0]/2),delaytime(100),callfunc(f)));
    }

    function exitDialog(){
        dark_node.removefromparent();
        this_node.removefromparent();
        father_node.focus(1);
        dtf.fight.closePage();
    }
    
    function keydown(n,e,p,kc){
        if(kc==4){
            closeDialog(exitDialog);
        }
    }
    
    function setstate(w){
        is_win = w;
        if(is_win == 1){
            again_path = "menu2/continue";
            dtf.pt.paintEm(this_node,"menu2/after_fight_win.png",315,250,466,76).anchor(50,0);
            dtf.pt.paintEm(this_node,"menu2/scorebest.png",315,280,214,192).anchor(100,0);
        }
        else{
            again_path = "menu2/again";
            dtf.pt.paintEm(this_node,"menu2/after_fight_lose.png",315,280,466,76).anchor(50,0);
            dtf.pt.paintEm(this_node,"menu2/stone.png",315,365,408,52).anchor(50,0);
        }
        var again_btn = dtf.pt.paintEm(this_node,again_path+".png",315,460,170,50).anchor(100,0);
        again_btn.setevent(EVENT_TOUCH,resetGame);
    }
    
    function setscore(s,b){
        var i;
        var j;
        var k=400;
        for(i=s;i>0;i = i/10){
            j = i%10;
            dtf.pt.paintEm(this_node,dtf.cg[50+j],k,325,44,60);
            k = k-33;
        }
        k=360;
        for(i=b;i>0;i = i/10){
            j = i%10;
            dtf.pt.paintEm(this_node,dtf.cg[50+j],k,385,44,60);
            k = k-33;
        }
    }
}