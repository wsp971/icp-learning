<template>
  <div class="weui-panel header">
    <div class="weui-panel__hd">
      <div class="weui-flex">
        <div class="weui-flex__item">
          <strong class="weui-media-box__title">courser5: microblog </strong>
          <p class="weui-media-box__desc">myname: {{myName}},canister: <strong>zwgqu-qyaaa-aaaai-abgpq-cai</strong></p>      
        </div>
        <label class=" weui-flex weui-cell_active" style="width: 500px;">
          <div class="weui-cell__hd"><span class="weui-label">pricipleid</span></div>
          <div class="weui-cell__bd">
              <input id="js_input2" class="weui-input" placeholder=" input your principal for follow you" v-model="principleid">
          </div>
          <div class="weui-cell__ft" style="margin-left:10px">
            <button class="weui-btn weui-btn_mini weui-btn_primary" @click="follow">follow 
                <span class="weui-primary-loading weui-primary-loading_transparent" v-show="following">
                  <span class="weui-primary-loading__dot"></span>
                </span>
            </button>
          </div>
        </label>
      </div>
    </div>
  </div>
</template>
<script>
import {microblog} from '../../../declarations/microblog';
import {Principal} from '@dfinity/principal';
export default {
  name:"Header",
  props:['myName'],
  data(){
    return {
      principleid:'',
      following:false
    };
  },
  methods:{
        // 关注别人
    async follow(){
      if(!this.principleid){
        return;
      }
      if(this.following){
        return ;
      }
      this.following = true;
      try {
        await microblog.follow(Principal.fromText(this.principleid));
        this.$emit('followSuccess');
        this.$toast.success('follow success !');
      } catch (error) {
        console.log('关注失败',error);
        this.$toast.failure('follow failure!');
      }
      this.following = false;
      this.principleid = '';
    }, 
    }
}
</script>

<style>
  .header{
    height: var(--header-height);
  }
</style>