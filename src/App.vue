<script>
import { imgData } from "./data.js";
import ImageViewer from "./components/ImageViewer.vue";

export default {
  name: "App",
  components: {
    ImageViewer,
  },
  data() {
    return {
      coverCarousel: false,
      showSideNav: false,
      imgOverlay: false,
      imgData,
      imgFile: "",
      imgTitle: "",
      imgDesc: "",
      carouselImg: [
        "back.png",
        "tree.png",
        "crackedFaces.png",
        "girlAndMonstersX.jpg",
        "food_chain.png",
        "afterHours.jpg",
      ],
      settings: {
        imgOrigPath: "/img/original/",
        imgSmallPath: "/img/small/",
        iconPath: "/img/icons/",
        carouselMaxHeight: "82vh",
        imgThumbHeight: 300,
        imgThumbWidth: 300,
      },
      links: [
        { icon: "deviant.png", url: "https://www.deviantart.com/b4dr1ck", title: "DeviantArt" },
        { icon: "insta.png", url: "https://instagram.com/bad_rick_1988", title: "Instagram" },
        { icon: "pinterest.png", url: "https://at.pinterest.com/badrick251288", title: "Pinterest" },
        { icon: "artstat.png", url: "https://badrick.artstation.com/", title: "ArtStation" },
        { icon: "email.png", url: "email", title: "E-Mail" },
      ],
    };
  },

  mounted() {
    this.showOnScroll();
    this.coverOnPortraitFormat();
    window.addEventListener("resize", this.coverOnPortraitFormat);
    window.addEventListener("resize", this.showOnScroll);
    window.addEventListener("scroll", this.showOnScroll);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.coverOnPortraitFormat);
    window.removeEventListener("resize", this.showOnScroll);
    window.removeEventListener("scroll", this.showOnScroll);
  },

  computed: {
    gridViewBtnIcon() {
      if (this.gridView) {
        return "mdi-grid";
      }
      return "mdi-grid-large"
    },
  },
  methods: {
    scrollToArea() {
      const scrollTo = this.$refs["socialLinks"];

      if (scrollTo) {
        scrollTo.scrollIntoView({ behavior: "smooth" });
      }
      this.showSideNav = false;
    },
    coverOnPortraitFormat() {
      if (window.innerHeight > window.innerWidth) {
        this.coverCarousel = true;
        return;
      }
      this.coverCarousel = false;
    },
    showOnScroll() {
      // return true if scrolled more than 300px
      if (window.scrollY > 300) {
        this.showSideNav = true;
        return;
      }
      this.showSideNav = false;
    },
    openLink(url, _event) {
      if (url === "email") {
        alert("Nope!");
        return;
      }
      window.open(url, "_blank");
    },
    showImage(event) {
      this.imgFile = event.currentTarget.getAttribute("img");
      this.imgTitle = this.imgData.find((img) => img.file === this.imgFile).title;
      this.imgDesc = this.imgData.find((img) => img.file === this.imgFile).description;
      this.imgOverlay = true;
    },
  },
};
</script>

<template>
  <!-- Image viewer overlay -->
  <image-viewer
    @close="imgOverlay = false"
    v-if="imgOverlay"
    :settings="settings"
    :imgFile="imgFile"
    :imgTitle="imgTitle"
    :imgDesc="imgDesc"></image-viewer>

  <!-- Social media links -->
  <div id="socialMediaLinks" class="d-flex justify-center pb-2" ref="socialLinks">
    <img
      :title="link.title"
      width="40"
      class="ma-2 cursor-pointer"
      v-for="(link, index) in links"
      :key="'link-' + index"
      :src="`${settings.iconPath}${link.icon}`"
      @click="openLink(link.url, $event)"
      :alt="link.icon" />
  </div>

  <!-- Carousel for featured images -->
  <div id="carousel">
    <!-- Overlay Text -->
    <div id="carousel-overlay" class="d-flex align-center justify-center">
      <!-- Title -->
      <div style="width: 100%">
        <h1 class="text-h1 text-center bg-black pa-0 ma-0">badricks-world.at</h1>
        <p class="text-body-1 text-center bg-black pb-5 ma-0 font-weight-bold">
          All work and no drawing makes badrick a dull boy!
        </p>
      </div>
    </div>
    <v-carousel cycle :height="settings.carouselMaxHeight" :show-arrows="false">
      <v-carousel-item
        :cover="coverCarousel"
        v-for="(img, index) in carouselImg"
        :key="'carousel-' + index"
        :src="`${settings.imgOrigPath}${img}`"
        :lazy-src="`${settings.imgSmallPath}${img}`"
        :alt="img">
      </v-carousel-item>
    </v-carousel>
  </div>
  <!-- Image gallery -->
  <div id="gallery" class="d-flex flex-wrap">
    <v-img
      v-for="(img, index) in imgData"
      :key="'gallery-' + index"
      :img="img.file"
      :alt="img.file"
      @click="showImage($event)"
      :height="settings.imgThumbHeight"
      :width="settings.imgThumbWidth"
      class="ma-1 cursor-pointer"
      cover
      :lazy-src="`${settings.imgSmallPath}${img.file}`"
      :src="`${settings.imgOrigPath}${img.file}`">
      <template v-slot:placeholder>
        <div class="d-flex align-center justify-center fill-height">
          <v-progress-circular color="grey-lighten-4" indeterminate></v-progress-circular>
        </div>
      </template>
      <template v-slot:default>
        <p style="background-color: rgba(0, 0, 0, 0.7); opacity: 0" class="text-body-1 pa-2 text-center text-red">
          {{ img.title }}
        </p>
      </template>
    </v-img>
  </div>

  <!-- Side Navigation-->
  <div v-if="showSideNav" class="position-fixed bottom-0 left-0 pa-4 d-flex flex-column">
    <v-btn title="Scroll To Top" @click="scrollToArea($event)" class="ma-1" icon="mdi-arrow-up-bold-circle"></v-btn>
  </div>

  <footer class="text-center pa-4">
    <p class="text-body-2">© {{ new Date().getFullYear() }} badricks-world.at | All rights reserved.</p>
  </footer>
</template>

<style>
@font-face {
  font-family: "headerFont";
  src: url("/fonts/dirtyego.TTF");
}

h1 {
  font-family: "headerFont", sans-serif !important;
}

#carousel {
  background: linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.85)), url("/img/banner.png") repeat center center;
  background-size: cover;
  height: 82vh;
  position: relative;
}

#carousel-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 10;
  opacity: 0.7;
}

.v-carousel__controls {
  z-index: 20 !important;
}

@keyframes shakeUpDown {
  0% {
    transform: translateY(0);
  }
  25% {
    transform: translateY(5px);
  }
  50% {
    transform: translateY(-5px);
  }
  75% {
    transform: translateY(5px);
  }
  100% {
    transform: translateY(0);
  }
}

#socialMediaLinks img:hover {
  filter: contrast(0) brightness(2);
  animation: shakeUpDown 0.3s ease-in-out;
  animation-iteration-count: 1;
}

#gallery .v-img p {
  opacity: 0 !important;
}

#gallery .v-img:hover p {
  opacity: 1 !important;
  transition: opacity 0.5s ease-in-out;
}

#gallery .v-img img {
  filter: grayscale(0%);
  transition: filter 0.5s ease-in-out;
}

#gallery .v-img:hover img {
  filter: grayscale(100%);
}
</style>

