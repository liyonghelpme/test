import dialogs.FightBeginDialog;
import dialogs.ExitDialog;
import dialogs.AboutDialog;
class Home{
    var dtf;
    var hpn;
    
    var current_dialog;
    var girl_node;
    
    var musicplayer;
    var ranklist=null;
    var rank2_btn;
    
    var music_btn;
    var rank_btn;
    var fight_btn;
    var label_rank;
    var label_net = null;
    var rank_top =null;
    
    function Home(d){
        dtf = d;
        paint();
        detectnet();
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
     		if(ranklist){
     				ranklist.removefromparent();
     				rank2_btn.removefromparent();
     				label_rank.removefromparent();
     		}
          
        music_btn = dtf.pt.paintEm(hpn,"home/music.png",0,493,130,109); 
        music_btn.setevent(EVENT_TOUCH, musicClicked);

        rank_btn = dtf.pt.paintEm(hpn,"home/rank.png",130,493,130,109);
        rank_btn.setevent(EVENT_TOUCH,rankClicked);
        
        fight_btn = dtf.pt.paintEm(hpn,"home/fight_normal.png",260,493,130,109);
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
    		trace("rankClicked");
    		music_btn.removefromparent();
    		rank_btn.removefromparent();
    		fight_btn.removefromparent();
        addrank();
    }
    
    function addrank(){
    	  ranklist = dtf.pt.paintEm(hpn,"home/rank_detail.png",20,150,420,360);
    	  var requestId = ppy_query("list_friends", null, hfriend);
    	  //ranklist.setevent(EVENT_TOUCH, showdetail);
    	  label_rank = hpn.addlabel("something to say~~~~~~~~~~~~~~~~~~","Arial",20,200,100).pos(650,200).color(0,0,0);
    	  rank2_btn = dtf.pt.paintEm(hpn,"home/close.png",740,400,50,40);
    	  rank2_btn.setevent(EVENT_TOUCH,addmenu);
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
    
		function hfriend(requestId, ret_code, response){
				trace("flist:", response.get("data"));
				var flist = response.get("data");
				//hpn.addlabel("These are your friends",null,25).pos(350,200).color(0,0,0);
				trace("show friend");
				var x= 30; var y = 80;
				for(var i = 0; i<len(flist);i++){
						ranklist.addlabel(str(i+1),null,20).pos(x,y+i*30).color(0,0,0);
						var avatar =avatar_url(flist[i].get("id"), flist[i].get("avatar_version"));
						ranklist.addsprite(avatar).pos(x+30,y+i*30-15);
		 				ranklist.addlabel(flist[i].get("name"),null,20).pos(x+100,y+i*30).color(0,0,0);
		 				ranklist.addsprite("menu2/menu2-fight_right.png").size(35,25).pos(x+200,y+i*30).setevent(EVENT_TOUCH,rankdetail,x+200,y+i*30);
		 		}
		}
		
		function rankdetail(x,y){
				rank_top = ranklist.addsprite("home/rank_top.png").size(300,150).pos(50,150);
				rank_top.addlabel("Num",null,20).pos(140,130).color(0,0,0);
				rank_top.addlabel("X",null,8).pos(280,0).color(255,0,0).setevent(EVENT_TOUCH,delrankdetail);				
		}
		
		function delrankdetail(){
				rank_top.removefromparent();
		}
		
		function f(request_id, ret_code, response_content){
				//trace("res: ", response_content);
				if(ret_code==1){
					trace("finished");
					if(label_net){
						label_net.removefromparent();
					}
				}	
				else if(ret_code==0){
					trace("failed");
					label_net = hpn.addlabel("no network, retry","Arial",20,200,100).pos(650,200).color(0,0,0);
					label_net.setevent(EVENT_TOUCH, detectnet);
				}
		}
    
    function detectnet(){
    		http_request("http://papayamobile.com/", f,null,1000,"param");	
    }
}
