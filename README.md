# amirta_mobile

Amirta Mobile App

## Getting Started

An app for [SIRUKIM](https://sirukim.jakarta.go.id/login/) officer to manage their daily works.

This app consist of 4 main features:

1. Home
2. Water Monthly Bill Record
3. Complaint Monitoring
4. Panic Monitoring

### Home

You can see all summary stats ongoing on the system here

1. Total monthly bill need to register
2. Total newest complaint
3. Total newest panic

### Water Monthly Bill Record

Every month officers have to check and record resident water usage or report if the water meter is
broken. Before they were about to start their work, they can download the data beforehand because
there were someplace cell signal couldn't reach. I am using **ObjectBox** to store the data because
of its easiness of use.

### Complaint Monitoring

All resident have their own app to manager their needs. One of the main feature is sending
complaint. Those complaints can be managed within this feature. Complaint have 4 status:

1. Received
2. On Progress
3. Rejected
4. Completed

Yes, complaints could be rejected, with a reason of course.

### Panic Monitoring

Panic is an urgent matter that should be cleared within hours. Same with Complaint, but with
**location** variable, so officers can know where it occurs and go to scene immediately.

## Other Feature

- Profile
- Change Password
- Reset Password
- Multi Language: English and Indonesia
- Light and Dark Theme

---

## Technical

- BLoC
- ObjectBox
- Provider
- Repository
- Push notification

## Demo

[Download APK](https://drive.google.com/file/d/1rVqTXr627jcms7M-K92O23kGJi_xJzE_/view?usp=share_link)