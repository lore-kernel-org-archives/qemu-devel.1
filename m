Received: from eggs.gnu.org ([2001:4830:134:3::10]:36441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RPw-00030g-08
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RPs-0003Ef-9G
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:54278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RPs-0003Dq-3M
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RPr-0005c4-6A
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:44:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2C3002E80C8
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:44:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:32:32 -0000
From: Thomas Huth <1296882@bugs.launchpad.net>
Reply-To: Bug 1296882 <1296882@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140324182946.30334.39445.malonedeb@gac.canonical.com>
Message-Id: <150919755301.8759.1063891720516221901.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1296882] Re: add next free device option to
 qemu-img
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
https://bugs.launchpad.net/bugs/1296882

Title:
  add next free device option to qemu-img

Status in QEMU:
  New

Bug description:
  I'd like to propose an option to be added to qemu-img which returns
  the next free NBD (the device file) very similar to losetup -f. It
  would make life a lot easier.

  Followers of this enhancement request might be interested in the
  following workaround: http://stackoverflow.com/questions/22535222
  /next-free-device-option-for-qemu-nbd/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1296882/+subscriptions
