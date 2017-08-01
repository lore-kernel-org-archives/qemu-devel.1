Received: from eggs.gnu.org ([2001:4830:134:3::10]:47388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dccAz-0001PQ-JP
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 14:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dccAu-0007Fe-Jq
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 14:45:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:52277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dccAu-0007Cq-Dq
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 14:45:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dccAr-0005bL-TY
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 18:45:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CEC3B2E80CB
	for <qemu-devel@nongnu.org>; Tue,  1 Aug 2017 18:45:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Aug 2017 18:28:44 -0000
From: Thomas Huth <1473451@bugs.launchpad.net>
Reply-To: Bug 1473451 <1473451@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150710133758.14989.51708.malonedeb@chaenomeles.canonical.com>
Message-Id: <150161212563.13032.6520427298593367981.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1473451] Re: Please support the native bios
 format for dec alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1473451

Title:
  Please support the native bios format for dec alpha

Status in QEMU:
  Won't Fix

Bug description:
  Currently qemu-system-alpha -bios parameter takes an ELF image.
  However HP maintains firmware updates for those systems.

  Some example rom files can be found here
  ftp://ftp.hp.com/pub/alphaserver/firmware/current_platforms/v7.3_release/=
DS20_DS20e/

  It might allow things like using the SRM firmware.
  The ARC(nt) firmware would allow to build and test windows applications f=
or that platforms without having the relevant hardware

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1473451/+subscriptions
