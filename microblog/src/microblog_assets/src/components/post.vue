<template>
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
                  <span class="weui-label">password</span>
                </div>
                <div class="weui-cell__bd">
                  <input type="text"  class="weui-input" placeholder="请输入密码" v-model="secret">
                </div>
              </label>
            </div>
          </div>
          <div class="weui-form__opr-area">
            <button class="weui-btn weui-btn_primary" @click="doPost">posts 
                <span class="weui-primary-loading weui-primary-loading_transparent" v-show="isPost">
                  <span class="weui-primary-loading__dot"></span>
                </span>
            </button>
          </div>
      </div>
    </section>
</template>

<script>
import { microblog } from "../../../declarations/microblog";
export default {

  data(){
    return {
        // 微博填写内容
      microblog:"",
      // 发微博密码
      secret:'',
      isPost:false
    }
  },
  
  methods:{
    // 发布微博
    async doPost(){
      if(!(this.microblog && this.secret)){
        this.$toast.failure('输入content和secret');
        return;
      }
      try {
        this.isPost = true;
        await microblog.post(this.microblog, this.secret);
      } catch (error) {
        this.$toast.failure('发表失败');
        console.log('post error',error)
      }
      this.$toast.success('post success!');
      this.microblog = '';
      this.secret = '';
      this.isPost = false;
    },
  }
}
</script>