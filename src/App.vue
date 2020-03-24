<template>
  <div id="app">
    <loading v-if="isLoading" v-model="isLoading" />
    <router-view v-else />
  </div>
</template>

<script>
import { Loading } from "vux";

// import { querystring } from "vux";

import qs from "qs";
import wx from "weixin-js-sdk";

import { mapState, mapMutations } from "vuex";
import { axios } from "./js/axios";

export default {
  name: "app",
  components: {
    Loading
  },
  data() {
    return {
      code: "",
      apiId: "wx762c9153df774440",
      title: "",
      shouldShare: false
    };
  },
  computed: {
    ...mapState(["cdnUrl", "sport"]),
    isLoading: {
      get() {
        return (
          this.$store.state.isLoading ||
          "undefined" == typeof this.userInfo.openid
        );
      },
      set(val) {
        this.$store.commit("updateLoadingStatus", val);
      }
    },
    userInfo: {
      get() {
        return this.$store.state.userInfo;
      },
      set(val) {
        this.$store.commit("setUserinfo", val);
      }
    },
    // 签名用URL
    url() {
      return window.location.origin + window.location.pathname;
    },
    // 跳转URL
    redirectUrl() {
      return `https://open.weixin.qq.com/connect/oauth2/authorize?appid=${
        this.apiId
      }&redirect_uri=${encodeURIComponent(
        this.url
      )}&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect`;
    },
    shareUrl() {
      // 被分享的链接必须在安全域名中，不能直接分享为 redirectUrl
      // return window.location.href.split("#")[0].split("?")[0];
      let { origin, pathname } = window.location;
      return origin + pathname;
    },
    shouldInitShare() {
      return this.sport.isLogin && this.shouldShare;
    }
  },
  watch: {
    shouldInitShare(val) {
      if (!val) {
        return;
      }
      this.title = `我刚刚参加了${this.sport.name}投票活动，你也来参与吧`;
      this.initWxShare();
    }
  },
  methods: {
    ...mapMutations(["setStore"]),
    wxPermissionInit() {
      return axios({
        params: {
          s: "/weixin/signature",
          url: this.url
        }
      }).then(data => {
        this.wxReady(data);
        this.initWxShare();
        this.shouldShare = true;
      });
    },
    wxReady(obj) {
      let config = {
        debug: false,
        appId: obj.appId,
        timestamp: obj.timestamp,
        nonceStr: obj.nonceStr,
        signature: obj.signature,
        jsApiList: [
          "onMenuShareAppMessage",
          "onMenuShareTimeline"
          // "onMenuShareQQ",
          // "onMenuShareWeibo",
          // "onMenuShareQZone",
          // "hideMenuItems"
          // "getNetworkType"
        ]
      };
      wx.config(config);
    },
    initWxShare() {
      wx.ready(() => {
        let option = {
          title: this.title, // 分享标题
          desc: this.title,
          link: this.shareUrl,
          imgUrl: "https://www.cbpc.ltd/public/cdn/cbpm.jpg",
          type: "",
          dataUrl: "",
          success: function() {},
          cancel: function() {}
        };
        wx.onMenuShareAppMessage(option);
        wx.onMenuShareTimeline(option);
        // wx.onMenuShareQQ(option);
        // wx.onMenuShareWeibo(option);
        // wx.onMenuShareQZone(option);

        // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
        // wx.hideMenuItems({
        //   menuList: [
        //     "menuItem:editTag",
        //     "menuItem:delete",
        //     "menuItem:copyUrl",
        //     "menuItem:originPage",
        //     "menuItem:readMode",
        //     "menuItem:openWithQQBrowser",
        //     "menuItem:openWithSafari",
        //     "menuItem:share:email"
        //   ]
        // });
      });
    },
    // 获取微信用户信息（昵称，地区）
    getWXUserInfo() {
      let userInfo;
      let wx_userinfo = localStorage.getItem("wx_userinfo");

      // localStorage内容需更新
      if (
        null == wx_userinfo ||
        typeof wx_userinfo == "undefined" ||
        typeof wx_userinfo.token == "undefined" ||
        typeof wx_userinfo.timeStamp == "undefined"
      ) {
        this.getWXInfo();
        return;
      }

      // 时长校验
      let timeStamp = lib.getTimestamp();
      let needRefresh = timestamp - wx_userinfo.timeStamp > 1800;
      if (needRefresh) {
        this.getWXInfo();
        return;
      }

      userInfo = JSON.parse(wx_userinfo);
      this.userInfo = userInfo;
    },
    getWXInfo() {
      axios({
        params: {
          s: "/weixin/user_info",
          code: this.code
        }
      }).then(data => {
        this.userInfo = data;
        /*
          20180831:
          Reflect,includes慎用，低版本手机转码报错
        */
        // if (Reflect.get(data, "nickname")) {
        if (typeof data.nickname != "undefined") {
          localStorage.setItem("wx_userinfo", JSON.stringify(data));
        }
      });
    },
    wxInit() {
      if (this.sport.loadWXInfo && !this.needRedirect()) {
        this.getWXUserInfo();
      }
      this.wxPermissionInit();
    },
    needRedirect() {
      let hrefArr = window.location.href.split("?");
      if (hrefArr.length == 1) {
        window.location.href = this.redirectUrl;
        return true;
      }
      let params = qs.parse(hrefArr[1]);
      this.code = params.code;
      return false;
    },
    simulateUserInfo() {
      setTimeout(() => {
        this.userInfo = {
          openid: "oW0w1v4qftC8xUP3q-MPIHtXB7hI",
          nickname: "宾不厌诈",
          sex: 1,
          language: "zh_CN",
          city: "成都",
          province: "四川",
          country: "中国",
          headimgurl:
            "http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKDfy7icjzBBUzP90JZ5E8FIkE9dDOxgdQ7Qb9wHv8Bp3D9O4V7fzGleVvB1bJSKz4TqqDnBmuzFTw/132",
          privilege: [],
          timestamp: 1535994566,
          ip: "172.31.85.39",
          token: "6487423c151badc681e7793bbd335e9d99dcec18"
        };
        localStorage.setItem("wx_userinfo", JSON.stringify(this.userInfo));
      }, 3000);
    }
  },
  created() {
    this.title = this.sport.name + "微信投票活动";

    if (window.location.href.indexOf("#/setting") > 0) {
      this.isAnswered = true;
      return false;
    }

    // 开发模式下，初始化值
    if (process.env.NODE_ENV == "development") {
      // 模拟登录
      this.simulateUserInfo();
      return;
    }

    // 正式环境微信载入
    this.wxInit();
    // this.wxPermissionInit();
  }
};
</script>

<style lang="less">
@import "~vux/src/styles/reset.less";
@import "assets/css/reset.css";
@import "assets/css/slider.less";
</style>
