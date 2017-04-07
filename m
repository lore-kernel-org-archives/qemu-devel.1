Received: from eggs.gnu.org ([2001:4830:134:3::10]:50464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW1-0003VK-OR
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW0-0000VU-OO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:43245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUW0-0000V4-Hf
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUVy-0003PE-90
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 14:05:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3CBED2E80CC
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 14:05:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:53:57 -0000
From: Thomas Huth <1077806@bugs.launchpad.net>
Reply-To: Bug 1077806 <1077806@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121112055804.26632.12961.malonedeb@gac.canonical.com>
Message-Id: <20170407135357.12101.42791.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1077806] Re: Integrate Virtualbox/Qemu Guest
 booting as a desktop environment listing (request)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** No longer affects: qemu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1077806

Title:
  Integrate Virtualbox/Qemu Guest booting as a desktop environment
  listing (request)

Status in Light Display Manager:
  New
Status in Greeter:
  Confirmed

Bug description:
  I had seen this new way to install Chromium OS and "boot" it using
  LightDM's session select menu, and it made me think of an idea:

  What if you were able to boot virtual machines in the same manner? It
  would simplify the Ubuntu user's life GREATLY if they had easy access
  to a Windows VM that can synchronize their files to and fro (Guest
  additions) and not require a reboot to use it. Modern computers have
  more than enough power to do something like this, and it should be
  even easier if the system is using a dedicated virtual machine
  environment rather than a full blown desktop.

  This can transform LightDM from being just another login screen to a
  full-blown glorified host for all of your operating systems and remote
  logins.

  I think this would make using Ubuntu a LOT less of a hassle for the
  new user who came from Windows :)

To manage notifications about this bug go to:
https://bugs.launchpad.net/lightdm/+bug/1077806/+subscriptions
