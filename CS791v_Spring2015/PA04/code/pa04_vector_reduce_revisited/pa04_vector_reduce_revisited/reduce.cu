/**
 *
 */

#ifndef _REDUCE_CU_
#define _REDUCE_CU_ 1

#include "reduce.hpp"

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <device_functions.h>
#include <cuda_runtime_api.h>



__global__
void
PartialReduceKernel(
    int* resultVector, const int* inputVector, const unsigned vectorSize) {

  extern __shared__ int sharedData[];

  const unsigned& blockTid = threadIdx.x;
  unsigned globalTid = (blockIdx.x * blockDim.x) + blockTid;
  unsigned int totalThreads = gridDim.x * blockDim.x;

  /* fetch the data from global into shared memory */
  sharedData[blockTid] = 0;
  for (unsigned i = globalTid; i < vectorSize; i += totalThreads) {
    sharedData[blockTid] += inputVector[i];
  }

  unsigned power2PaddedNumThreadsInBlock = 1;
  while (power2PaddedNumThreadsInBlock < blockDim.x) {
    power2PaddedNumThreadsInBlock *= 2;
  }
  __syncthreads();

  /* perform the reduction */
  unsigned stride = power2PaddedNumThreadsInBlock / 2;

  // unroll the first iteration so the special check to see if threads are
  // accessing valid memory with their stride can be done only once
  if (blockTid  + stride < blockDim.x && stride > 0) {
    sharedData[blockTid] += sharedData[blockTid + stride];
  }
  __syncthreads();

  // the main algorithm
  for (unsigned stride = power2PaddedNumThreadsInBlock / 4;
       stride > 0;
       stride /= 2) {

    if (blockTid < stride) {
      sharedData[blockTid] += sharedData[blockTid + stride];
    }
    __syncthreads();
  }

  // TODO: Optimize things for the last warp. Unfortunately, if we want it to
  //       be portable, it will involve a lot of if-logic that may not be
  //       worth implementing for programming and performance reasons. 

  /* store the final result */
  if (blockTid == 0) {
    resultVector[blockIdx.x] = sharedData[0];
  }
}

__global__
void
KernelInKernelReduceKernel(
    int* sum,
    int* intermediateVector,
    const int* inputVector,
    const unsigned vectorSize) {

    extern __shared__ int sharedData[];

  const unsigned& blockTid = threadIdx.x;
  unsigned globalTid = (blockIdx.x * blockDim.x) + blockTid;
  unsigned int totalThreads = gridDim.x * blockDim.x;

  /* fetch the data from global into shared memory */
  sharedData[blockTid] = 0;
  for (unsigned i = globalTid; i < vectorSize; i += totalThreads) {
    sharedData[blockTid] += inputVector[i];
  }

  unsigned power2PaddedNumThreadsInBlock = 1;
  while (power2PaddedNumThreadsInBlock < blockDim.x) {
    power2PaddedNumThreadsInBlock *= 2;
  }
  __syncthreads();

  /* perform the reduction */
  unsigned stride = power2PaddedNumThreadsInBlock / 2;

  // unroll the first iteration so the special check to see if threads are
  // accessing valid memory with their stride can be done only once
  if (blockTid  + stride < blockDim.x && stride > 0) {
    sharedData[blockTid] += sharedData[blockTid + stride];
  }
  __syncthreads();

  // the main algorithm
  for (unsigned stride = power2PaddedNumThreadsInBlock / 4;
       stride > 0;
       stride /= 2) {

    if (blockTid < stride) {
      sharedData[blockTid] += sharedData[blockTid + stride];
    }
    __syncthreads();
  }

  // TODO: Optimize things for the last warp. Unfortunately, if we want it to
  //       be portable, it will involve a lot of if-logic that may not be
  //       worth implementing for programming and performance reasons. 

  /* store the final result */
  if (blockTid == 0) {
    intermediateVector[blockIdx.x] = sharedData[0];
  }



  if (globalTid == 0) {
    PartialReduceKernel // TODO: more threads than elements for this call?
      <<<1, gridDim.x, gridDim.x * sizeof(int)>>>(
      sum,
      intermediateVector,
      gridDim.x
    );
  }
}

__global__
void
ThreadFenceReduceKernel(
    int* resultVector, 
    const int* inputVector,
    const unsigned vectorSize) {

 // TODO: implement
}

#endif //_REDUCE_CU_