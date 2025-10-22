import 'package:findcribs/components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/constants.dart';
import '../../components/payment_plan.dart';
import '../../controller/login_controller.dart';
import '../../models/payment_plan_model.dart';
import '../../service/PaymentPlanService.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  bool gettingPlan = true;
  List<PaymentPlanModel> plans = [];

  handleGetPlans() async {
    gettingPlan = true;
    setState(() {});
    await getProfileController.handleGetProfile();
    plans = await PaymentplanService().getPlans();
    print(getProfileController.subscriptionExpiry.value);
    gettingPlan = false;
    setState(() {});
  }

  @override
  void initState() {
    handleGetPlans();
    super.initState();
  }

  String formatExpiryDate(String rawDate) {
    try {
      DateTime parsed = DateTime.parse(rawDate).toLocal();
      return DateFormat("d MMM yyyy, h:mm a").format(parsed);
      // Example: 7 Oct 2025, 5:09 PM
    } catch (e) {
      return rawDate; // fallback if parsing fails
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await handleGetPlans();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // 👈 makes refresh work always
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- Header ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backButton(),
                      const Text(
                        "Subscription",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// --- Subscription Info Card ---
                  gettingPlan
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "My Current Plan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.workspace_premium,
                                      color: kPrimary, size: 28),
                                  const SizedBox(width: 10),
                                  Text(
                                    getProfileController
                                            .subscriptionName.value.isNotEmpty
                                        ? getProfileController
                                            .subscriptionName.value
                                        : "Free Plan",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Expires on:",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                      Text(
                                        getProfileController.subscriptionExpiry
                                                .value.isNotEmpty
                                            ? formatExpiryDate(
                                                getProfileController
                                                    .subscriptionExpiry.value)
                                            : "No expiry",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                  const SizedBox(height: 32),

                  /// --- Upgrade Section ---
                  const Text(
                    "Upgrade Your Plan",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Choose a subscription that fits your needs and enjoy more benefits.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  /// --- Plans Section (Unchanged) ---
                  gettingPlan
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height:
                              380, // 👈 constrain height so it doesn't break scroll
                          child: gettingPlan
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: kPrimary),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var x = 0; x < plans.length; x++)
                                        paymentPlan(
                                          id: plans[x].id!,
                                          selected: getProfileController
                                                  .subscriptionId.value ==
                                              plans[x].id.toString(),
                                          name: plans[x].name!,
                                          price: plans[x].price.toString(),
                                          benefits: plans[x].benefit!,
                                          subscriptionId: getProfileController
                                              .subscriptionId.value,
                                          returnUrl: const Subscription(),
                                        ),
                                    ],
                                  ),
                                ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
