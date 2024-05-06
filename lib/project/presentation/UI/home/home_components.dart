import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app/cubit/cubit.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';

class Home_widget extends StatelessWidget {
  Home_widget({required this.hospital_name ,required this.id, required this.location ,required this.rate ,required this.beds ,});
  int? beds= 0;
  dynamic rate= 0.0;
  String? hospital_name= '';
  String? location= '';
  String? id;

  @override
  Widget build(BuildContext context) {
    return    Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.primary)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${hospital_name}',
                style: Styles.semi_bold_16.copyWith(color: AppColors.primary),
              ),
              InkWell(
                  onTap: (){
                    if(!AppCubit.get(context).user_model!.favorites!.contains(id)){
                      AppCubit.get(context).make_favorite(id);
                    }else
                  {
                      AppCubit.get(context).remove_favorite(id);
                    }


                  },
                  child: Icon(AppCubit.get(context).user_model!.favorites!.contains(id) ?Icons.favorite : Icons.favorite_border,color: AppCubit.get(context).user_model!.favorites!.contains(id) ?Color(0xffE81515): Colors.black,))
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.location_on_rounded,color: Colors.black,size: 20),
              SizedBox(
                width: MediaQuery.sizeOf(context).width -100,
                child: Text(
                  location!,
                  style: Styles.semi_bold_16.copyWith(color: Colors.black,fontSize: 11,overflow: TextOverflow.ellipsis),maxLines: 1,
                ),
              ),

            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Available : ',
                    style: Styles.semi_bold_16.copyWith(color: Colors.black,fontSize: 11,overflow: TextOverflow.ellipsis),maxLines: 1,
                  ),
                  Text(
                    '${beds} Beds',
                    style: Styles.semi_bold_16.copyWith(color:beds =='0' ? Colors.red: Colors.green,fontSize: 11,overflow: TextOverflow.ellipsis),maxLines: 1,
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                height: 20,
                child: RatingBar.builder(
                  initialRating: rate.toDouble(),
                  itemSize: 16,
                  minRating: 1,
                  unratedColor: Colors.grey.shade400
                  ,

                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
