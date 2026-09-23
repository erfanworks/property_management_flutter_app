// lib/screens/UserScreen/LandlordAllScreen/Finance/model/finance_reference_model.dart
enum ChargeType { utility, repair, penalty, service, custom }

extension ChargeTypeX on ChargeType {
  String get label => switch (this) {
        ChargeType.utility => 'Utility charge',
        ChargeType.repair => 'Repair charge',
        ChargeType.penalty => 'Penalty',
        ChargeType.service => 'Service charge',
        ChargeType.custom => 'Custom charge',
      };
}

enum BilledTo { leadTenant, specificTenant, allTenantsOnUnit }

extension BilledToX on BilledTo {
  String get label => switch (this) {
        BilledTo.leadTenant => 'Lead tenant',
        BilledTo.specificTenant => 'Specific tenant',
        BilledTo.allTenantsOnUnit => 'All tenants on unit',
      };
}

enum PaymentMethod { bankTransfer, cash, cheque, other }

extension PaymentMethodX on PaymentMethod {
  String get label => switch (this) {
        PaymentMethod.bankTransfer => 'Bank transfer',
        PaymentMethod.cash => 'Cash',
        PaymentMethod.cheque => 'Cheque',
        PaymentMethod.other => 'Other',
      };
}
