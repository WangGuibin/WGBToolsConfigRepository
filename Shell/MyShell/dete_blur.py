# coding=utf-8
# 导入相应的python包
# 调用 python3 dete_blur.py -i "/Users/wangguibin/Desktop/images/" -r "/Users/wangguibin/Desktop/resultImages" 即可 桌面上生成图片结果

from imutils import paths
import argparse
import cv2
import os

def variance_of_laplacian(image):
    '''
    计算图像的laplacian响应的方差值
    '''
    return cv2.Laplacian(image, cv2.CV_64F).var()

if __name__ == '__main__':
    # 设置参数
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--images", required=True, help="设置输入图片的路径")
    ap.add_argument("-r", "--result_dir",required=True, help="设置输出打分图片的路径")
    ap.add_argument("-t", "--threshold", type=float, default=100.0, help="设置模糊阈值")
    args = vars(ap.parse_args())

    # 遍历每一张图片
    count = 0
    resultDir = args["result_dir"]
    if not os.path.exists(resultDir):
        os.makedirs(resultDir)
    for imagePath in paths.list_images(args["images"]):
        count += 1
        # 读取图片
        image = cv2.imread(imagePath)
        # 将图片转换为灰度图片
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        # 计算灰度图片的方差
        fm = variance_of_laplacian(gray)
        text = "Not Blurry"

        # 设置输出的文字
        if fm < args["threshold"]:
            text = "Blurry"

        # 显示结果
        cv2.putText(image, "{}: {:.2f}".format(text, fm), (30, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 3)
        #桌面上创建一个结果目录
        imageName = resultDir + "/%d.jpg" % count
        cv2.imwrite(imageName, image)
os.system('open ' + resultDir)
        