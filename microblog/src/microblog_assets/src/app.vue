<template>
  <main class="page container" >
    <Header :my-name="myName" @followSuccess="refrsh"/>
      <div class="weui-flex content">
        <Post />
        <Follows @queryById="queryBlogById" ref="Follow" @myposts="posts"/>
        <Timeline :timeline="timeline" :myPosts="myPosts" :loading="timelineLoading"  :pid="pid" @back="back"/>
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
      isQueryMyposts:false,
      isQueryTimeline:false,
      pid:''
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
      this.getName();
      // 获取时间线
      this.getTimeline();
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
      this.$refs.Follow.follows();
      this.back();
    },
    back(){
      if(this.timelineLoading){
        return;
      }
      this.pid = '';
      this.timeline=[];
      this.myPosts = [];
      this.getTimeline();
    },
    // 获取微博
    async getTimeline(){
      if(this.timelineLoading){
        return;
      }
      try {
        this.isQueryTimeline = true;
        const timeline = await microblog.timeline(0);
        this.timeline = timeline;
        this.isQueryTimeline = false;
      } catch (error) {
        console.log('queryTimeline',error)
      }
    },
    //获取我的发布
    async posts(){
      if(this.timelineLoading){
        return;
      }
      try {
        this.isQueryMyposts = true;
        const result = await microblog.posts(0);
        this.myPosts = result;
      } catch (error) {
        console.log('get my Posts error',error);
      }
      this.isQueryMyposts = false;
    },
    // 查询某个人的微博
    async queryBlogById(id){
      if(this.timelineLoading){
        return;
      }
      try {
        this.isQueryTimeline = true;
        this.pid=id;
        this.myPosts = [];
        this.timeline = [];
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
  },
  computed:{
    timelineLoading(){
      return this.isQueryTimeline || this.isQueryMyposts;
    }
  }
}
</script>

<style >
  .content {
    height: calc(100vh - var(--header-height));
  }
 
  @media screen and (max-width:375px){
    .weui-flex.content{
      overflow: scroll;
    }
    .weui-flex__item{
      width: 100%;
      box-sizing: border-box;
      flex: auto;
    }
    body{
      --header-height: 130px;
    }

    .weui-form{
      min-height: unset;
    }
  }
</style>
