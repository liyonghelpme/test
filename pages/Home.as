import dialogs.FightBeginDialog;
import dialogs.ExitDialog;
import dialogs.AboutDialog;
class Home{
    var dtf;
    var hpn;
    
    var current_dialog;
    var girl_node;
    
    var musicplayer;
    
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
        addmenu();
     }
     
     function addmenu(){        
        var music_btn = dtf.pt.paintEm(hpn,"home/music.png",0,493,130,109); 
        music_btn.setevent(EVENT_TOUCH, musicClicked);

        var rank_btn = dtf.pt.paintEm(hpn,"home/rank.png",130,493,130,109);
        rank_btn.setevent(EVENT_TOUCH,rankClicked);
        
        var fight_btn = dtf.pt.paintEm(hpn,"home/fight_normal.png",260,493,130,109);
        fight_btn.setevent(EVENT_TOUCH,fightClicked);
        
        current_dialog = 0;
    }

    function musicClicked(){
    	  if(dtf.musicplay ==1){
    	  	dtf.music.pause();
    	  	dtf.musicplay =0;
    	  }
    	  else{
    	  	dtf.music.play(-1);
    	  	dtf.musicplay =1;
    	  }
    }
    
    function rankClicked(){
    		hpn = dtf.pt.paintBg(dtf.gs,"home/background.jpg");
        hpn.focus(1);
        hpn.setevent(EVENT_KEYDOWN,keydown);

        addgirl();
        contiPage();
        addrank();
    }
    
    function addrank(){
    	  dtf.pt.paintEm(hpn,"home/rank_detail.png",20,150,420,360);
    	  hpn.addlabel("你知道吗？每周三的0:00点，你的排行榜分数会刷新，想做常胜将军可不是那么容易的哦~","Arial",10,450,150);
    	  var rank_btn = dtf.pt.paintEm(hpn,"home/close.png",440,300,40,30);
    	  rank_btn.setevent(EVENT_TOUCH,addmenu);
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
    
    function keydown(n,e,p,kc){
        if(kc == 4){
            current_dialog = new ExitDialog(dtf,hpn,null,"home/exit");
            current_dialog.showDialog();
        }
    }
}