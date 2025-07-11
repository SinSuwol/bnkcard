console.clear();

gsap.registerPlugin(Draggable,InertiaPlugin, MotionPathPlugin);
const boxes = gsap.utils.toArray(".box");
const boxesAmount = boxes.length;
const step = 360 / boxesAmount;
let activeIndex = 0;
let nextIndex;

gsap.set(boxes, {
  motionPath: {
    path: "#myPath",
    align: "#myPath",
    alignOrigin: [0.5, 0.5],
    start: -0.25,
    end: (i) => i / boxesAmount - 0.25,
    autoRotate: true
  }
});

Draggable.create(".container", {
  type: "rotation",
  inertia: true,
  throwResistance: 1000, // ← 감속 저항을 증가시켜 빠르게 멈춤
  snap: (endVal) => {
    const snap = gsap.utils.snap(step, endVal);
    const modulus = snap % 360;
    nextIndex = Math.abs((modulus > 0 ? 360 - modulus : modulus) / step);
    return snap;
  },
  onThrowComplete: () => {
    boxes[activeIndex].classList.toggle("active");
    boxes[nextIndex].classList.toggle("active");
    activeIndex = nextIndex;
  }
});
