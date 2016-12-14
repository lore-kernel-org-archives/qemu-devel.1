Received: from eggs.gnu.org ([2001:4830:134:3::10]:35823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cHBZh-00040b-1R
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cHBZd-00030a-4l
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:34:33 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:51554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1cHBZc-0002r4-V4
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:34:29 -0500
Date: Wed, 14 Dec 2016 16:33:58 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <1383290552.4515122.1481729638569.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <1a3a7aef-55f1-11b6-b33f-621979cbb59f@profihost.ag>
References: <1a3a7aef-55f1-11b6-b33f-621979cbb59f@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?
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

Hi Stefan,

do you have upgraded kernel ?

maybe it could be related to vhost-net module too.


----- Mail original -----
De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Mercredi 14 D=C3=A9cembre 2016 16:04:08
Objet: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?

Hello,=20

after upgrading a cluster OS, Qemu, ... i'm experiencing slow and=20
volatile network speeds inside my VMs.=20

Currently I've no idea what causes this but it's related to the host=20
upgrades. Before i was running Qemu 2.6.2.=20

I'm using virtio for the network cards.=20

Greets,=20
Stefan=20
