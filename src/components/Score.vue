<template>
  <div>
    <x-header></x-header>
    <div class="score-content">
      <p class="info">票数汇总</p>
      <p class="desc">参与人数: {{countInfo.alls}}</p>
      <!-- {{countInfo.address}} /  v-if="isAdmin" -->
      <!-- <p class="desc" v-if="isAdmin">投票情况: {{luckers}} 人投票结果与前{{sport.maxTickets}}项排名一致</p> -->
      <!-- <p class="desc" v-else>你所投的{{voteNum.length}}项{{sport.name}}截止目前总票数如下</p> -->
      <group>
        <cell
          v-for="(user,i) in voteNum"
          :title="(i+1)+'.'+user.vote_name"
          :value="user.vote_nums+' 票'"
          :key="i"
        ></cell>
      </group>
    </div>

    <p class="info">各单位票数汇总</p>
    <group style="margin-bottom:20px;">
      <cell
        v-for="(item,i) in companyInfo"
        :title="item.company_name"
        :value="item.num+' 票'"
        :key="i"
      ></cell>
    </group>

    <!-- <p class="info"> 各地区票数汇总 </p>
    <group style="margin-bottom:20px;">
      <cell
        v-for="(item,i) in provInfo"
        :title="item.prov"
        :value="item.num+' 票'"
        :key="i"
      ></cell>
    </group>-->
    <div style="margin:0 20px 20px 20px;">
      <x-button @click.native="init" type="primary">刷新数据</x-button>
    </div>
    <x-footer />
  </div>
</template>

<script>
import XHeader from "./Header";
import { Cell, Group, Toast, XButton } from "vux";
import util from "../js/common";

import { mapState } from "vuex";
import XFooter from "./Footer";
import * as db from "../js/db";

export default {
  components: {
    XHeader,
    XButton,
    Cell,
    Group,
    Toast,
    XFooter
  },
  data() {
    return {
      voteNum: [],
      countInfo: {
        alls: "",
        address: ""
      },
      luckers: "",
      // provInfo: "",
      companyInfo: ""
    };
  },
  computed: {
    ...mapState(["cdnUrl", "sport", "userInfo"]),
    openid() {
      return this.userInfo.openid;
    },
    isAdmin() {
      return true;
      // return (
      //   [
      //     "oW0w1v4qftC8xUP3q-MPIHtXB7hI",
      //     "oW0w1v28ykr6042MA2XnccUlMsVg",
      //     "oW0w1vxG2WkLPHu6d1tgZVQ_SyC8"
      //   ]
      //     .join(" ")
      //     .indexOf(this.openid) > -1
      // );
    }
  },
  methods: {
    showToast(settings) {
      this.toast.text = settings.text;
      this.toast.type = settings.type;
      this.toast.show = true;
      setTimeout(() => {
        this.toast.show = false;
      }, 1500);
    },
    async getVoteNums() {
      let method = this.isAdmin ? "getCbpmVoteList" : "getCbpmVoteListByOpenid";
      let { data } = await db[method](this.openid);
      this.voteNum = data;
    },
    async getCountInfo() {
      let { data } = await db.getVoteUserAddress();
      this.countInfo = data[0];
    },
    async getPrizeInfo() {
      let { rows, data } = await db.getCbpmLuckyUserList();
      this.luckers = rows > 0 ? data[0].luckers : 0;
    },
    // async getVoteByProv() {
    //   let { data } = await db.getCbpmVoteMainByProv();
    //   this.provInfo = data;
    // },
    async getCompanyInfo() {
      let { data } = await db.getCbpmVoteMainByCompany();
      this.companyInfo = data;
    },
    init() {
      this.getVoteNums();
      if (this.isAdmin) {
        this.getCountInfo();
        this.getPrizeInfo();
        // this.getVoteByProv();
        this.getCompanyInfo();
      }
    }
  },
  created() {
    // if (this.openid == null) {
    //   this.$router.push("/follow");
    //   return;
    // }
    this.init();
  }
};
</script>

<style lang="less" scoped>
.score-content {
  padding: 15px;
  padding-top: 0px;
  .info {
    font-size: 20px;
    font-weight: bold;
    padding-bottom: 5px;
    padding-left: 10px;
  }
  .desc {
    padding-top: 5px;
    color: #636563;
    font-size: 16px;
    text-align: left;
  }
}
.info {
  font-size: 20px;
  font-weight: bold;
  padding-bottom: 5px;
  padding-top: 20px;
}
</style>
