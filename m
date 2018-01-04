Received: from eggs.gnu.org ([2001:4830:134:3::10]:40343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eWzvl-0001a5-JP
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eWzvh-00014Q-H2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:27:13 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:48836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1eWzvh-00013X-AF
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:27:09 -0500
Date: Thu, 4 Jan 2018 08:27:08 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <1548618960.818551.1515050828217.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <446087972.818501.1515050674109.JavaMail.zimbra@oxygem.tv>
References: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
	<446087972.818501.1515050674109.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>

does somebody have a redhat account to see te content of:=20

https://access.redhat.com/solutions/3307851
"Impacts of CVE-2017-5754, CVE-2017-5753, and CVE-2017-5715 to Red Hat Virt=
ualization products"

----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
Cc: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Jeudi 4 Janvier 2018 08:24:34
Objet: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches

>>Can anybody point me to the relevant qemu patches?=20

I don't have find them yet.=20

Do you known if a vm using kvm64 cpu model is protected or not ?=20

----- Mail original -----=20
De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>=20
Envoy=C3=A9: Jeudi 4 Janvier 2018 07:27:01=20
Objet: [Qemu-devel] CVE-2017-5715: relevant qemu patches=20

Hello,=20

i've seen some vendors have updated qemu regarding meltdown / spectre.=20

f.e.:=20

CVE-2017-5715: QEMU was updated to allow passing through new MSR and=20
CPUID flags from the host VM to the CPU, to allow enabling/disabling=20
branch prediction features in the Intel CPU. (bsc#1068032)=20

Can anybody point me to the relevant qemu patches?=20

Thanks!=20

Greets,=20
Stefan=20
