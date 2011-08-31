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
        //detectnet();
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
        
        if(dtf.musicplay==1)  
        		music_btn = dtf.pt.paintEm(hpn,"home/music_on2.png",0,493,130,109); 
        else
        		music_btn = dtf.pt.paintEm(hpn,"home/music_off2.png",0,493,130,109);
        music_btn.setevent(EVENT_TOUCH, musicClicked);

        rank_btn = dtf.pt.paintEm(hpn,"home/rank_on2.png",130,493,130,109);
        rank_btn.setevent(EVENT_TOUCH,rankClicked);
        
        fight_btn = dtf.pt.paintEm(hpn,"home/fight_normal.png",260,493,130,109);
        fight_btn.setevent(EVENT_TOUCH,fightClicked);
        
        current_dialog = 0;
    }

    function musicClicked(){
    	  if(dtf.musicplay ==1){
    	  	dtf.music.pause();
    	  	dtf.musicplay =0;
    	  	music_btn.texture("home/music_off2.png");
    	  }
    	  else{
    	  	dtf.music.play(-1);
    	  	dtf.musicplay =1;
    	  	music_btn.texture("home/music_on2.png");
    	  }
    	  music_btn.setevent(EVENT_TOUCH, musicClicked);
    }
    
    function rankClicked(){
    		trace("rankClicked");
    		music_btn.removefromparent();
    		rank_btn.removefromparent();
    		fight_btn.removefromparent();
        addrank();
    }
    
    function addrank(){
    		detectnet();
    	  //ranklist = dtf.pt.paintEm(hpn,"home/rank_detail.png",20,150,420,360);
    	  //var requestId = ppy_query("list_friends", null, hfriend);
    	  //label_rank = hpn.addlabel("something to say~~~~~~~~~~~~~~~~~~","Arial",20,200,100).pos(650,200).color(0,0,0);
    	  //rank2_btn = dtf.pt.paintEm(hpn,"home/close.png",740,400,50,40);
    	  //rank2_btn.setevent(EVENT_TOUCH,addmenu);
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

    
    function keydown(n,e,p,kc){
        if(kc == 4){
            current_dialog = new ExitDialog(dtf,hpn,null,"home/exit");
            current_dialog.showDialog();
        }
    }
    
		function hfriend(requestId, ret_code, response){
				trace("flist:", response.get("data"));
				var flist = response.get("data");
				trace("show friend");
				var x= 30; var y = 80;
				for(var i = 0; i<len(flist);i++){
						ranklist.addlabel(str(i+1),null,20).pos(x,y+i*30).color(0,0,0);
						var avatar =avatar_url(flist[i].get("id"), flist[i].get("avatar_version"));
						ranklist.addsprite(avatar).size(30,30).pos(x+30,y+i*30);
		 				ranklist.addlabel(flist[i].get("name"),null,20).pos(x+80,y+i*30).color(0,0,0);
		 				ranklist.addsprite("menu2/menu2-fight_right.png").size(35,25).pos(x+200,y+i*30).setevent(EVENT_TOUCH,rankdetail,x+200,y+i*30);
		 		}
		}
		
		function rankdetail(x,y){
				rank_top = ranklist.addsprite("home/rank_top.png").size(300,150).pos(50,150);
				rank_top.addlabel("45",null,20).pos(140,130).color(0,0,0);
				rank_top.addlabel("关闭",null,8).pos(280,0).color(255,0,0).setevent(EVENT_TOUCH,delrankdetail);				
		}
		
		function delrankdetail(){
				rank_top.removefromparent();
		}
		
		function f(request_id, ret_code, response_content){
				//trace("res: ", response_content);
				if(ret_code==1){
					trace("network");
					if(label_net){
						label_net.removefromparent();
					}
					ranklist = dtf.pt.paintEm(hpn,"home/rank_detail.png",20,150,420,360);
    	  	var requestId = ppy_query("list_friends", null, hfriend);
    	 	  label_rank = hpn.addlabel("你知道吗？每周三的0:00点，你的排行榜分数会刷新，想做常胜将军可不是那么容易的哦~","Arial",20,200,100).pos(650,200).color(0,0,0);
    	  	rank2_btn = dtf.pt.paintEm(hpn,"home/close.png",740,400,50,40);
    	  	rank2_btn.setevent(EVENT_TOUCH,addmenu);
				}	
				else if(ret_code==0){
					trace("failed");
					label_net = hpn.addlabel("对不起，您的网络连接出现了问题，点击这里重试","Arial",20,200,100).pos(650,200).color(0,0,0);
					label_net.setevent(EVENT_TOUCH, detectnet);
				}
		}
    
    function detectnet(){
    		http_request("http://papayamobile.com/", f,null,1000,"param");	
    }
}
