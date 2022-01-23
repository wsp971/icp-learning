<template>
    <section class="weui-flex__item ">
      <div class="weui-cells__title">timeline</div>
      <div class="weui-panel" style="height:100%; overflow:scroll;">
        <LoadingLine :isShow="loading"/>
        <div class="weui-panel__bd">
          <div class="weui-media-box weui-media-box_text" v-for="(blog,index) in timeline" :key="index">
            <strong class="weui-media-box__title">{{blog.author}}</strong>
            <p class="weui-media-box__desc">{{blog.content}}</p>
            <ul class="weui-media-box__info">
              <li class="weui-media-box__info__meta">{{blog.time | formatTime}}</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
</template>
<script>
import dayjs from 'dayjs';
import LoadingLine from './loading-inline.vue'
export default {
  props:['timeline','loading'],
  components:{
    LoadingLine
  },
  filters:{
    formatTime(time){
      return dayjs(Number(BigInt(time)/1000000n)).format('YYYY-MM-DD hh:mm:ss');
    }
  },
}
</script>
<style scoped>
  .weui-panel{
    margin-top:0;
  }
</style>