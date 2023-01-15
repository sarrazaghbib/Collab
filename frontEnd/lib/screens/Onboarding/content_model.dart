class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Collaborate Effectively',
      image: 'assets/images/wt1.png',
      discription:
          "manage, collaborate and participate in different projects easily"),
  UnbordingContent(
      title: 'Communicate effortlessly',
      image: 'assets/images/wt2.png',
      discription:
          "spare is easy to use and all your transactions are secured"),
  UnbordingContent(
      title: 'Multitask Productively',
      image: 'assets/images/wt3.png',
      discription: " tasks and events"),
];
