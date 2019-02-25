Received: from eggs.gnu.org ([209.51.188.92]:44612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gyOHo-0000aX-6B
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 16:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gyOHn-0007Vm-7p
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 16:59:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:36682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gyOHl-0007MF-J1
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 16:59:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gyOHZ-0001WM-W4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 21:59:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E653C2E807C
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 21:59:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Feb 2019 21:47:06 -0000
From: empty <ytrezq@sdf-eu.org>
Reply-To: Bug 1473451 <1473451@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150710133758.14989.51708.malonedeb@chaenomeles.canonical.com>
Message-Id: <155113122651.22969.12723456517103614638.malone@wampee.canonical.com>
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

But In that case it=E2=80=99s impossible to emulate or even compile Windows=
 for
Dec Alpha.

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
