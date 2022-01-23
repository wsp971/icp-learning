<template>
  <section class="weui-flex__item">
    <div class="weui-cells__title">关注列表</div>
    <div class="weui-cells"  style="height:100%; overflow:scroll;">
      <InlineLoading :isShow="loading"/>
      <a class="weui-cell  weui-cell_access" v-for="(user,index) in followUsers" :key="index" @click="queryBlogById(user.id)">
        <span class="weui-cell__bd">
            <span>{{user.name}}</span>
            <div class="weui-cell__desc">canister:{{user.id}}</div>
        </span>
        <span class="weui-cell__ft">
        </span>
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
    }
  }
  
}
</script>