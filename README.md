# GroceryMate - Infrastructure as Code (Terraform)
## Masterschool Cloud Engineering - Woche 6

### Beschreibung
Dieser Ordner enthaelt die vollstaendige AWS-Infrastruktur der GroceryMate-Anwendung als Terraform-Code (IaC).

### Infrastruktur-Komponenten
| Ressource | Typ | Beschreibung |
|-----------|-----|--------------|
| EC2 Instanz | t2.micro | App-Server mit Docker |
| RDS PostgreSQL | db.t3.micro | Verwaltete Datenbank |
| Security Group | - | Firewall-Regeln (Port 22, 5000, 5432) |
| DB Subnet Group | - | RDS Netzwerk-Konfiguration |
| S3 Bucket | - | Log-Speicher |

### Verwendung
```bash
# Initialisieren
terraform init

# Plan anzeigen (keine Aenderungen)
terraform plan

# Infrastruktur erstellen
terraform apply

# Infrastruktur loeschen (Kostenersparnis!)
terraform destroy
```

### Vorteil von IaC
- Infrastruktur versioniert und reproduzierbar
- Einfaches Erstellen und Loeschen (kein manuelle Klicken!)
- Dokumentiert was deployed ist
