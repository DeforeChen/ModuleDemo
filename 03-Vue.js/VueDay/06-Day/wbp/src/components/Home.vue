<template>
  <div>
    <NavHeader :back="false">首页</NavHeader>
    <div class="content">

      <LoadingView v-if="loading"></LoadingView>
      <template v-else>
        <ScrollView :swiperSliders="sliders" class="scrollview"></ScrollView>
        <div class="containerView">
          <h3>热门图书</h3>
          <ul>
            <li v-for="item in hotBooks">
              <img :src="item.bookCover">
              <b>{{item.bookName}}</b>

            </li>
          </ul>
        </div>
      </template>
    </div>
  </div>
</template>

<script>

  import LoadingView from '../Base/Loading'

  import {getHotBook, getSliders, getHomeData} from "../Api";
  import NavHeader from '../Base/NavHeader'

  import ScrollView from '../Base/ScrollView'

  export default {
    name: "Home",
    created() {
      // this.fetchSliders()
      // this.fetchHotBooks()
      this.fetchHomeData()
    },
    data() {
      return {
        sliders: [],
        hotBooks: [],
        loading: true
      }
    },
    methods: {
      // async fetchSliders() {
      //   /* 给data 起别名,对象中的属性必须和得到的结果名字一致 */
      //   this.sliders = await getSliders()
      // },
      // async fetchHotBooks() {
      //   this.hotBooks = await getHotBook()
      // },
      async fetchHomeData() {
        const [s, h] = await getHomeData()
        this.sliders = s
        this.hotBooks = h
        // 数据加载完成,设置loading 状态
        this.loading = false

      }
    },
    components: {
      NavHeader,
      ScrollView,
      LoadingView
    }
  }
</script>

<style scoped lang="less">

  .containerView {
    width: 90%;
    margin: 0 auto;
    h3 {
      color: #999;
      padding: 5px 0;
    }
    ul {
      display: flex;
      flex-wrap: wrap;
      li {
        width: 50%;
        text-align: center;
        margin: 5px 0;
        img {
          width: 100%;
        }

      }
    }
  }

</style>
