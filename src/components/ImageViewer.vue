<script>
export default {
  name: "ImageViewer",
  props: {
    imgFile: {
      type: String,
      required: true,
    },
    imgTitle: {
      type: String,
      required: false,
    },
    imgDesc: {
      type: String,
      required: false,
    },
    settings: {
      type: Object,
      required: false,
    },
  },
  data() {
    return {
      showInfo: false,
    };
  },
  computed: {
    infoBtnColor() {
      return !this.showInfo ? "" : "grey";
    },
  },
  methods: {
    toggleShowInfo() {
      this.showInfo = !this.showInfo;
    },
    close() {
      this.$emit("close");
    },
    downloadImage(event) {
      event.stopPropagation();
      const link = document.createElement("a");
      link.href = `${this.settings.imgOrigPath}${this.imgFile}`;
      link.download = this.imgFile;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    },
    showImage(event) {
      const a = document.createElement("a");
      a.target = "_blank";
      a.href = `${this.settings.imgOrigPath}${this.imgFile}`;
      a.click();
    },
  },
};
</script>

<template>
  <div class="overlay pa-2" style="width: 100%; height: 100%; position: fixed; z-index: 100">
    <div style="z-index: 200" class="position-absolute">
      <v-btn title="Close" class="mx-1" @click="close()" icon="mdi-close"></v-btn>
      <v-btn :color="infoBtnColor" title="Toggle Information" class="mx-1" @click="toggleShowInfo" icon="mdi-information"></v-btn>
      <v-btn title="Download Image" class="mx-1" @click="downloadImage($event)" icon="mdi-download"></v-btn>
      <v-btn title="Show Image" class="mx-1" @click="showImage($event)" icon="mdi-image"></v-btn>
    </div>
    <div style="z-index: 300; width: 100%" class="position-absolute mt-15 overlay" v-if="showInfo">
      <h2 class="text-h5 text-left">{{ imgTitle }}</h2>
      <p v-html="imgDesc" class="text-body-1 text-left mt-2 pa-2"></p>
    </div>
    <v-img
      height="100%"
      @click="close"
      :lazy-src="`${settings.imgThumbnailsPath}${imgFile}`"
      :src="`${settings.imgOrigPath}${imgFile}`"
      :alt="imgTitle"></v-img>
  </div>
</template>

<style>
.overlay {
  background-color: rgba(0, 0, 0, 0.9);
}
</style>
