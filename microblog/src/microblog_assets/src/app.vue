<template>
  <main class="page  container"  >
      <h1 class="page__hd">course5 - microblog:myname:{{myName}}</h1>
      <div class="weui-flex">
        <section class="weui-flex__item">
          <div class="weui-cells__title">post microblog</div>
          <div class="weui-form">
              <div class="weui-form__text-area">
                <h2 class="weui-form__title">post microblog</h2>
              </div>
              <div class="weui-form__control-area">
                <div class="weui-cells">
                  <label for="blogText" class="weui-cell weui-cell_active">
                    <div class="weui-cell__bd">
                      <textarea name="blogText" cols="30" rows="5" class="weui-textarea"
                        placeholder="请填写microblog 内容" v-model="microblog"></textarea>
                    </div>
                  </label>
                  <label for="secret" class="weui-cell weui-cell_active">
                    <div class="weui-cell__hd">
                      <span class="weui-label">secret</span>
                    </div>
                    <div class="weui-cell__bd">
                      <input type="text"  class="weui-input" v-model="secret">
                    </div>
                  </label>
                </div>
              </div>
              <div class="weui-form__opr-area">
                <button class="weui-btn weui-btn_primary" @click="doPost">posts</button>
              </div>
          </div>
        </section>
        <section class="weui-flex__item">
          <div class="weui-cells__title">关注列表</div>
          <div class="weui-cells">
            <div class="weui-cell">
              <div class="weui-cell__bd">
                <p>王世平</p>
              </div>
              <div class="weui-cell__ft">canister:xxxxxxxx</div>
            </div>
            <div class="weui-cell">
              <div class="weui-cell__bd">
                <p>王世平</p>
              </div>
              <div class="weui-cell__ft">canister:xxxxxxxx</div>
            </div>
            <div class="weui-cell">
              <div class="weui-cell__bd">
                <p>王世平</p>
              </div>
              <div class="weui-cell__ft">canister:xxxxxxxx</div>
            </div>
          </div>
        </section>
        <section class="weui-flex__item ">
          <div class="weui-cells__title">timeline</div>
          <div class="weui-panel">
            <div class="weui-panel__bd">
              <div class="weui-media-box weui-media-box_text" v-for="blog in myPosts">
                <strong class="weui-media-box__title">{{blog.time}}</strong>
                <p class="weui-media-box__desc">{{blog.content}}</p>
                <ul class="weui-media-box__info">
                  <li class="weui-media-box__info__meta">canister</li>
                  <li class="weui-media-box__info__meta">{{blog.content}}</li>
                </ul>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>
</template>
<script>
import { microblog } from "../../declarations/microblog";
export default {
  data(){
    return{
      // 关注列表
      follow_users:[],
      // 
      timeline:[],
      microblog:"",
      secret:'',
      myPosts:[],
      myName:""
    }
  },
  async mounted(){
    await this.getName();
    await this.posts();
  },
  methods:{
    async getName(){
      this.myName = await  microblog.get_name();
    },
    async setName(){
      await microblog.set_name("ssss");
    },
    async getTimeline(){
      const timeline = await microblog.timeline();
      this.timeline = timeline;
    },
    async doPost(){
      if(!(this.microblog && this.secret)){
        alert("param error");
        return;
      }
      try {
        await microblog.post(this.microblog, this.secret);
      } catch (error) {
        alert('error');
      }
      this.microblog = '';
      this.secret = '';
      this.posts();
    },
    async posts(){
      const result = await microblog.posts(0);
      this.myPosts = result;
    },
    async follow(canistid){
      await microblog.follow(canistid);
    },
    async follows(){
      await microblog.follows();
    }
  }
}
</script>
