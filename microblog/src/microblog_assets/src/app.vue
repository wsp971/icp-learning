<template>
  <main class="page container" >
    <Header :my-name="myName" @followSuccess="refrsh"/>
      <div class="weui-flex content">
        <Post />
        <Follows @queryById="queryBlogById" ref="Follow"/>
        <Timeline :timeline="timeline" :loading="isQueryTimeline"/>
      </div>
  </main>
</template>
<script>
import { microblog } from "../../declarations/microblog";

import Header from './components/header.vue'
import Post from './components/post.vue'
import Follows from './components/follows.vue';
import Timeline from './components/timeline.vue';

export default {
  data(){
    return{
      // 微博时间线
      timeline:[],
      // 我的发布
      myPosts:[],
      // 我的名字
      myName:"",

      isQueryTimeline:false
    }
  },
  components:{
    Header,
    Post,
    Follows,
    Timeline
  },
  async mounted(){
    try {
      // 获取我的名字
      await this.getName();
      // 获取时间线
      await this.getTimeline();
    } catch (error) {
    }
  },
  
  methods:{
    async getName(){
      this.myName = await  microblog.get_name();
    },
    // 设置我的名称
    async setName(){
      await microblog.set_name("ssss");
    },
    async refrsh(){
      // 获取时间线
      await this.getTimeline();
      await this.$refs.Follow.follows();
    
    },
    // 获取微博
    async getTimeline(){
      this.isQueryTimeline = true;
      const timeline = await microblog.timeline(0);
      this.timeline = timeline;
      this.isQueryTimeline = false;
    },
    
    //获取我的发布
    async posts(){
      const result = await microblog.posts(0);
      this.myPosts = result;
    },
    
  
    
    // 查询某个人的微博
    async queryBlogById(id){
      try {
        this.isQueryTimeline = true;
        console.log('id',id);
        const result  = await microblog.queryFollowsPosts(id,0);
        this.timeline  = result;
        console.log('success',result);
      } catch (error) {
        alert('error');
        console.error(error,'queryBlogByid');
      }
      this.isQueryTimeline = false;
    }
  }
}
</script>

<style>
  .content {
    height: calc(100vh - var(--header-height));
  }
</style>
