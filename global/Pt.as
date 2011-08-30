class Pt{
    var a;
    var h;    
    var h1;
 
    function Pt(){
        a = screensize();   
        trace("width:");
        trace(str(a[0]));
        trace(str(a[1]));
        h = 600*a[0]/800;
        h1 = a[1]-h;
        if(h1>0) h1 = 0;
    }

    function paintBg(fn,name){
        return fn.addsprite(name).size(a[0],h).pos(0,h1);
    }

    function paintEm(fn,name,x,y,wi,he){
        return fn.addsprite(name).size(wi*a[0]/800,he*a[0]/800).pos(x*a[0]/800,y*a[0]/800);
    }

    function paintD(fn,name,x,y,wi,he){
        return fn.addsprite(name).size(wi*a[0]/800,he*a[0]/800).pos(x*a[0]/800,y*a[0]/800 - h1);
    }
    
}