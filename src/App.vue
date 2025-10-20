<script>
import { imgData } from "./img_data.js";

export default {
  name: "App",
  data() {
    return {
      imgData,
      carouselImg: ["back.png", "outta_my_head.png", "food_chain.png"],
      settings: {
        imgOrigPath:"img/original/",
        imgSmallPath: "img/small/",
        carouselMaxHeight: 600,
        imgThumbHeight: 300,
        imgThumbWidth: 300,
      },
    };
  },

  methods: {
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
  <!-- Carousel for featured images -->
  <v-carousel hide-delimiters :height="settings.carouselMaxHeight">
    <v-carousel-item
      cover
      v-for="(img, index) in carouselImg"
      :key="'carousel-' + index"
      :src="`${settings.imgOrigPath}${img}`"
      :lazy-src="`${settings.imgSmallPath}${img}`"
      :alt="img"
      cycle
    ></v-carousel-item>
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
      :src="`${settings.imgOrigPath}${img}`"
    >
      <template v-slot:placeholder>
        <div class="d-flex align-center justify-center fill-height">
          <v-progress-circular color="grey-lighten-4" indeterminate></v-progress-circular>
        </div>
      </template>
    </v-img>
  </div>
</template>

<style></style>
