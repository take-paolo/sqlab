<template>
  <div class="main-visual-decoration-wrap">
    <div class="pentagon pentagon-sm" />
    <div class="pentagon pentagon-md" />
    <div class="circle circle-sm" />
    <div class="circle circle-md" />
    <div class="circle circle-lg" />
    <div class="square square-sm" />
    <div class="square square-md" />
    <div class="square square-lg" />
    <div class="triangle triangle-md" />
    <div class="triangle triangle-lg" />
  </div>
</template>

<script>
export default {
  name: 'TopMainVisualDecoration',
}
</script>

<style lang="scss" scoped>
.main-visual-decoration-wrap {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 500px;
}
.pentagon {
  position: absolute;
  opacity: 0.08;
  clip-path: polygon(50% 0%, 100% 38%, 82% 100%, 18% 100%, 0% 38%);
  background: white;

  &::before {
    content: '';
    position: absolute;
    clip-path: polygon(50% 0%, 100% 38%, 82% 100%, 18% 100%, 0% 38%);
    background: var(--v-primary-base);
  }
}
.pentagon-sm {
  top: 11%;
  left: 7%;
  width: 62px;
  height: 59px;

  &::before {
    top: 4px;
    left: 4px;
    width: 54px;
    height: 51px;
  }
}
.pentagon-md {
  top: 33%;
  right: 30%;
  width: 111px;
  height: 105px;

  &::before {
    top: 5px;
    left: 5px;
    width: 101px;
    height: 95px;
  }
}
.circle {
  position: absolute;
  opacity: 0.06;
  border-radius: 50%;
}
.circle-sm {
  top: 43%;
  left: 30%;
  width: 57px;
  height: 57px;
  opacity: 0.08;
  border: 5px solid white;
}
.circle-md {
  top: 7%;
  left: 34%;
  width: 80px;
  height: 80px;
  border: 4px solid white;
}
.circle-lg {
  top: 37%;
  left: 3%;
  width: 280px;
  height: 280px;
  border: 8px solid white;
}
.square {
  position: absolute;
  opacity: 0.1;
}
.square-sm {
  top: 16%;
  left: 21%;
  width: 60px;
  height: 60px;
  border: 4px solid white;
}
.square-md {
  top: -5%;
  right: 4%;
  width: 105px;
  height: 105px;
  border: 4px solid white;
}
.square-lg {
  top: 22%;
  right: 19%;
  width: 67px;
  height: 67px;
  opacity: 0.08;
  border: 5px solid white;
}
.triangle {
  position: absolute;
  opacity: 0.1;
  transform: rotate(45deg);
  width: 0;
  height: 0;

  &::before {
    content: '';
    position: absolute;
    width: 0;
    height: 0;
  }
}
.triangle-md {
  top: 5%;
  right: 35%;
  border-left: 34px solid transparent;
  border-right: 34px solid transparent;
  border-bottom: 58px solid white;

  &::before {
    top: 12px;
    left: -24px;
    border-left: 24px solid transparent;
    border-right: 24px solid transparent;
    border-bottom: 40px solid var(--v-primary-base);
  }
}
.triangle-lg {
  top: 48%;
  right: 4%;
  border-left: 59px solid transparent;
  border-right: 59px solid transparent;
  border-bottom: 102px solid white;

  &::before {
    top: 12px;
    left: -49px;
    border-left: 49px solid transparent;
    border-right: 49px solid transparent;
    border-bottom: 84px solid var(--v-primary-base);
  }
}
</style>
