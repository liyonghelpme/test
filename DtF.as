import global.DtF;
import global.Pt;
import global.Fwr;
import pages.Home;
function initialize(){
    var dtf = new DtF();    
    dtf.gs = getscene();
    dtf.pt = new Pt();
    var a = Fwr.readF();
    if(a == 0){        
        a = "1a1a0";
        Fwr.writeF(a);
    }
    var b = a.split("a");
    if(len(b) != 3){
        b = new Array("1","1","0");
        Fwr.writeF("1a1a0");
    }
    dtf.flev = int(b[0]);
    dtf.fclev = int(b[1]);
    dtf.best = int(b[2]);

    dtf.cg = new Array(60);
    var i;
    for(i=0;i<38;i++){
        dtf.cg[i] = fetch("fight/"+str(i)+".png");
    }
    dtf.cg[38] = fetch("home/girl1.png");
    dtf.cg[39] = fetch("home/girl2.png");
    for(i=0;i<20;i++){
        dtf.cg[40+i] = fetch("font/"+str(i)+".png");
    }
        
    dtf.home = new Home(dtf);
    dtf.music = createaudio("dtf.mp3");
    dtf.music.play(-1);
    dtf.musicplay = 1;
    return -1;
}