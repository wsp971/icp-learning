<template>
  <div v-show="isShow">
      <div class="weui-mask_transparent"></div>
      <div class="weui-toast" v-if="msgType=='loading'">
        <span class="weui-primary-loading weui-icon_toast">
          <span class="weui-primary-loading__dot"></span>
        </span>
        <p class="weui-toast__content">{{msgContent}}</p>
      </div>
      <div class="weui-toast" v-else-if="msgType=='success'">
        <i class="weui-icon-success-no-circle weui-icon_toast"></i>
        <p class="weui-toast__content">{{msgContent}}</p>
      </div>
      <div class="weui-toast" v-else-if="msgType == 'fail'">
          <i class="weui-icon-warn weui-icon_toast"></i>
          <p class="weui-toast__content">{{msgContent}}</p>
      </div>
  </div>
</template>

<script>
export default {
  data(){
    return {
      isShow: false,
      msgType:"",
      msgContent:''
    }
  },
  methods:{
    show(){
      this.isShow = true;
      this.hide();
    },
    loading(){
      this.msgType = "loading";
      this.show();
    },
    success(msg){
      this.msgType = 'success';
      this.msgContent = msg;
      this.show();
    },
    failure(msg){
      this.msgType = 'fail';
      this.msgContent = msg;
      this.show();
    },
    hide(){
      setTimeout(()=>{
        this.isShow = false;
        this.msgType = '';
        this.msgContent = '';
      },2000);
    }
  }
}
</script>