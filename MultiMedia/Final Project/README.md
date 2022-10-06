# **Image Watermarking in DCT Domain**
![Awesome](https://img.shields.io/badge/.-Awesome-%23FC60A8?style=for-the-badge&logo=awesomelists)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=for-the-badge)
![License](https://img.shields.io/packagist/l/doctrine/orm?style=for-the-badge)

A MATLAB project that implements an adaptive blind image watermarking algorithm with respect to edge pixel concentration and 
compares its NC results against JPEG attack with non-adaptive methods' ones.

---
## Method

<div align="center">
  <figure>
    <img src="https://user-images.githubusercontent.com/60509979/194382529-6c6b3d40-579c-49e0-82b4-591ce0d7fabc.png" alt="Fig1" style="width: 40%;">
    <br />
    <figcaption><b>Fig.1 - Pseudo code of the proposed embedding procedure.</b></figcaption>
  </figure>
</div>
<br />
<br />
<div align="center">
  <img src="https://user-images.githubusercontent.com/60509979/194379352-9d6450d5-1b50-488e-b949-e1dcb43a6221.png" alt="Fig0" style="width: 45%;">
</div>

<div align="center">
  <figure>
    <img src="https://user-images.githubusercontent.com/60509979/194365248-0432b199-cd01-4d0f-b60e-f7494f4d7dbc.png" alt="Fig2">
    <br />
    <figcaption><b>Fig.2 - Pseudo code of the proposed embedding algorithm.</b></figcaption>
  </figure>
</div>



---
## Results

<div align="center">
  <figure>
    <img src="https://user-images.githubusercontent.com/60509979/194365723-97acbb60-4326-4a7d-add5-119b5ca9d8c8.png" alt="Fig1" style="width: 60%;">
    <br />
    <figcaption><b>Fig.1 - NC results of the proposed method against JPEG attack</b></figcaption>
  </figure>
</div>

<br />
<br />

<div align="center">
  <figure>
    <img src="https://user-images.githubusercontent.com/60509979/194367964-e014e9e5-6f8d-4444-8966-a2214a01ee92.png" alt="Fig2" style="width: 80%;">
    <br />
    <figcaption>
      <b>
        Fig.2 - visual quality comparison of Lena's watermarked image with adaptive alpha and non-adaptive one 
        <br />
        (Left image is watermarked with adaptive alpha and the right one with non-adaptive alpha)
      </b>
    </figcaption>
  </figure>
</div>

## Find Maximum of Alpha in Non-Adaptive Watermarking Methods
For measuring the performance of an image watermarking method, there are two metrics whose trade–off is important: robustness, and transparency.
Using these two individual metrics, I defined $$\rho = MSSIM \times NC$$ s a criterion to measure the robustness and transparency at the same time.

<div align="center">
  <figure>
    <img src="https://user-images.githubusercontent.com/60509979/194375684-24af21c1-43e6-480f-be25-160c806aec45.png" alt="Fig3" style="width: 100%;">
    <br />
    <figcaption>
      <b>
        Fig.3 - Average of &rho; using JPEG attack (60%, 80% and 100%) with different &alpha;.
        <br />
        according to this figure, maximum &alpha; = 40
      </b>
    </figcaption>
  </figure>
</div>

