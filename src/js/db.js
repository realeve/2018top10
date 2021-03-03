import { axios } from "./axios";
/**
 *   @database: { 微信开发 }
 *   @desc:     { 用户是否提交投票 }
 */
export const getCbpmVoteMain = (openid) =>
  axios({
    url: "/143/b91cabf25d.json",
    params: {
      openid,
    },
  });

/**
*   @database: { 微信开发 }
*   @desc:     { 提交十件大事投票信息 } 
    const { nickname, openid, sex, headimgurl, country, province, city, ip, vote_detail,company_id } = params;
*/
export const addCbpmVoteMain = (params) =>
  axios({
    url: "/144/b8fd30dbf7.json",
    params,
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 更新票数 }
 */
export const setCbpmVoteList = (values) =>
  axios({
    url: "/145/c1428e33a7.json",
    params: {
      values,
    },
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 查询投票用户地址信息 }
 */
export const getCbpmVoteUserAddress = (openid) =>
  axios({
    url: "/146/168ea395bf.json",
    params: {
      openid,
    },
  });

/**
*   @database: { 微信开发 }
*   @desc:     { 用户投票地址 } 
    const { user, mobile, prov, city, area, detail, openid } = params;
*/
export const addCbpmVoteUserAddress = (params) =>
  axios({
    url: "/147/8b8ca5e95a.json",
    params,
  });

/**
*   @database: { 微信开发 }
*   @desc:     { 更新地址信息 } 
    const { user, mobile, prov, city, area, detail, openid } = params;
*/
export const setCbpmVoteUserAddress = (params) =>
  axios({
    url: "/154/be12969005.json",
    params,
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 十件大事投票信息填写情况 }
 */
export const getVoteUserAddress = () =>
  axios({
    url: "/148/3be6dd9ef8.json",
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 十件大事投票结果 }
 */
export const getCbpmVoteList = () =>
  axios({
    url: "/149/7477322ba3.json",
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 用户所选项投票结果 }
 */
export const getCbpmVoteListByOpenid = (openid) =>
  axios({
    url: "/150/55c0d3997f.json",
    params: {
      openid,
    },
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 投票结果一致的用户数 }
 */
export const getCbpmLuckyUserList = () =>
  axios({
    url: "/151/1e2fadce6c.json",
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 按省份查询投票数 }
 */
export const getCbpmVoteMainByProv = () =>
  axios({
    url: "/152/175c426091.json",
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 各企业投票数汇总 }
 */
export const getCbpmVoteMainByCompany = () =>
  axios({
    url: "/153/007d24c4e6.json",
  });

/**
 *   @database: { 微信开发 }
 *   @desc:     { 行业十件大事投票成钞公司参与情况 }
 */
export const getCbpcUser2020 = () =>
  axios({
    url: "/399/cb7717a608.json",
  });
