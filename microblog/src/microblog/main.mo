
import List  "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Set "mo:base/TrieSet";

actor {
    public type Message = {
        content:Text;
        time:Time.Time;
        author:Text;
    };
    public type FollowAuthor = {
        id:Principal;
        name:?Text;
    };

    public type Microblog =  actor {
        follow : shared (Principal) -> async (); //添加关注对象
        unFollow : shared (Principal) -> async (); //取消关注对象
        follows : shared query () -> async [FollowAuthor]; //查询关注者
        post : shared (Text,Text) -> async (); //发布新消息
        posts : shared query(Time.Time) -> async [Message]; //查询所有发布的消息
        timeline :  shared  (Time.Time) -> async [Message]; // 返回所有关注者发布的消息
        set_name : shared (Text) -> async () ; // 设置作者名字
        get_name : shared query () -> async ?Text;  // 获取作者名字
    };

    stable var followed:List.List<Principal> = List.nil();
    stable var auth_name: Text = "31-王世平";
    stable var messages: List.List<Message> = List.nil<Message>();

    public shared func follow(id : Principal):async() {
        // 排除已经关注的
        if(List.some<Principal>(followed, func(item){ id == item;})){
            return;
        };
        followed:= List.push(id, followed);
    };

    public shared func unfollow(id:Principal):async (){
        followed:= List.filter<Principal>(followed, func(item){item != id;});
    };

    public shared  func follows() : async [FollowAuthor]{
        var followAuthors:List.List<FollowAuthor> = List.nil<FollowAuthor>();
        for( id in Iter.fromList(followed)) {
            let canister: Microblog = actor(Principal.toText(id));
            let name : ?Text = await canister.get_name();
            let author = {
                id = id;
                name = name;
            };
            followAuthors:= List.push(author,followAuthors);
        };
        List.toArray(followAuthors);
    };

    public shared (msg) func post(text: Text,secret:Text): async () {
        // 暂时注释掉调用验证
        // assert(Principal.toText(msg.caller) == "uf56a-ftd2m-vspy4-s3rg5-c2lu4-b5t5g-clru6-cd2e5-v53hf-6uo2c-7ae");
        assert(secret == "wangshi");
        let newMessage = {
            content = text;
            time = Time.now();
            author = auth_name;
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
            let userBlogs = await queryFollowsPosts(id,since);
            let userBlogsList:List.List<Message> = List.fromArray(userBlogs);
            all:= List.merge<Message>(all, userBlogsList,func(a,b){ return a.time < b.time;});
        };
        List.toArray(all);
    };

    public shared func queryFollowsPosts(id:Principal,since:Time.Time): async [Message]{
        var all:List.List<Message> = List.nil<Message>();
        let canister: Microblog = actor(Principal.toText(id));
        let msgs:[Message] = await canister.posts(since);
        for(msg in Iter.fromArray(msgs)){
            all:=List.push(msg,all);
        };
        List.toArray(all);
    };
    public shared query func get_name():async Text {
        return auth_name;
    };
    public shared func set_name(name:Text): async() {
        auth_name := name;
    };
};