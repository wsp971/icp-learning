<template>
    <section class="weui-flex__item ">
      <div class="weui-cells__title"> <i  @click="back" class="weui-icon-back-arrow-thin" v-show="!isAllTimeline"></i> {{title}}  </div>
      <div class="weui-panel" style="height:100%; overflow:scroll;">
        <LoadingLine :isShow="loading"/>
        <div class="weui-panel__bd">
          <div class="weui-media-box weui-media-box_text" v-for="(blog,index) in dataList" :key="index">
            <strong class="weui-media-box__title">{{blog.author}}</strong>
            <p class="weui-media-box__desc">{{blog.content}}</p>
            <ul class="weui-media-box__info">
              <li class="weui-media-box__info__meta">{{blog.time | formatTime}}</li>
            </ul>
          </div>
        </div>
        <div class="weui-loadmore weui-loadmore_line" v-show="noData">
            <span class="weui-loadmore__tips">暂无数据~</span>
        </div>
      </div>
    </section>
</template>
<script>
import dayjs from 'dayjs';
import LoadingLine from './loading-inline.vue'
export default {
  props:['timeline','loading', 'myPosts','pid'],
  components:{
    LoadingLine
  },
  filters:{
    formatTime(time){
      return dayjs(Number(BigInt(time)/1000000n)).format('YYYY-MM-DD hh:mm:ss');
    }
  },
  computed:{
    dataList(){
      if(this.myPosts && this.myPosts.length > 0){
        return this.myPosts;
      }
      return this.timeline;
    },
    noData(){
      return !this.loading && this.dataList.length==0
    },
    title(){
      if(this.myPosts && this.myPosts.length > 0){
        return 'myPosts'  
      }
      if(this.pid){
        return "posts by " + this.pid;
      }
      return 'timeline'; 
    },
    isAllTimeline(){
      return !(this.pid || (this.myPosts && this.myPosts.length !=0 ))
    },
  },
  methods:{
    back(){
      this.$emit('back');
    }
  }
}
</script>
<style scoped>
  .weui-panel{
    margin-top:0;
  }
</style>