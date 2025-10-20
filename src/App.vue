<script>
import { imgData } from "./img_data.js";

export default {
  name: "App",
  data() {
    return {
      imgData,
      carouselImg: ["back.png", "outta_my_head.png", "food_chain.png"],
      settings: {
        imgOrigPath: "img/original/",
        imgSmallPath: "img/small/",
        iconPath: "icons/",
        carouselMaxHeight: 700,
        imgThumbHeight: 300,
        imgThumbWidth: 300,
      },
      links: [
        { icon: "deviant.png", url: "https://www.deviantart.com/b4dr1ck", title: "DeviantArt" },
        { icon: "insta.png", url: "https://instagram.com/bad_rick_1988", title: "Instagram" },
        { icon: "pinterest.png", url: "https://www.pinterest.com/badrick251288", title: "Pinterest" },
        { icon: "artstat.png", url: "", title: "ArtStation" },
      ],
    };
  },

  methods: {
    openLink(url, _event) {
      window.open(url, "_blank");
    },
    showImage(event) {
      const a = document.createElement("a");
      a.target = "_blank";
      a.href = event.target.src;
      a.click();
    },
  },
};
</script>

<template>
  <!-- Title -->
  <h1 class="text-h1 text-center">badricks-world.at</h1>
  <!-- Social media links -->
  <div class="d-flex justify-center pb-2">
    <img
      :title="link.title"
      width="40"
      class="ma-2"
      v-for="(link, index) in links"
      :key="'link-' + index"
      :src="`${settings.iconPath}${link.icon}`"
      @click="openLink(link.url, $event)"
      :alt="link.icon" />
  </div>

  <!-- Carousel for featured images -->
  <v-carousel cycle hide-delimiters :height="settings.carouselMaxHeight">
    <v-carousel-item
      cover
      position="right top"
      v-for="(img, index) in carouselImg"
      :key="'carousel-' + index"
      :src="`${settings.imgOrigPath}${img}`"
      :lazy-src="`${settings.imgSmallPath}${img}`"
      :alt="img"></v-carousel-item>
  </v-carousel>

  <!-- Image gallery -->
  <div class="d-flex flex-wrap">
    <v-img
      v-for="(img, index) in imgData"
      :key="'gallery-' + index"
      :img="img"
      :alt="img"
      @click="showImage($event)"
      :height="settings.imgThumbHeight"
      :width="settings.imgThumbWidth"
      class="ma-1"
      cover
      :lazy-src="`${settings.imgSmallPath}${img}`"
      :src="`${settings.imgOrigPath}${img}`">
      <template v-slot:placeholder>
        <div class="d-flex align-center justify-center fill-height">
          <v-progress-circular color="grey-lighten-4" indeterminate></v-progress-circular>
        </div>
      </template>
    </v-img>
  </div>
</template>

<style>
@font-face {
  font-family: "badGrundge";
  src: url("./fonts/bg.ttf");
}

h1 {
  font-family: "badGrundge", sans-serif !important;
}
</style>
