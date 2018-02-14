Received: from eggs.gnu.org ([2001:4830:134:3::10]:38776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elohS-0002GB-4x
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elohO-00006p-9r
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:29:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:49694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1elohO-00006S-4Z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:29:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1elohN-0001UL-2F
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 04:29:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0ECF12E80D1
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 04:29:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2018 04:17:31 -0000
From: Launchpad Bug Tracker <855630@bugs.launchpad.net>
Reply-To: Bug 855630 <855630@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110921150616.12335.44343.malonedeb@gac.canonical.com>
Message-Id: <151858185119.8459.630875613141894160.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 855630] Re: Cant Run Wine (posix not nptl) past
 0.14.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/855630

Title:
  Cant Run Wine (posix not nptl) past 0.14.1

Status in QEMU:
  Expired

Bug description:
  when trying to build qemu I can build with ./configure --static
  --target-list=3Di386-linux-user just fine with 0.14.1

  But when I try to go on 0.15.0 or higher (tested on 0.15.0). About to
  test on 0.15.5 from git

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/855630/+subscriptions
