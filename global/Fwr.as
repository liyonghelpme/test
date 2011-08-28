class Fwr{
    static function readF(){
        var f = c_file_open("stc");
        if(c_file_exist(f) == 0){
            //file exist only when we open it and write into data
            trace("create file");
            return 0;
        }
        return c_file_op(0,f);
    }
    
    static function writeF(b){
        var f = c_file_open("stc");
        c_file_op(1,f,b);
    }
}