import cv2
import os
import argparse

def video2frame(videos_path, frames_save_path, time_interval):
    '''
    :param videos_path: 视频的存放路径
    :param frames_save_path: 视频切分成帧之后图片的保存路径
    :param time_interval: 保存间隔
    :return:
    '''
    vidcap = cv2.VideoCapture(videos_path)
    success, image = vidcap.read()
    count = 0
    while success:
        success, image = vidcap.read()
        count += 1
        if count % time_interval == 0:
            cv2.imencode('.jpg', image)[1].tofile(frames_save_path + "/frame%d.jpg" % (count/time_interval))
    print("拆帧完毕,一共生成 " + str(int((count-1)/time_interval)) + " 张图片")
    os.system('open ' + str(frames_save_path))

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-v','--video_path', required=True,help="设置输入视频的路径")
    parser.add_argument('-i','--images_path', required=True,help="设置输入图片的路径")
    args = parser.parse_args()
    videos_path = args.video_path
    frames_save_path = args.images_path
    if not os.path.exists(frames_save_path):
        os.makedirs(frames_save_path)
    # videos_path = '/Users/wangguibin/Desktop/mmas.flv'
    # frames_save_path = '/Users/wangguibin/Desktop/images'
    time_interval = 1  #多少帧保存一次 设置1为每帧都保存 设置2则 隔一帧保存一次
    video2frame(videos_path, frames_save_path, time_interval)

# 调用示例 python3 video2frame.py -v '/Users/wangguibin/Desktop/mmas.flv' -i '/Users/wangguibin/Desktop/images'