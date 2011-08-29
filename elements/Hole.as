class Hole{
    var EAT_TIME = 300;
    const FAINT_TIME = 300;
    const APPEAR_TIME = 800;
    const DISAPPEAR_TIME = 400;
    const WEAPON_TIME = 400;

    var dtf;
    var father_node;
    var this_node;
    var hole_node;
    var ore_node;
    var monster_node;
    var weapon_node;

    var ores;
    var last_ores;
    var position = new Array(2);
    
    var state;
    var stage;
    
    var hpmax;
    var hp;
    var atk;

    var flag;
    var lock;
    
    function Hole(d,f,x,y){
        dtf = d;
        father_node = f;
        position[0] = x;
        position[1] = y;
        ores = 0;
        stage = 0;
        lock = 1;
        
        this_node = dtf.pt.paintEm(father_node,dtf.cg[0],position[0],position[1],150,163).anchor(50,50);
        monster_node = dtf.pt.paintEm(this_node,"",75,81,138,150).anchor(50,50);
        hole_node = dtf.pt.paintEm(monster_node,"",0,0,138,150);
        ore_node = dtf.pt.paintEm(monster_node,"",0,0,138,150);
        this_node.setevent(EVENT_TOUCH,attack);
        this_node.setevent(EVENT_MULTI_TOUCH,attack);
    }
    
    function setUsed(o){
        ores = o;
        ore_node.texture(dtf.cg[4+ores]);
        stage = 0;
        if(dtf.fclev > 40){
            EAT_TIME = 250;
        }
        else{
            EAT_TIME = 300;
        }
    }
    
    function weaponAttack(){
        weapon_node = dtf.pt.paintEm(monster_node,"",-30,-40,276,300).anchor(30,30);
        weapon_node.addaction(sequence(animate(WEAPON_TIME,dtf.cg[2],dtf.cg[3]),callfunc(rm,weapon_node)));
        function rm(x){
            x.removefromparent();
        }
    }
    function canUsed(){
        if(stage == 3){
            dtf.fight.addMonster(hp);
            stage = 0;
        }
        else if(stage == 4){
            dtf.fight.subMonster();
            stage = 0;
        }
        if(stage == 0 && ores > 0){
            return 1;
        }
        else{
            return 0;
        }
    }

    function addMonster(hm,h){
        hpmax = hm;
        hp = h;
        atk = 1;
        last_ores = ores;
        if(h>0){
            setState();
            stage = 1;
            this_node.texture();
            hole_node.texture(dtf.cg[1]);
            monster_node.addaction(sequence(animate(APPEAR_TIME,dtf.cg[10+state],dtf.cg[13+state],dtf.cg[16+state],
                                                    dtf.cg[19+state]),callfunc(begin_eat)));
            ore_node.addaction(sequence(delaytime(APPEAR_TIME/2),callfunc(unlock)));
        }
    }
    function begin_eat(){
        stage = 2;
        flag = 0;
        monster_node.addaction(sequence(stop(),delaytime(FAINT_TIME),callfunc(unlock),
                                repeat(callfunc(eat),delaytime(EAT_TIME))));
    }
    
    function eat(){
        stage = 2;
        monster_node.texture(dtf.cg[28+flag*3+state]);
        flag = flag +1;
        if(flag == 2){
            ore_node.texture(dtf.cg[3+ores]);
        }
        else{
            if(flag == 3){
                disappear();
                ores--;
                ore_node.texture(dtf.cg[4+ores]);
            }
        }
    }
    
    function disappear(){
        lock = 1;
        monster_node.addaction(sequence(stop(),delaytime(EAT_TIME/2),animate(DISAPPEAR_TIME,dtf.cg[19+state],
                                dtf.cg[16+state],dtf.cg[13+state],dtf.cg[10+state]),callfunc(removeMonster)));
    }
    
    function removeMonster(){
        this_node.texture(dtf.cg[0]);
        monster_node.texture();
        hole_node.texture();
        this_node.addaction(callfunc(setStage));
    }
    function attack(){
        if(hp > 0 && lock == 0){
            lock = 1;
            monster_node.addaction(sequence(stop(),delaytime(WEAPON_TIME/2),callfunc(changeMonster)));
            weaponAttack();
        }
    }
    
    function changeMonster(){
        hp = hp - atk;
        setState();
        if(hp <= 0){
            ores = last_ores;
            ore_node.texture(dtf.cg[4+ores]);
            monster_node.texture(dtf.cg[37]);
            monster_node.addaction(sequence(stop(),delaytime(2*EAT_TIME),callfunc(removeMonster)));
        }
        else{
            monster_node.texture(dtf.cg[19+3*stage+state]);
            if(stage == 1){
                monster_node.addaction(sequence(stop(),delaytime(2*EAT_TIME),callfunc(removeMonster)));
            }
            else{
                ores = last_ores;
                ore_node.texture(dtf.cg[4+ores]);
                begin_eat();
            }
        }
    }
    
    
    function unlock(){
        lock = 0;
    }
    
    function setStage(){
        if(hp>0){
            stage = 3;
        }
        else{
            stage = 4;
        }
    }
        
    function setState(){
        if(hp > hpmax * 79 / 100){
            state = 0;
        }
        else{
            if(hp > hpmax *39/100){
                state = 1;
            }
            else{
                state = 2;
            }
        }
    }
    
    function delehole(){ 
        monster_node.addaction(stop());
        monster_node = 0;
        hole_node = 0;
        ore_node = 0;
        weapon_node = 0;
        this_node.removefromparent();
        this_node = 0;
        dtf = 0;
        father_node = 0;
    }
}