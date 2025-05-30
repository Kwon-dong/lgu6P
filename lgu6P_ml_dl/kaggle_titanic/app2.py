# 모델 만드는 파일이랑, 웹사이트 만드는 파일은 꼭 분리해야함!
# streamlit 시각화 관련 자료

import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import joblib

# 페이지 설정
st.set_page_config(
    page_title = "Titanic Survival Prediction",
    layout = "wide"
)

st.title("Titanic Main Page, Dashboard")

# 데이터 불러오기
@st.cache_data
def load_data():
    # local에서 데이터 수집 ==> SQL에서 가져올 수도 있다는거 생각해야함
    train = pd.read_csv('train.csv')
    # 데이터 처리하는 코드 작성 이 함수 안에 가능
    # ex) 데이터 처리 예시 : 불필요한 컬럼 제거 등등

    return train

train = load_data()
# st.dataframe(train)   # 데이터프레임 잘 나오는지 확인 코드

# 탭 생성 
tab1, tab2, tab3 = st.tabs(['EDA', 'Statistics', 'Prediction'])   # UI를 도와주는 코드

# EDA 탭
with tab1:
    st.header("Exploratory Data Analysis")
    
    # 데이터 미리보기
    st.subheader("Data Preview")
    st.dataframe(train.head())
    
    # 생존자 분포
    st.subheader("Survival Distribution")
    fig, ax = plt.subplots(figsize=(8, 6))
    sns.countplot(data=train, x='Survived')
    plt.title("Survival Count")
    st.pyplot(fig)
    
    # 성별별 생존율
    st.subheader("Survival Rate by Gender")
    fig, ax = plt.subplots(figsize=(8, 6))
    sns.barplot(data=train, x='Sex', y='Survived')
    plt.title("Survival Rate by Gender")
    st.pyplot(fig)
    
    # 객실 등급별 생존율
    st.subheader("Survival Rate by Passenger Class")
    fig, ax = plt.subplots(figsize=(8, 6))
    sns.barplot(data=train, x='Pclass', y='Survived')
    plt.title("Survival Rate by Passenger Class")
    st.pyplot(fig)

# Statistics 탭
with tab2:
    st.header("Statistical Analysis")
    
    # 기본 통계량
    st.subheader("Basic Statistics")
    st.dataframe(train.describe())
    
    # 상관관계 분석
    st.subheader("Correlation Analysis")
    numeric_cols = train.select_dtypes(include=['int64', 'float64']).columns
    corr = train[numeric_cols].corr()
    fig, ax = plt.subplots(figsize=(10, 8))
    sns.heatmap(corr, annot=True, cmap='coolwarm', ax=ax)
    st.pyplot(fig)
    
    # 결측치 분석
    st.subheader("Missing Values Analysis")
    missing_data = pd.DataFrame({
        'Missing Values': train.isnull().sum(),
        'Percentage': (train.isnull().sum() / len(train)) * 100
    })
    st.dataframe(missing_data)

with tab3:
    st.header('예측')

    @st.cache_resource   # 세션과 관련있는 데코레이터
    def load_model():
        return joblib.load('titanic_stacking_model.pkl')
    
    model = load_model()
    # st.write(model)   # 모델이 streamlit에 잘 들어갔는지 확인하기 위한 코드

    # 모델 입력 폼 생성
    st.subheader('고객 정보 입력')
    col1, col2 = st.columns(2)
    
    with col1:
        pclass = st.selectbox("Passenger Class", [1, 2, 3])
        sex = st.selectbox("Sex", ["male", "female"])
        age = st.number_input("Age", min_value=0, max_value=100, value=30)
        
    with col2:
        sibsp = st.number_input("Number of Siblings/Spouses", min_value=0, max_value=10, value=0)
        parch = st.number_input("Number of Parents/Children", min_value=0, max_value=10, value=0)
        fare = st.number_input("Fare", min_value=0.0, max_value=500.0, value=50.0)
        embarked = st.selectbox("Port of Embarkation", ["C", "Q", "S"])
    
    # 예측 버튼
    if st.button("Predict Survival"):
        # 입력 데이터 준비
        input_data = pd.DataFrame({
            'Pclass': [pclass],
            'Sex': [sex],
            'Age': [age],
            'SibSp': [sibsp],
            'Parch': [parch],
            'Fare': [fare],
            'Embarked': [embarked]
        })
        
        # 예측
        prediction = model.predict(input_data)[0]
        probability = model.predict_proba(input_data)[0][1]
        
        # 결과 표시
        st.subheader("Prediction Result")
        if prediction == 1:
            st.success(f"Survival Probability: {probability:.2%}")
            st.write("The passenger is predicted to survive.")
        else:
            st.error(f"Survival Probability: {probability:.2%}")
            st.write("The passenger is predicted to not survive.")
        