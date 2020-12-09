import 'package:flutter/material.dart';
import 'package:twisun/constants.dart';
import 'package:twisun/models/coupon_model.dart';

class SolarPointsTab extends StatefulWidget {
  @override
  _SolarPointsTabState createState() => _SolarPointsTabState();
}

class _SolarPointsTabState extends State<SolarPointsTab> {
  List<Coupon> coupons;
  @override
  void initState() {
    super.initState();
    coupons = getExample();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          return Center(
            child: _CardItem(coupon: coupons[index]),
          );
        },
      ),
    );
  }

  List<Coupon> getExample() {
    List<Coupon> coupons = [
      Coupon(1, '2x1 in 3D movies.', 50, 1, 'Cinecolombia',
          'https://images.freeimages.com/images/large-previews/50e/ticket-1543115.jpg'),
      Coupon(2, '20% discount in your Twizy maintenance.', 100, 1, 'Renault',
          'https://cdn1.iconfinder.com/data/icons/car-insurance-1/50/13-512.png'),
      Coupon(
          3,
          '25% discount in the total of your purchase.',
          70,
          1,
          'Healthy Market',
          'https://cdn3.iconfinder.com/data/icons/healthy-food-15/64/Bag_Vegetables-grocery-groceries-delivery-market-vegan-healthy-512.png'),
      Coupon(
          4,
          '50% discount in the second shake with the purchase of a big shake.',
          35,
          1,
          'Cosechas',
          'https://icons-for-free.com/iconfiles/png/512/shake-131983752904819846.png'),
      Coupon(5, '3x2 in selected items', 80, 1, 'Velmost',
          'https://image.flaticon.com/icons/png/512/1686/1686032.png'),
      Coupon(6, '1 free month of spotify premium.', 50, 1, 'Spotify',
          'https://images.freeimages.com/images/large-previews/50e/ticket-1543115.jpg'),
      Coupon(7, '2x1 in 3D movies.', 50, 1, 'Cinecolombia',
          'https://images.freeimages.com/images/large-previews/50e/ticket-1543115.jpg'),
      Coupon(8, '2x1 in 3D movies.', 50, 1, 'Cinecolombia',
          'https://images.freeimages.com/images/large-previews/50e/ticket-1543115.jpg'),
      Coupon(9, '2x1 in 3D movies.', 50, 1, 'Cinecolombia',
          'https://images.freeimages.com/images/large-previews/50e/ticket-1543115.jpg'),
      Coupon(10, '2x1 in 3D movies.', 50, 1, 'Cinecolombia',
          'https://images.freeimages.com/images/large-previews/50e/ticket-1543115.jpg'),
      Coupon(11, '2x1 in 3D movies.', 50, 1, 'Cinecolombia',
          'https://images.freeimages.com/images/large-previews/50e/ticket-1543115.jpg'),
      Coupon(12, '2x1 in 3D movies.', 50, 1, 'Cinecolombia',
          'https://images.freeimages.com/images/large-previews/50e/ticket-1543115.jpg'),
    ];

    return coupons;
  }

  void showQR(Coupon coupon) {
    print(coupon.toString());
  }
}

class _CardItem extends StatelessWidget {
  final Coupon coupon;

  const _CardItem({Key key, this.coupon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          //gradient: kPrimaryGradientColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    coupon.partner,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          coupon.cost.toString(),
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                        Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.amber,
                          size: 19,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  FittedBox(
                      fit: BoxFit.contain,
                      child: Image.network(
                        coupon.imgUrl,
                        width: 58.0,
                        height: 58.0,
                      )),
                  SizedBox(width: 15),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      coupon.description,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
