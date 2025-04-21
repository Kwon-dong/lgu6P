# iris.csv 데이터 생성
- 라이브러리 설치
```bash
pip install pandas seaborn
```

- iris 데이터 내보내기
```bash
$ python
Python 3.11.6 (main, Apr 11 2025, 14:29:56) [GCC 13.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import seaborn as sns
sns>>> 
>>> iris = sns.load_dataset("iris")
>>> iris.head(1)
   sepal_length  sepal_width  petal_length  petal_width species
0           5.1          3.5           1.4          0.2  setosa
>>> iris.to_csv("iris.csv", index=False)
>>> exit()
```

# 볼륨 생성
- 임의의 볼륨 생성
```bash
docker volume create data-volume
```

# Dockerfile 확인
- 파일 확인

# 이미지 만들기
```bash
docker image build --tag my-pandas-image .
```

# 컨테이너 실행
## Step 1 컨테이너: 원천 데이터 → iris.csv
```bash
docker run -it -p 8881:8888 \
  --name step1 \
  --mount type=bind,source="$(pwd)",destination=/app \
  --mount type=volume,source=data-volume,destination=/data \
  my-pandas-image
```

- 실행한 컨테이너에서 직접 확인하기
```bash
docker exec -it step3 bash
ls -l /data
```


## Step 2 컨테이너: iris.csv → iris2.csv
```bash
docker run -it -p 8882:8888 \
  --name step2 \
  --mount type=bind,source="$(pwd)",destination=/app \
  --mount type=volume,source=data-volume,destination=/data \
  my-pandas-image
```