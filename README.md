# Terraform으로 CloudTrail + CloudWatch + SNS 알림 구성하기

이 프로젝트는 Terraform을 사용해 AWS CloudTrail 이벤트를 CloudWatch Logs로 전송하고, 특정 보안 이벤트 발생 시 SNS를 통해 이메일 알림을 받을 수 있도록 구성합니다.

---

## 주요 기능

- CloudTrail 이벤트 → S3 저장 및 CloudWatch Logs로 연동
- 특정 이벤트 (예: IAM 정책 삭제 등) 감지 시 CloudWatch Alarm
- 알람 발생 시 이메일로 SNS 알림 수신
- Terraform으로 모든 리소스를 자동 구성

---

## 사전 준비사항

1. **AWS 계정**
2. **IAM 사용자 생성** (Terraform 전용)

   - **프로그래밍 방식 액세스**만 체크 (콘솔 로그인 불필요)
   - 이름 설정
   - **권한 부여**: `AdministratorAccess` 붙은 새 그룹 생성해서 연결
   - 생성 후 나오는 **Access Key / Secret Key** 복사해서 저장해 놓기

3. **AWS CLI 설치**
   - 공식 사이트에서 파일 다운로드 받으면 됨
   - 설치 확인: `aws --version`

---

## 설치 및 실행 방법

```bash
# 1. 레포 클론
- Clone 후 cd 해주기
cd cloudtrail-terraform

# 2. AWS 자격 정보 설정 (처음 한 번만)
aws configure --profile default 한 후에 IAM관련 정보 넣기

# 3. 이메일 설정 (알림 받을 이메일)
terraform.tfvars 파일 생성해서 이메일 넣어주기
(email = 본인 이메일)

# 4. Terraform 초기화
terraform init

# 5. 리소스 생성
terraform apply -var-file="terraform.tfvars"

---
## 알림 활성화
3에서 입력한 이메일로 SNS 구독 확인 메일이 옴
메일 확인 후 구독 버튼 클릭해야 알림이 정상적으로 작동함

---
## 종료 방법
- terraform destroy -var-file="terraform.tfvars"
- IAM 사용자 삭제
```
