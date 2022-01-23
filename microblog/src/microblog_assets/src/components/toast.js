import Toast from './toasts';
let instance ;
export default {
  install(Vue, options){
    if(instance){
      return ;
    }
    const Constructor = Vue.extend(Toast);
    instance = new Constructor();
    instance.$mount();
    document.body.append(instance.$el);
    Vue.prototype.$toast = {
      loading(){
        instance.loading();
      },
      success(msg){
        instance.success(msg);
      },
      failure(msg){
        instance.failure(msg);
      }
    }
  }
}