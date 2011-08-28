import dialogs.FightEndDialog;
import elements.Hole;

class Fight{
    var dtf;
    var fn;
    
    var score_node;
    var stage_node;
    var max_node;
    var now_node;

    var now_monsters;
    var num_monsters;
    var monsters;
    var hole;
    
    var left_ores;
    var base_ores;
    var hpmax;
    var max_monsters;
    var tick;
    var score;
    
    function Fight(d){
        dtf = d;
        paint();
    }

    function initialHole(){
        var i,j,k;
        for(i = 0;i<10; i++){
            j = rand(10-i);
            if(j>=left_ores || base_ores==4){
                k = 0;
            }
            else{
                left_ores--;
                k = 1;
            }
            hole[i].setUsed(k+base_ores);
        }
    }
    
    function removeHole(){
        for(var i=0;i<10;i++){
            hole[i].delehole();
        }
        hole = 0;
    }
    
    function removeNum(){
        stage_node.removefromparent();
        max_node.removefromparent();
        now_node.removefromparent();
    }
    
    function initialMonsters(){
        num_monsters = max_monsters;
        now_monsters = max_monsters;
        for(var i=0;i<num_monsters;i++){
            monsters[i] = hpmax;
        }
    }
    
    function initialStage(){
        if(dtf.fclev >= 10){
            stage_node = dtf.pt.paintEm(fn,dtf.cg[40+dtf.fclev/10],752,290,22,30);
            dtf.pt.paintEm(stage_node,dtf.cg[40+dtf.fclev%10],15,2,22,30);
        }
        else{
            stage_node = dtf.pt.paintEm(fn,dtf.cg[40+dtf.fclev],757,291,22,30);
        }

        max_monsters = 6 + (dtf.fclev-1)%10;
        hpmax = (dtf.fclev-1)%40/10+2;
        tick = 1800 - (dtf.fclev-1)%10/2*300;
        left_ores = 7 - (dtf.fclev-1)%10/2;
        base_ores = 1+(dtf.fclev-1)%40/10;
    }
   
    function initialScore(){
        if(max_monsters >= 10){
            max_node = dtf.pt.paintEm(score_node,dtf.cg[50+max_monsters/10],80,10,44,60);
            dtf.pt.paintEm(max_node,dtf.cg[50+max_monsters%10],22,0,44,60);
        }
        else{
            max_node = dtf.pt.paintEm(score_node,dtf.cg[50+max_monsters],92,10,44,60);
        }
        set_now_monsters();
    }
    
    function set_now_monsters(){
        if(now_monsters >= 10){
            now_node = dtf.pt.paintEm(score_node,dtf.cg[50+now_monsters/10],7,10,44,60);
            dtf.pt.paintEm(now_node,dtf.cg[50+now_monsters%10],22,0,44,60);
        }
        else{
            now_node = dtf.pt.paintEm(score_node,dtf.cg[50+now_monsters],25,10,44,60);
        }
    }
    
    function paint(){
        fn = dtf.pt.paintBg(dtf.gs,"fight/background.png");
        fn.focus(1);
        hole = new Array(10);
        hole[0] = new Hole(dtf,fn,250,280);
        hole[1] = new Hole(dtf,fn,400,280);
        hole[2] = new Hole(dtf,fn,550,280);
        hole[3] = new Hole(dtf,fn,250,392);
        hole[4] = new Hole(dtf,fn,400,392);
        hole[5] = new Hole(dtf,fn,550,392);
        hole[6] = new Hole(dtf,fn,175,505);
        hole[7] = new Hole(dtf,fn,325,505);
        hole[8] = new Hole(dtf,fn,475,505);
        hole[9] = new Hole(dtf,fn,625,505);

        monsters = new Array(15);
        score_node = dtf.pt.paintD(fn,dtf.cg[9],7,0,158,70);
        //score_node.texture(dtf.cg[9]);
        initial();
    }
    
    function initial(){
        initialStage();
        initialMonsters();
        initialScore();
        initialHole();

        fn.addaction(sequence(delaytime(2000),callfunc(start)));
    }
    
    function start(){
        fn.setevent(EVENT_KEYDOWN,backClicked);
        fn.addaction(repeat(callfunc(refresh),delaytime(tick)));
    }
    
    function refresh(){
        if(check_ores() <= 6){
            end(0);
        }
        else{
            if(now_monsters == 0){
                end(1);
            }
            else{
                randHole();
            }
        }
    }
    
    function end(x){
        fn.addaction(stop());
        var fedialog = new FightEndDialog(dtf,fn);
        fedialog.showDialog();
        fedialog.setstate(x);

        if(x == 1){
            dtf.fclev = dtf.fclev % 80 + 1;
            if(dtf.fclev > dtf.flev){
                dtf.flev = dtf.fclev;
            }
            compute_score();
            fedialog.setscore(score,dtf.best);
            Fwr.writeF(str(dtf.flev)+"a"+str(dtf.fclev)+"a"+str(dtf.best));
        }
    }
    
    function compute_score(){
        score = check_ores()*9 + 17*dtf.fclev;
        if(score > dtf.best){
            dtf.best = score;
        }
    }
    
    function randHole(){
        var holeUsed = range(10);
        var maxUsed = 10;
        for(var i = 0;i<10;i++){
            if(hole[i].canUsed() != 1){
                for(var j=i+maxUsed -10;j<10;j++){
                    holeUsed[j]++;
                }
                maxUsed--;
            }
        }
        if(maxUsed > 0 && num_monsters > 0){
            var l = rand(num_monsters);
            var k = monsters[l];
            num_monsters--;
            monsters[l] = monsters[num_monsters];
            monsters[num_monsters] = 0;
            hole[holeUsed[rand(maxUsed)]].addMonster(hpmax,k);
        }
    }
    
    function addMonster(h){
        monsters[num_monsters] = h;
        num_monsters++;
    }
    
    function subMonster(){
        now_monsters--;
        if(now_monsters < num_monsters){
            now_monsters = num_monsters;
        }
        now_node.removefromparent();
        set_now_monsters();
    }
    
    function check_ores(){
        var num = 0;
        for(var i = 0;i<10;i++){
            num = num + hole[i].ores;
        }
        return num;
    }

    function backClicked(n,e,p,kc){
        if(kc == 4){
        //fn.addaction(sequence(stop(),callfunc(closePage)));
        }
    }
    
    function closePage(){
        fn.addaction(sequence(delaytime(200),callfunc(showHomepage),delaytime(500),callfunc(removeHole),
                                                delaytime(300),callfunc(removeNum)));
    }
    
    function showHomepage(){
        fn.removefromparent();
        dtf.home.hpn.visible(1);
        dtf.home.hpn.focus(1);
        dtf.home.contiPage();
        dtf.fight = 0;
    }
    
    function restart(){
        removeNum();
        initial();
    }
}