#! python3
# coding:utf-8

import smtplib
from email.header import Header
from email.mime.text import MIMEText

# 需要安装fire  `pip3 install fire`即可
import fire


'''
python3 sendMessage.py --help

NAME
    sendMessage.py

SYNOPSIS
    sendMessage.py <flags>

FLAGS
    -t, --targetMaillist=TARGETMAILLIST
        Default: ['864562082@qq.com']
        收件人邮箱列表
    -s, --subject=SUBJECT
        Default: '来自CoderWGB的问候'
        邮箱主题
    -m, --mailBody=MAILBODY
        Default: '你最近过得好吗'
        邮件文本内容

 封装成shell命令进行调用   python3 sendMessage.py -t  "['xxxxxx@qq.com','xxxxxx@qq.com']" -s "一封问候邮件" -m "假装这是一封情书💌"
'''


#发送邮件文本消息 
# 参数1: 收件人列表
# 参数2: 文本内容
def sendMail(targetMaillist = ['xxx@qq.com'], subject = '来自CoderWGB的问候', mailBody = "你最近过得好吗"):
    '''
    :param targetMaillist: 收件人邮箱列表
    :param subject: 邮箱主题
    :param mailBody: 邮件文本内容
    :return:
    '''
    
    # 申明邮件对象
    msg = MIMEText(mailBody, 'html', 'utf-8')
    # 邮件主题
    msg['subject'] = Header(subject, 'utf-8')
    msg['From'] = 'CoderWGB<CoderWGB@163.com>'

    # SMTP服务对象
    smtpMail = smtplib.SMTP()

    # 连接SMTP服务器
    smtpMail.connect('smtp.163.com')

    # 登录SMTP服务器
    smtpMail.login('CoderWGB@163.com', 'CLYxxxxxFKR')

    # 使用SMTP服务器发送邮件
    for tgmail in targetMaillist:
        msg['To'] = tgmail
        smtpMail.sendmail('CoderWGB@163.com', tgmail, msg.as_string())
        print('** (%s)发送成功！ **' % tgmail)
    smtpMail.quit()


if __name__ == '__main__':
    fire.Fire(sendMail)



