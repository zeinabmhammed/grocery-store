import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/core/di/injection.dart';
import 'package:greengrocer/core/routes_manager/routes.dart';
import 'package:greengrocer/core/services/fcm_services.dart';
import 'package:greengrocer/features/auth/domain/usecases/auth_usecases.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/cubit/cart_cubit.dart';
import 'package:greengrocer/features/main_layout/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/product_entity.dart';
import 'package:greengrocer/features/main_layout/home/presentation/screen/category_products_screen.dart';
import 'package:greengrocer/firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'features/auth/presentation/screens/forget_password.dart';
import 'features/auth/presentation/screens/otp_screen.dart';
import 'features/auth/presentation/screens/sign_in_screen.dart';
import 'features/auth/presentation/screens/sign_up_screen.dart';
import 'features/auth/presentation/screens/welcome_screen.dart';
import 'features/main_layout/basket/presentation/screen/basket_screen.dart';
import 'features/main_layout/basket/presentation/screen/checkout_failed.dart';
import 'features/main_layout/basket/presentation/screen/checkout_screen.dart';
import 'features/main_layout/basket/presentation/screen/checkout_success.dart';
import 'features/main_layout/favorite/presentation/favorite_screen.dart';
import 'features/main_layout/home/presentation/screen/product_details.dart';
import 'features/main_layout/home/presentation/screen/sellers_details.dart';
import 'features/main_layout/main_layout.dart';
import 'features/main_layout/more/presentation/widget/profile_screen.dart';
import 'features/main_layout/more/presentation/widget/support_screen.dart';
import 'features/main_layout/more/presentation/widget/terms_screen.dart';
import 'features/main_layout/orders/presentation/screen/order_tracking_screen.dart';
import 'features/main_layout/orders/presentation/screen/orders_screen.dart';
import 'features/onboarding_screen/presentation/screen/on_boarding_screen.dart';
import 'features/splash_screen/presentation/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("0f105f5b-2731-404f-8e45-6193551d509b");

  OneSignal.Notifications.requestPermission(true);

  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    print('Notification received in foreground');
    event.notification.display();
  });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(
            addToFavoriteUseCase: sl<AddToFavoriteUseCase>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen(FCMServices.showFlutterNotification);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruits App',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.splashRoute: (context) => const SplashScreen(),
        AppRoutes.onBoardingRoute: (context) => const OnBoardingScreen(),
        AppRoutes.welcomeRoute: (context) => const WelcomeScreen(),
        AppRoutes.signInRoute: (context) => const SignInScreen(),
        AppRoutes.signUpRoute: (context) => const SignUpScreen(),
        AppRoutes.forgetPasswordRoute: (context) => const ForgetPassword(),
        AppRoutes.otpRoute: (context) => const OtpScreen(),
        AppRoutes.sellersDetailsRoute: (context) => const SellersDetails(),
        AppRoutes.mainLayoutRoute: (context) => const MainLayout(),
        AppRoutes.profileRoute: (context) => const UpdateProfileScreen(),
        AppRoutes.supportRoute: (context) => const SupportScreen(),
        AppRoutes.termsRoute: (context) => const TermsScreen(),
        AppRoutes.ordersRoute: (context) => const OrdersScreen(),
        AppRoutes.favoriteRoute: (context) => const FavoriteScreen(),
        AppRoutes.basketRoute: (context) => const BasketScreen(),
        AppRoutes.checkoutRoute: (context) => const CheckoutScreen(),
        AppRoutes.productDetailsRoute: (context) => const ProductDetails(),
        AppRoutes.checkoutSuccessRoute: (context) => const CheckoutSuccess(),
        AppRoutes.checkoutFailedRoute: (context) => const CheckoutFailed(),
        AppRoutes.orderTrackingRoute: (context) => const OrderTrackingScreen(),
        AppRoutes.categoryProductsRoute: (context) {
          final args =
          ModalRoute.of(context)!.settings.arguments
          as Map<String, dynamic>;
          return CategoryProductsScreen(
            categoryId: args['categoryId'] as int,
            categoryName: args['categoryName'] as String,
            products: args['products'] as List<ProductEntity>,
          );
        },
      },
      initialRoute:  AppRoutes.onBoardingRoute,
    );
  }
}