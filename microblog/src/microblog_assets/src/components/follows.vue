<template>
  <section class="weui-flex__item">
    <div class="weui-cells__title">my follows</div>
    <div class="weui-cells"  >
      <InlineLoading :isShow="loading"/>
      <a class="weui-cell  weui-cell_access" v-for="(user,index) in followUsers" :key="index" @click="queryBlogById(user.id)">
        <span class="weui-cell__bd">
            <span>{{user.name}}</span>
            <div class="weui-cell__desc">canister:{{user.id}}</div>
        </span>
        <span class="weui-cell__ft">
        </span>
      </a>
      <div class="weui-loadmore weui-loadmore_line" v-show="noData">
          <span class="weui-loadmore__tips">还没有关注任何人哦~</span>
      </div>
    </div>
    <div class="my-posts">
      <a class="weui-cell weui-cell_active weui-cell_access weui-cell_link" @click="myPosts">
          <span class="weui-cell__bd">my posts</span>
          <span class="weui-cell__ft"></span>
      </a>    
    </div>
  </section>
</template>
<script>
import {microblog} from '../../../declarations/microblog';
import InlineLoading from './loading-inline.vue'

export default {
  props:{
    canisid:{
      default:0,
    }
  },
  data(){
    return {
      followUsers:[],
      loading:false,
    }
  },
  components:{
    InlineLoading
  },
  async mounted(){
    await this.follows();
  },
  computed:{
    noData(){
      return !this.loading && this.followUsers.length==0
    }
  },
  methods:{
      // 查询关注者
    async follows(){
      this.loading = true;
      try {
          const result = await microblog.follows();
          console.log('follows',result);
          this.followUsers = result;
      } catch (error) {
        this.$toast.failure('query follows failure');
      }
      this.loading = false;
    },
    queryBlogById(id){
      this.$emit('queryById',id);
    },
    myPosts(){
      this.$emit('myposts');
    }
  }
  
}
</script>
<style>
  .my-posts{
    background: #fff;
    margin-top: 10px;
  }
</style>