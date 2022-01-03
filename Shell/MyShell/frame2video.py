import cv2
import os
import numpy as np
from PIL import Image
import re
import argparse


re_digits = re.compile(r'(\d+)')

def emb_numbers(s):
    pieces=re_digits.split(s)
    pieces[1::2]=map(int,pieces[1::2])
    return pieces

def sort_strings_with_emb_numbers2(alist):
    return sorted(alist, key=emb_numbers)

def frame2video(im_dir, video_dir, fps):
    im_list = os.listdir(im_dir)
    im_list = sort_strings_with_emb_numbers2(im_list)
    #im_list.sort(key=lambda x: int(x.replace("frame", "").split('.')[0]))  # 最好再看看图片顺序对不
    img = Image.open(os.path.join(im_dir, im_list[0]))
    img_size = img.size  # 获得图片分辨率，im_dir文件夹下的图片分辨率需要一致

    #fourcc = cv2.cv.CV_FOURCC('M','J','P','G') #opencv版本是2
    fourcc = cv2.VideoWriter_fourcc(*'XVID')  # opencv版本是3
    videoWriter = cv2.VideoWriter(video_dir, fourcc, fps, img_size)
    # count = 1
    for i in im_list:
        im_name = os.path.join(im_dir + i)
        frame = cv2.imdecode(np.fromfile(im_name, dtype=np.uint8), -1)
        videoWriter.write(frame)
        # count+=1
        # if (count == 200):
        #     print(im_name)
        #     break
    videoWriter.release()
    print('finish')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i','--im_dir', required=True,help="设置视频帧图片目录")
    parser.add_argument('-v','--video_dir', required=True,help="设置输出视频的路径")
    parser.add_argument('-f','--fps', type=int,default=30,help="设置输出视频的路径")

    args = parser.parse_args()
    im_dir = args.im_dir
    video_dir = args.video_dir    
    fps = args.fps  # 帧率，每秒钟帧数越多，所显示的动作就会越流畅
    frame2video(im_dir, video_dir, fps)
    # 调用示例 python3 frame2video.py -f 25 -i '/Users/wangguibin/Desktop/images/' -v '/Users/wangguibin/Desktop/test.mp4' 