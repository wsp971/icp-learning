
import List  "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor {
    public type Message = {
        content:Text;
        time:Time.Time;
    };
    public type Microblog =  actor { 
        follow : shared (Principal) -> async (); //添加关注对象
        follows : shared query () -> async [Principal]; //查询关注者
        post : shared (Text) -> async (); //发布新消息
        posts : shared query(since:Time.Time) -> async [Message]; //查询所有发布的消息
        timeline :  shared  (since:Time.Time) -> async [Message]; // 返回所有关注者发布的消息
    };

    var followed:List.List<Principal> = List.nil();

    public shared func follow(id : Principal):async() {
        followed:= List.push(id,followed);
    };
    public shared query func follows() : async [Principal]{
        List.toArray<Principal>(followed);
    };

    stable var messages: List.List<Message> = List.nil<Message>();

    public shared (msg) func post(text: Text): async () {
        // 暂时注释掉调用验证
        // assert(Principal.toText(msg.caller) == "uf56a-ftd2m-vspy4-s3rg5-c2lu4-b5t5g-clru6-cd2e5-v53hf-6uo2c-7ae");
        let newMessage = {
            content = text;
            time = Time.now();
        };
        messages:= List.push(newMessage, messages);
    };


    public shared query func posts(since:Time.Time): async [Message]{
        let filterMessage = List.filter<Message>(messages, func (message){
            message.time >= since;
        });
        List.toArray(filterMessage);
    };

    public shared  func timeline(since:Time.Time): async [Message] {
        var all:List.List<Message> = List.nil<Message>();
        for( id in Iter.fromList(followed)) {
            let canister: Microblog = actor(Principal.toText(id));
            let msgs:[Message] = await canister.posts(since);
            for(msg in Iter.fromArray(msgs)){
                all:=List.push(msg,all);
            };
        };
        List.toArray(all);
    };
};