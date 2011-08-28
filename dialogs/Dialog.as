class Dialog{
    var dtf;
    var father_node; 
    
    var this_node;
    var dark_node;
    
    var key_node;
    var key_pathname;
    var back_path;

    function Dialog(para_dtf,para_fn,para_kn,para_kpn){
        dtf = para_dtf;
        father_node = para_fn;
        key_node = para_kn;
        key_pathname = para_kpn;
    }
    
    function showBg(bg){
        dtf.home.pausePage();
        dark_node = dtf.pt.paintEm(father_node,"dark.png",0,0,800,600);
        if(key_node != null){
            key_node.texture(key_pathname+"_on.png");
        }
        this_node = dtf.pt.paintEm(father_node,bg,85,-600,630,596);
        this_node.focus(1);
        this_node.setevent(EVENT_KEYDOWN,keydown);
        this_node.addaction(sequence(delaytime(100),moveby(600,0,dtf.pt.a[0]/2),moveby(400,0,3*dtf.pt.a[0]/16)));
    }
    
    function setbackPath(b){
        back_path = b;
    }
    
    function showBackbtn(w,h){
        var back_btn = dtf.pt.paintEm(this_node,back_path+".png",w,h,170,50);
        back_btn.setevent(EVENT_TOUCH,back_btnClicked);
    }
    
    function showTitle(path,w){
        return dtf.pt.paintEm(this_node,path,315,265,w,48).anchor(50,50);
    }
    
    function keydown(n,e,p,kc){
        if(kc==4){
            closeDialog(exitDialog);
        }
    }
    
    function back_btnClicked(bnode){
        bnode.texture(back_path+"_on.png");
        closeDialog(exitDialog);
    }
    
    function closeDialog(f){
        dtf.home.current_dialog = 0;
        this_node.addaction(sequence(moveby(700,0,-3*dtf.pt.a[0]/16),moveby(800,0,-dtf.pt.a[0]/2),delaytime(100),callfunc(f)));
    }
    
    function exitDialog(){
        dark_node.removefromparent();
        this_node.removefromparent();
        father_node.focus(1);
        
        dtf.home.contiPage();
        if(key_node != null){
            key_node.texture(key_pathname+"_normal.png");
        }
    }
}