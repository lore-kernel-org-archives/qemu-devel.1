Received: from eggs.gnu.org ([2001:4830:134:3::10]:43138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxZDZ-0001tu-TK
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxZ9C-0001gE-PH
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:51:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fxZ9B-0001eG-0d
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:51:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fxZ99-0006PG-Oo
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 14:51:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BAA0A2E8058
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 14:51:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Sep 2018 14:38:46 -0000
From: "Emilio G. Cota" <1735049@bugs.launchpad.net>
Reply-To: Bug 1735049 <1735049@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151192504398.10243.14437635177032457733.malonedeb@wampee.canonical.com>
Message-Id: <153615832763.31697.10905627331130159753.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735049] Re: Need MTTCG support for x86 guests
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
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735049

Title:
  Need MTTCG support for x86 guests

Status in QEMU:
  In Progress

Bug description:
  MTTCG support is notably absent for x86_64 guests.  The last Wiki
  update on MTTCG was back in 2015, and I am having some difficulty
  determining the current status of the underlying requirements to
  enable this feature on x86 hosts.

  For instance, has support for strong-on-weak memory consistency been
  added into QEMU GIT at this point?

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735049/+subscriptions
