import Vue from 'vue';
import Router from 'vue-router';
import Home from '@/components/Home';
import Info from '@/components/Info';
// import Follow from "@/components/Follow";
import Score from '@/components/Score';
import Message from '@/components/Message';
import HomePage from '@/components/HomePage';
// import Lottery from "@/components/Lottery";
Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      component: HomePage //(resolve) => require(['@/components/HomePage'], resolve)
    },
    {
      path: '/home',
      component: Home //(resolve) => require(['@/components/Home'], resolve)
    },
    {
      path: '/info',
      component: Info //(resolve) => require(['@/components/Info'], resolve)
    },
    // {
    //     path: "/follow",
    //     component: Follow
    // },
    {
      path: '/score',
      component: Score //(resolve) => require(['@/components/Score'], resolve)
    },
    {
      path: '/message',
      component: Message // (resolve) => require(['@/components/Message'], resolve)
    }
    // {
    //     path: '/lottery',
    //     component: Lottery
    // }
  ]
});
