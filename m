Received: from eggs.gnu.org ([2001:4830:134:3::10]:42396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRx1f-00061s-Gw
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRx1a-0000kT-Jl
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:45255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRx1a-0000k0-DJ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRx1Z-0004Df-83
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:15:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4108E2E805E
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:15:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2017 08:03:11 -0000
From: Thomas Huth <917645@bugs.launchpad.net>
Reply-To: Bug 917645 <917645@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120117134021.32382.93820.malonedeb@gac.canonical.com>
Message-Id: <20170113080312.26958.73212.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 917645] Re: [Feature request] ia64-softmmu wanted
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
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/917645

Title:
  [Feature request] ia64-softmmu wanted

Status in HelenOS branches:
  Confirmed
Status in QEMU:
  New

Bug description:
  Qemu is missing support for full system emulation of the Itanium
  architecture, which is one of the main non-x86 server architectures
  today (despite the alleged decline in popularity). It would be really
  nice if someone had interest in adding full ia64 support to Qemu. Many
  OS projects could then use Qemu as the universal machine emulator for
  development and testing.

  Note that there is an open source Ski simulator which can emulate an
  ia64 CPU, memory and a couple of Ski-specific devices, but the project
  seems inactive and the simulated machine is too simplified (no real
  devices, no real firmware). Moreover, it'd be better to have one tool
  such as Qemu for all architectures of interest rather than one per
  each architecture.

To manage notifications about this bug go to:
https://bugs.launchpad.net/helenos/+bug/917645/+subscriptions
