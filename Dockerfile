# FROM: 컨테이너를 만들 때 기본으로 가져와서 사용할 이미지
# Python 3.12.4 버전을 사용한 공식 파이썬 이미지를 기반으로 컨테이너를 생성
FROM python:3.12.4

# WORKDIR: 앞으로 작업을 실행하는 디렉토리(파일)
# /root 디렉토리에서 작업을 실행하는 명령어
WORKDIR /root

# RUN: 컨태이너에서 실행할 명령어를 작성하는 곳 ex)응용 프로그램 설치
# apt-get 명령어로 패키지 리스트를 업데이트하고, 필요한 패키지들(wget, build-essential, git)을 설치
# --no-install-recommends 옵션은 불필요한 추가 패키지 설치를 방지
# 이후 불필요한 apt 데이터를 제거
RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         build-essential \
         git && \
    rm -rf /var/lib/apt/lists/*

# COPY: 파일 복사
# 우리 컴퓨터의 ./requirements.txt 파일을 컨테이너의 /root/requirements.txt 위치로 복사합니다.
COPY ./requirements.txt /root/requirements.txt
# 파이썬 패키지 관리 도구인 pip을 최신 버전으로 업그레이드
RUN pip install --upgrade pip
# 우리가 미리 적어둔(requirements.txt에 적어둔 프로그램) 파이썬 프로그램들을 설치
RUN pip install -r requirements.txt

# CMD: 컨테이너가 실행될 때 수행할 명령어 설정
# tail -f /dev/null 명령어를 실행하여, 컨테이너가 종료되지 않고 계속 실행 상태를 유지
CMD tail -f /dev/null
