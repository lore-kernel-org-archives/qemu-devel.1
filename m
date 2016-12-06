Received: from eggs.gnu.org ([2001:4830:134:3::10]:60111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEEsE-0002Q7-QW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEEsD-0000AG-PP
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:29:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:54733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cEEsD-0000A3-Jt
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:29:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cEEsA-0000wW-E3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:29:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C00602E85C9
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 12:25:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Dec 2016 12:06:06 -0000
From: Thomas Huth <1248469@bugs.launchpad.net>
Reply-To: Bug 1248469 <1248469@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131106095553.10338.40361.malonedeb@soybean.canonical.com>
Message-Id: <20161206120606.5864.38672.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1248469] Re: qemu 1.6.1 q35 ioh3420 not work in
 windows 7 32bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1248469

Title:
  qemu 1.6.1 q35 ioh3420 not work in windows 7 32bit

Status in QEMU:
  Incomplete

Bug description:
  boot windows 7 32bit guest with -readconfig q35-chipset.cfg
  paramter,in guest's device manager,there's a device 3420 not work,it
  shows error "This device cannot find enough free resources that it can
  use(code 12)".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1248469/+subscriptions
