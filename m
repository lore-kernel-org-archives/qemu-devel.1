Received: from eggs.gnu.org ([2001:4830:134:3::10]:54765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGuwv-0007Yf-2T
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGuws-0008Vg-35
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:49:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGuwr-0008VA-QO
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:49:22 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Dec 2016 21:49:17 +0000
Message-Id: <20161213214917.6436-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Update language files for QEMU 2.8.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>

Update translation files (change created via 'make -C po update').

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 po/bg.po       | 40 ++++++++++++++++++++--------------------
 po/de_DE.po    | 40 ++++++++++++++++++++++------------------
 po/fr_FR.po    | 40 ++++++++++++++++++++++------------------
 po/hu.po       | 40 ++++++++++++++++++++++------------------
 po/it.po       | 40 ++++++++++++++++++++++------------------
 po/messages.po | 42 +++++++++++++++++++++++-------------------
 po/tr.po       | 40 ++++++++++++++++++++++------------------
 po/zh_CN.po    | 40 ++++++++++++++++++++++------------------
 8 files changed, 175 insertions(+), 147 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 5047861..279d1b8 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -6,8 +6,8 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: QEMU 2.6.50\n"
-"Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2016-06-26 10:16+0300\n"
+"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
+"POT-Creation-Date: 2016-12-13 21:46+0000\n"
 "PO-Revision-Date: 2016-06-09 15:54+0300\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@ludost.net>\n"
@@ -17,74 +17,74 @@ msgstr ""
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
=20
-#: ui/gtk.c:274
+#: ui/gtk.c:275
 msgid " - Press Ctrl+Alt+G to release grab"
 msgstr " =E2=80=94 =D0=BD=D0=B0=D1=82=D0=B8=D1=81=D0=BD=D0=B5=D1=82=D0=B5=
 Ctrl+Alt+G, =D0=B7=D0=B0 =D0=B4=D0=B0 =D0=BE=D1=81=D0=B2=D0=BE=D0=B1=D0=BE=
=D0=B4=D0=B8=D1=82=D0=B5 =D1=84=D0=BE=D0=BA=D1=83=D1=81=D0=B0"
=20
-#: ui/gtk.c:278
+#: ui/gtk.c:279
 msgid " [Paused]"
 msgstr " [=D0=BF=D0=B0=D1=83=D0=B7=D0=B0]"
=20
-#: ui/gtk.c:1906
+#: ui/gtk.c:1922
 msgid "_Pause"
 msgstr "_=D0=9F=D0=B0=D1=83=D0=B7=D0=B0"
=20
-#: ui/gtk.c:1912
+#: ui/gtk.c:1928
 msgid "_Reset"
 msgstr "_=D0=A0=D0=B5=D1=81=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5"
=20
-#: ui/gtk.c:1915
+#: ui/gtk.c:1931
 msgid "Power _Down"
 msgstr "_=D0=98=D0=B7=D0=BA=D0=BB=D1=8E=D1=87=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: ui/gtk.c:1921
+#: ui/gtk.c:1937
 msgid "_Quit"
 msgstr "_=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
=20
-#: ui/gtk.c:2013
+#: ui/gtk.c:2029
 msgid "_Fullscreen"
 msgstr "=D0=9D=D0=B0 _=D1=86=D1=8F=D0=BB =D0=B5=D0=BA=D1=80=D0=B0=D0=BD"
=20
-#: ui/gtk.c:2016
+#: ui/gtk.c:2032
 msgid "_Copy"
 msgstr "_=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
=20
-#: ui/gtk.c:2032
+#: ui/gtk.c:2048
 msgid "Zoom _In"
 msgstr "_=D0=A3=D0=B2=D0=B5=D0=BB=D0=B8=D1=87=D0=B0=D0=B2=D0=B0=D0=BD=D0=
=B5"
=20
-#: ui/gtk.c:2039
+#: ui/gtk.c:2055
 msgid "Zoom _Out"
 msgstr "_=D0=9D=D0=B0=D0=BC=D0=B0=D0=BB=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: ui/gtk.c:2046
+#: ui/gtk.c:2062
 msgid "Best _Fit"
 msgstr "=D0=9F=D0=BE_=D0=BC=D0=B5=D1=81=D1=82=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: ui/gtk.c:2053
+#: ui/gtk.c:2069
 msgid "Zoom To _Fit"
 msgstr "=D0=9D=D0=B0=D0=BF=D0=B0=D1=81_=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: ui/gtk.c:2059
+#: ui/gtk.c:2075
 msgid "Grab On _Hover"
 msgstr "=D0=9F=D1=80=D0=B8=D1=85=D0=B2=D0=B0=D1=89=D0=B0=D0=BD=D0=B5 =D0=
=BF=D1=80=D0=B8 =D0=BF=D0=BE=D1=81=D0=BE_=D1=87=D0=B2=D0=B0=D0=BD=D0=B5"
=20
-#: ui/gtk.c:2062
+#: ui/gtk.c:2078
 msgid "_Grab Input"
 msgstr "=D0=9F=D1=80=D0=B8=D1=85=D0=B2=D0=B0=D1=89=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 _=D1=84=D0=BE=D0=BA=D1=83=D1=81=D0=B0"
=20
-#: ui/gtk.c:2091
+#: ui/gtk.c:2107
 msgid "Show _Tabs"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=BF=D1=80=D0=BE_=D0=B7=D0=BE=D1=80=D1=86=D0=
=B8"
=20
-#: ui/gtk.c:2094
+#: ui/gtk.c:2110
 msgid "Detach Tab"
 msgstr "=D0=9A=D1=8A=D0=BC =D1=81=D0=B0=D0=BC=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D1=82=D0=B5=D0=BB=D0=B5=D0=BD =D0=BF=D0=BE=D0=B4=D0=BF=D1=80=D0=BE=D0=
=B7=D0=BE=D1=80=D0=B5=D1=86"
=20
-#: ui/gtk.c:2106
+#: ui/gtk.c:2122
 msgid "_Machine"
 msgstr "_=D0=9C=D0=B0=D1=88=D0=B8=D0=BD=D0=B0"
=20
-#: ui/gtk.c:2111
+#: ui/gtk.c:2127
 msgid "_View"
 msgstr "_=D0=98=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
diff --git a/po/de_DE.po b/po/de_DE.po
index 97ae655..7dcd0dc 100644
--- a/po/de_DE.po
+++ b/po/de_DE.po
@@ -6,7 +6,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: QEMU 1.4.50\n"
 "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
-"POT-Creation-Date: 2016-04-18 14:50+0100\n"
+"POT-Creation-Date: 2016-12-13 21:46+0000\n"
 "PO-Revision-Date: 2012-02-28 16:00+0100\n"
 "Last-Translator: Kevin Wolf <kwolf@redhat.com>\n"
 "Language-Team: Deutsch <de@li.org>\n"
@@ -16,70 +16,74 @@ msgstr ""
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=3D2; plural=3D(n!=3D1);\n"
=20
-#: ui/gtk.c:273
+#: ui/gtk.c:275
 msgid " - Press Ctrl+Alt+G to release grab"
 msgstr " - Strg+Alt+G dr=C3=BCcken, um Eingabeger=C3=A4te freizugeben"
=20
-#: ui/gtk.c:277
+#: ui/gtk.c:279
 msgid " [Paused]"
 msgstr " [Angehalten]"
=20
-#: ui/gtk.c:1833
+#: ui/gtk.c:1922
 msgid "_Pause"
 msgstr "_Angehalten"
=20
-#: ui/gtk.c:1839
+#: ui/gtk.c:1928
 msgid "_Reset"
 msgstr "_Reset"
=20
-#: ui/gtk.c:1842
+#: ui/gtk.c:1931
 msgid "Power _Down"
 msgstr "_Herunterfahren"
=20
-#: ui/gtk.c:1848
+#: ui/gtk.c:1937
 msgid "_Quit"
 msgstr "_Beenden"
=20
-#: ui/gtk.c:1940
+#: ui/gtk.c:2029
 msgid "_Fullscreen"
 msgstr "_Vollbild"
=20
-#: ui/gtk.c:1954
+#: ui/gtk.c:2032
+msgid "_Copy"
+msgstr ""
+
+#: ui/gtk.c:2048
 msgid "Zoom _In"
 msgstr "_Heranzoomen"
=20
-#: ui/gtk.c:1961
+#: ui/gtk.c:2055
 msgid "Zoom _Out"
 msgstr "_Wegzoomen"
=20
-#: ui/gtk.c:1968
+#: ui/gtk.c:2062
 msgid "Best _Fit"
 msgstr "_Einpassen"
=20
-#: ui/gtk.c:1975
+#: ui/gtk.c:2069
 msgid "Zoom To _Fit"
 msgstr "Auf _Fenstergr=C3=B6=C3=9Fe skalieren"
=20
-#: ui/gtk.c:1981
+#: ui/gtk.c:2075
 msgid "Grab On _Hover"
 msgstr "Tastatur _automatisch einfangen"
=20
-#: ui/gtk.c:1984
+#: ui/gtk.c:2078
 msgid "_Grab Input"
 msgstr "_Eingabeger=C3=A4te einfangen"
=20
-#: ui/gtk.c:2013
+#: ui/gtk.c:2107
 msgid "Show _Tabs"
 msgstr "Reiter anzeigen"
=20
-#: ui/gtk.c:2016
+#: ui/gtk.c:2110
 msgid "Detach Tab"
 msgstr "Reiter abtrennen"
=20
-#: ui/gtk.c:2028
+#: ui/gtk.c:2122
 msgid "_Machine"
 msgstr "_Maschine"
=20
-#: ui/gtk.c:2033
+#: ui/gtk.c:2127
 msgid "_View"
 msgstr "_Ansicht"
diff --git a/po/fr_FR.po b/po/fr_FR.po
index e9fb040..358532b 100644
--- a/po/fr_FR.po
+++ b/po/fr_FR.po
@@ -6,7 +6,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: QEMU 1.4.50\n"
 "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
-"POT-Creation-Date: 2016-04-18 14:50+0100\n"
+"POT-Creation-Date: 2016-12-13 21:46+0000\n"
 "PO-Revision-Date: 2014-07-28 23:25+0200\n"
 "Last-Translator: Aurelien Jarno <aurelien@aurel32.net>\n"
 "Language-Team: French <FR@li.org>\n"
@@ -17,70 +17,74 @@ msgstr ""
 "Plural-Forms: nplurals=3D2; plural=3Dn !=3D 1;\n"
 "X-Generator: Lokalize 1.4\n"
=20
-#: ui/gtk.c:273
+#: ui/gtk.c:275
 msgid " - Press Ctrl+Alt+G to release grab"
 msgstr "- Appuyer sur Ctrl+Alt+G pour arr=C3=AAter la capture"
=20
-#: ui/gtk.c:277
+#: ui/gtk.c:279
 msgid " [Paused]"
 msgstr "=C2=A0[En pause]"
=20
-#: ui/gtk.c:1833
+#: ui/gtk.c:1922
 msgid "_Pause"
 msgstr "_Pause"
=20
-#: ui/gtk.c:1839
+#: ui/gtk.c:1928
 msgid "_Reset"
 msgstr "_R=C3=A9initialiser"
=20
-#: ui/gtk.c:1842
+#: ui/gtk.c:1931
 msgid "Power _Down"
 msgstr "_=C3=89teindre"
=20
-#: ui/gtk.c:1848
+#: ui/gtk.c:1937
 msgid "_Quit"
 msgstr "_Quitter"
=20
-#: ui/gtk.c:1940
+#: ui/gtk.c:2029
 msgid "_Fullscreen"
 msgstr "Mode _plein =C3=A9cran"
=20
-#: ui/gtk.c:1954
+#: ui/gtk.c:2032
+msgid "_Copy"
+msgstr ""
+
+#: ui/gtk.c:2048
 msgid "Zoom _In"
 msgstr "Zoom _avant"
=20
-#: ui/gtk.c:1961
+#: ui/gtk.c:2055
 msgid "Zoom _Out"
 msgstr "_Zoom arri=C3=A8re"
=20
-#: ui/gtk.c:1968
+#: ui/gtk.c:2062
 msgid "Best _Fit"
 msgstr "Zoom _id=C3=A9al"
=20
-#: ui/gtk.c:1975
+#: ui/gtk.c:2069
 msgid "Zoom To _Fit"
 msgstr "Zoomer pour a_juster"
=20
-#: ui/gtk.c:1981
+#: ui/gtk.c:2075
 msgid "Grab On _Hover"
 msgstr "Capturer en _survolant"
=20
-#: ui/gtk.c:1984
+#: ui/gtk.c:2078
 msgid "_Grab Input"
 msgstr "_Capturer les entr=C3=A9es"
=20
-#: ui/gtk.c:2013
+#: ui/gtk.c:2107
 msgid "Show _Tabs"
 msgstr "Montrer les _onglets"
=20
-#: ui/gtk.c:2016
+#: ui/gtk.c:2110
 msgid "Detach Tab"
 msgstr "_D=C3=A9tacher l'onglet"
=20
-#: ui/gtk.c:2028
+#: ui/gtk.c:2122
 msgid "_Machine"
 msgstr "_Machine"
=20
-#: ui/gtk.c:2033
+#: ui/gtk.c:2127
 msgid "_View"
 msgstr "_Vue"
diff --git a/po/hu.po b/po/hu.po
index 1149adf..86f78e9 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -6,7 +6,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: QEMU 1.4.50\n"
 "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
-"POT-Creation-Date: 2016-04-18 14:50+0100\n"
+"POT-Creation-Date: 2016-12-13 21:46+0000\n"
 "PO-Revision-Date: 2013-05-06 20:42+0200\n"
 "Last-Translator: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>\n"
 "Language-Team: Hungarian <hu@li.org>\n"
@@ -15,73 +15,77 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: ui/gtk.c:273
+#: ui/gtk.c:275
 msgid " - Press Ctrl+Alt+G to release grab"
 msgstr " - Nyomj Ctrl+Alt+G-t a bemeneti eszk=C3=B6z=C3=B6k elenged=C3=A9=
s=C3=A9hez"
=20
-#: ui/gtk.c:277
+#: ui/gtk.c:279
 msgid " [Paused]"
 msgstr " [Meg=C3=A1ll=C3=ADtva]"
=20
-#: ui/gtk.c:1833
+#: ui/gtk.c:1922
 msgid "_Pause"
 msgstr "_Meg=C3=A1ll=C3=ADt=C3=A1s"
=20
-#: ui/gtk.c:1839
+#: ui/gtk.c:1928
 msgid "_Reset"
 msgstr "=C3=9Aj_raind=C3=ADt=C3=A1s"
=20
-#: ui/gtk.c:1842
+#: ui/gtk.c:1931
 msgid "Power _Down"
 msgstr "_Le=C3=A1ll=C3=ADt=C3=A1s"
=20
-#: ui/gtk.c:1848
+#: ui/gtk.c:1937
 msgid "_Quit"
 msgstr ""
=20
-#: ui/gtk.c:1940
+#: ui/gtk.c:2029
 msgid "_Fullscreen"
 msgstr ""
=20
-#: ui/gtk.c:1954
+#: ui/gtk.c:2032
+msgid "_Copy"
+msgstr ""
+
+#: ui/gtk.c:2048
 #, fuzzy
 msgid "Zoom _In"
 msgstr "Ablakm=C3=A9rethez _igaz=C3=ADt=C3=A1s"
=20
-#: ui/gtk.c:1961
+#: ui/gtk.c:2055
 #, fuzzy
 msgid "Zoom _Out"
 msgstr "Ablakm=C3=A9rethez _igaz=C3=ADt=C3=A1s"
=20
-#: ui/gtk.c:1968
+#: ui/gtk.c:2062
 msgid "Best _Fit"
 msgstr ""
=20
-#: ui/gtk.c:1975
+#: ui/gtk.c:2069
 msgid "Zoom To _Fit"
 msgstr "Ablakm=C3=A9rethez _igaz=C3=ADt=C3=A1s"
=20
-#: ui/gtk.c:1981
+#: ui/gtk.c:2075
 msgid "Grab On _Hover"
 msgstr "Automatikus _elfog=C3=A1s"
=20
-#: ui/gtk.c:1984
+#: ui/gtk.c:2078
 msgid "_Grab Input"
 msgstr "_Bemeneti eszk=C3=B6z=C3=B6k megragad=C3=A1sa"
=20
-#: ui/gtk.c:2013
+#: ui/gtk.c:2107
 msgid "Show _Tabs"
 msgstr "_F=C3=BClek megjelen=C3=ADt=C3=A9se"
=20
-#: ui/gtk.c:2016
+#: ui/gtk.c:2110
 msgid "Detach Tab"
 msgstr ""
=20
-#: ui/gtk.c:2028
+#: ui/gtk.c:2122
 msgid "_Machine"
 msgstr "_G=C3=A9p"
=20
-#: ui/gtk.c:2033
+#: ui/gtk.c:2127
 msgid "_View"
 msgstr "_N=C3=A9zet"
=20
diff --git a/po/it.po b/po/it.po
index a2c8e55..8eadf2f 100644
--- a/po/it.po
+++ b/po/it.po
@@ -6,7 +6,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: QEMU 1.4.50\n"
 "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
-"POT-Creation-Date: 2016-04-18 14:50+0100\n"
+"POT-Creation-Date: 2016-12-13 21:46+0000\n"
 "PO-Revision-Date: 2014-07-29 08:25+0200\n"
 "Last-Translator: Paolo Bonzini <pbonzini@redhat.com>\n"
 "Language-Team: Italian <it@li.org>\n"
@@ -16,70 +16,74 @@ msgstr ""
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=3D2; plural=3Dn !=3D 1;\n"
=20
-#: ui/gtk.c:273
+#: ui/gtk.c:275
 msgid " - Press Ctrl+Alt+G to release grab"
 msgstr " - Premere Ctrl+Alt+G per rilasciare l'input"
=20
-#: ui/gtk.c:277
+#: ui/gtk.c:279
 msgid " [Paused]"
 msgstr " [Pausa]"
=20
-#: ui/gtk.c:1833
+#: ui/gtk.c:1922
 msgid "_Pause"
 msgstr "_Pausa"
=20
-#: ui/gtk.c:1839
+#: ui/gtk.c:1928
 msgid "_Reset"
 msgstr "_Reset"
=20
-#: ui/gtk.c:1842
+#: ui/gtk.c:1931
 msgid "Power _Down"
 msgstr "_Spegni"
=20
-#: ui/gtk.c:1848
+#: ui/gtk.c:1937
 msgid "_Quit"
 msgstr "_Esci"
=20
-#: ui/gtk.c:1940
+#: ui/gtk.c:2029
 msgid "_Fullscreen"
 msgstr ""
=20
-#: ui/gtk.c:1954
+#: ui/gtk.c:2032
+msgid "_Copy"
+msgstr ""
+
+#: ui/gtk.c:2048
 msgid "Zoom _In"
 msgstr "_Aumenta zoom"
=20
-#: ui/gtk.c:1961
+#: ui/gtk.c:2055
 msgid "Zoom _Out"
 msgstr "_Riduci zoom"
=20
-#: ui/gtk.c:1968
+#: ui/gtk.c:2062
 msgid "Best _Fit"
 msgstr "A_nnulla zoom"
=20
-#: ui/gtk.c:1975
+#: ui/gtk.c:2069
 msgid "Zoom To _Fit"
 msgstr "Adatta alla _finestra"
=20
-#: ui/gtk.c:1981
+#: ui/gtk.c:2075
 msgid "Grab On _Hover"
 msgstr "Cattura _automatica input"
=20
-#: ui/gtk.c:1984
+#: ui/gtk.c:2078
 msgid "_Grab Input"
 msgstr "_Cattura input"
=20
-#: ui/gtk.c:2013
+#: ui/gtk.c:2107
 msgid "Show _Tabs"
 msgstr "Mostra _tab"
=20
-#: ui/gtk.c:2016
+#: ui/gtk.c:2110
 msgid "Detach Tab"
 msgstr "_Sposta in una nuova finestra"
=20
-#: ui/gtk.c:2028
+#: ui/gtk.c:2122
 msgid "_Machine"
 msgstr "_Macchina virtuale"
=20
-#: ui/gtk.c:2033
+#: ui/gtk.c:2127
 msgid "_View"
 msgstr "_Visualizza"
diff --git a/po/messages.po b/po/messages.po
index e8f9ccd..e0a98c1 100644
--- a/po/messages.po
+++ b/po/messages.po
@@ -5,9 +5,9 @@
 #, fuzzy
 msgid ""
 msgstr ""
-"Project-Id-Version: QEMU 2.5.92\n"
+"Project-Id-Version: QEMU 2.7.93\n"
 "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
-"POT-Creation-Date: 2016-04-18 14:50+0100\n"
+"POT-Creation-Date: 2016-12-13 21:46+0000\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -16,70 +16,74 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: ui/gtk.c:273
+#: ui/gtk.c:275
 msgid " - Press Ctrl+Alt+G to release grab"
 msgstr ""
=20
-#: ui/gtk.c:277
+#: ui/gtk.c:279
 msgid " [Paused]"
 msgstr ""
=20
-#: ui/gtk.c:1833
+#: ui/gtk.c:1922
 msgid "_Pause"
 msgstr ""
=20
-#: ui/gtk.c:1839
+#: ui/gtk.c:1928
 msgid "_Reset"
 msgstr ""
=20
-#: ui/gtk.c:1842
+#: ui/gtk.c:1931
 msgid "Power _Down"
 msgstr ""
=20
-#: ui/gtk.c:1848
+#: ui/gtk.c:1937
 msgid "_Quit"
 msgstr ""
=20
-#: ui/gtk.c:1940
+#: ui/gtk.c:2029
 msgid "_Fullscreen"
 msgstr ""
=20
-#: ui/gtk.c:1954
+#: ui/gtk.c:2032
+msgid "_Copy"
+msgstr ""
+
+#: ui/gtk.c:2048
 msgid "Zoom _In"
 msgstr ""
=20
-#: ui/gtk.c:1961
+#: ui/gtk.c:2055
 msgid "Zoom _Out"
 msgstr ""
=20
-#: ui/gtk.c:1968
+#: ui/gtk.c:2062
 msgid "Best _Fit"
 msgstr ""
=20
-#: ui/gtk.c:1975
+#: ui/gtk.c:2069
 msgid "Zoom To _Fit"
 msgstr ""
=20
-#: ui/gtk.c:1981
+#: ui/gtk.c:2075
 msgid "Grab On _Hover"
 msgstr ""
=20
-#: ui/gtk.c:1984
+#: ui/gtk.c:2078
 msgid "_Grab Input"
 msgstr ""
=20
-#: ui/gtk.c:2013
+#: ui/gtk.c:2107
 msgid "Show _Tabs"
 msgstr ""
=20
-#: ui/gtk.c:2016
+#: ui/gtk.c:2110
 msgid "Detach Tab"
 msgstr ""
=20
-#: ui/gtk.c:2028
+#: ui/gtk.c:2122
 msgid "_Machine"
 msgstr ""
=20
-#: ui/gtk.c:2033
+#: ui/gtk.c:2127
 msgid "_View"
 msgstr ""
diff --git a/po/tr.po b/po/tr.po
index ec99127..af34b52 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -6,7 +6,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: QEMU 1.4.50\n"
 "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
-"POT-Creation-Date: 2016-04-18 14:50+0100\n"
+"POT-Creation-Date: 2016-12-13 21:46+0000\n"
 "PO-Revision-Date: 2013-04-22 18:35+0300\n"
 "Last-Translator: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>\n"
 "Language-Team: T=C3=BCrk=C3=A7e <>\n"
@@ -17,72 +17,76 @@ msgstr ""
 "Plural-Forms: nplurals=3D1; plural=3D0;\n"
 "X-Generator: Gtranslator 2.91.6\n"
=20
-#: ui/gtk.c:273
+#: ui/gtk.c:275
 msgid " - Press Ctrl+Alt+G to release grab"
 msgstr " - Yakalamay=C4=B1 durdurmak i=C3=A7in Ctrl+Alt+G tu=C5=9Flar=C4=
=B1na bas=C4=B1n"
=20
-#: ui/gtk.c:277
+#: ui/gtk.c:279
 msgid " [Paused]"
 msgstr " [Duraklat=C4=B1ld=C4=B1]"
=20
-#: ui/gtk.c:1833
+#: ui/gtk.c:1922
 msgid "_Pause"
 msgstr "_Duraklat"
=20
-#: ui/gtk.c:1839
+#: ui/gtk.c:1928
 msgid "_Reset"
 msgstr "_S=C4=B1f=C4=B1rla"
=20
-#: ui/gtk.c:1842
+#: ui/gtk.c:1931
 msgid "Power _Down"
 msgstr "_Kapat"
=20
-#: ui/gtk.c:1848
+#: ui/gtk.c:1937
 msgid "_Quit"
 msgstr ""
=20
-#: ui/gtk.c:1940
+#: ui/gtk.c:2029
 msgid "_Fullscreen"
 msgstr ""
=20
-#: ui/gtk.c:1954
+#: ui/gtk.c:2032
+msgid "_Copy"
+msgstr ""
+
+#: ui/gtk.c:2048
 #, fuzzy
 msgid "Zoom _In"
 msgstr "Yak=C4=B1nla=C5=9F ve S=C4=B1=C4=9F_d=C4=B1r"
=20
-#: ui/gtk.c:1961
+#: ui/gtk.c:2055
 #, fuzzy
 msgid "Zoom _Out"
 msgstr "Yak=C4=B1nla=C5=9F ve S=C4=B1=C4=9F_d=C4=B1r"
=20
-#: ui/gtk.c:1968
+#: ui/gtk.c:2062
 msgid "Best _Fit"
 msgstr ""
=20
-#: ui/gtk.c:1975
+#: ui/gtk.c:2069
 msgid "Zoom To _Fit"
 msgstr "Yak=C4=B1nla=C5=9F ve S=C4=B1=C4=9F_d=C4=B1r"
=20
-#: ui/gtk.c:1981
+#: ui/gtk.c:2075
 msgid "Grab On _Hover"
 msgstr "=C3=9C_zerindeyken Yakala"
=20
-#: ui/gtk.c:1984
+#: ui/gtk.c:2078
 msgid "_Grab Input"
 msgstr "Girdiyi _Yakala"
=20
-#: ui/gtk.c:2013
+#: ui/gtk.c:2107
 msgid "Show _Tabs"
 msgstr "Se_kmeleri G=C3=B6ster"
=20
-#: ui/gtk.c:2016
+#: ui/gtk.c:2110
 msgid "Detach Tab"
 msgstr ""
=20
-#: ui/gtk.c:2028
+#: ui/gtk.c:2122
 msgid "_Machine"
 msgstr "_Makine"
=20
-#: ui/gtk.c:2033
+#: ui/gtk.c:2127
 msgid "_View"
 msgstr "_G=C3=B6r=C3=BCnt=C3=BCle"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index b55b6f3..9523cfb 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -6,7 +6,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: QEMU 2.2\n"
 "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
-"POT-Creation-Date: 2016-04-18 14:50+0100\n"
+"POT-Creation-Date: 2016-12-13 21:46+0000\n"
 "PO-Revision-Date: 2014-07-31 10:00+0800\n"
 "Last-Translator: Fam Zheng <famz@redhat.com>\n"
 "Language-Team: Chinese <zh@li.org>\n"
@@ -17,70 +17,74 @@ msgstr ""
 "Plural-Forms: nplurals=3D2; plural=3Dn !=3D 1;\n"
 "X-Generator: Lokalize 1.4\n"
=20
-#: ui/gtk.c:273
+#: ui/gtk.c:275
 msgid " - Press Ctrl+Alt+G to release grab"
 msgstr " - =E6=8C=89=E4=B8=8B Ctrl+Alt+G =E5=8F=96=E6=B6=88=E6=8D=95=E8=8E=
=B7"
=20
-#: ui/gtk.c:277
+#: ui/gtk.c:279
 msgid " [Paused]"
 msgstr "=C2=A0[=E5=B7=B2=E6=9A=82=E5=81=9C]"
=20
-#: ui/gtk.c:1833
+#: ui/gtk.c:1922
 msgid "_Pause"
 msgstr "=E6=9A=82=E5=81=9C(_P)"
=20
-#: ui/gtk.c:1839
+#: ui/gtk.c:1928
 msgid "_Reset"
 msgstr "=E9=87=8D=E7=BD=AE(_R)"
=20
-#: ui/gtk.c:1842
+#: ui/gtk.c:1931
 msgid "Power _Down"
 msgstr "=E5=85=B3=E9=97=AD=E7=94=B5=E6=BA=90(_D)"
=20
-#: ui/gtk.c:1848
+#: ui/gtk.c:1937
 msgid "_Quit"
 msgstr "=E9=80=80=E5=87=BA(_Q)"
=20
-#: ui/gtk.c:1940
+#: ui/gtk.c:2029
 msgid "_Fullscreen"
 msgstr "=E5=85=A8=E5=B1=8F(_F)"
=20
-#: ui/gtk.c:1954
+#: ui/gtk.c:2032
+msgid "_Copy"
+msgstr ""
+
+#: ui/gtk.c:2048
 msgid "Zoom _In"
 msgstr "=E6=94=BE=E5=A4=A7(_I)"
=20
-#: ui/gtk.c:1961
+#: ui/gtk.c:2055
 msgid "Zoom _Out"
 msgstr "=E7=BC=A9=E5=B0=8F(_O)"
=20
-#: ui/gtk.c:1968
+#: ui/gtk.c:2062
 msgid "Best _Fit"
 msgstr "=E6=9C=80=E5=90=88=E9=80=82=E5=A4=A7=E5=B0=8F(_F)"
=20
-#: ui/gtk.c:1975
+#: ui/gtk.c:2069
 msgid "Zoom To _Fit"
 msgstr "=E7=BC=A9=E6=94=BE=E4=BB=A5=E9=80=82=E5=BA=94=E5=A4=A7=E5=B0=8F(=
_F)"
=20
-#: ui/gtk.c:1981
+#: ui/gtk.c:2075
 msgid "Grab On _Hover"
 msgstr "=E9=BC=A0=E6=A0=87=E7=BB=8F=E8=BF=87=E6=97=B6=E6=8D=95=E8=8E=B7(=
_H)"
=20
-#: ui/gtk.c:1984
+#: ui/gtk.c:2078
 msgid "_Grab Input"
 msgstr "=E6=8D=95=E8=8E=B7=E8=BE=93=E5=85=A5(_G)"
=20
-#: ui/gtk.c:2013
+#: ui/gtk.c:2107
 msgid "Show _Tabs"
 msgstr "=E6=98=BE=E7=A4=BA=E6=A0=87=E7=AD=BE=E9=A1=B5(_T)"
=20
-#: ui/gtk.c:2016
+#: ui/gtk.c:2110
 msgid "Detach Tab"
 msgstr "=E5=88=86=E7=A6=BB=E6=A0=87=E7=AD=BE=E9=A1=B5"
=20
-#: ui/gtk.c:2028
+#: ui/gtk.c:2122
 msgid "_Machine"
 msgstr "=E8=99=9A=E6=8B=9F=E6=9C=BA(_M)"
=20
-#: ui/gtk.c:2033
+#: ui/gtk.c:2127
 msgid "_View"
 msgstr "=E8=A7=86=E5=9B=BE(_V)"
--=20
2.9.3
