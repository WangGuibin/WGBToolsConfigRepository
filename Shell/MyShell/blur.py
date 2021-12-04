import numpy as np
import cv2
from PIL import Image
import argparse

def motion_blur(image, degree=10, angle=20):
    image = np.array(image)

    # 这里生成任意角度的运动模糊kernel的矩阵， degree越大，模糊程度越高
    M = cv2.getRotationMatrix2D((degree/2, degree/2), angle, 1)
    motion_blur_kernel = np.diag(np.ones(degree))
    motion_blur_kernel = cv2.warpAffine(motion_blur_kernel, M, (degree, degree))

    motion_blur_kernel = motion_blur_kernel / degree
    blurred = cv2.filter2D(image, -1, motion_blur_kernel)
    # convert to uint8
    cv2.normalize(blurred, blurred, 0, 255, cv2.NORM_MINMAX)
    blurred = np.array(blurred, dtype=np.uint8)
    return blurred


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i','--images_path', required=True,help="设置输入图片的路径")
    parser.add_argument('-d','--dst_images_path', required=True,help="设置输入图片的路径")

    args = parser.parse_args()
    images_path = args.images_path
    dst_images_path = args.dst_images_path

    img = Image.open(images_path)
    blurImg = motion_blur(img,50,30)
    cv2.imwrite(dst_images_path, blurImg)