Received: from eggs.gnu.org ([2001:4830:134:3::10]:58971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqttZ-0003i2-DR
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqttV-0003Nu-Lh
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:42812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dqttV-0003N4-Fh
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dqttU-0000tn-EQ
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 04:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 61FB92E8491
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 04:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Sep 2017 04:17:49 -0000
From: Launchpad Bug Tracker <1093360@bugs.launchpad.net>
Reply-To: Bug 1093360 <1093360@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121223234026.15429.45355.malonedeb@wampee.canonical.com>
Message-Id: <150501707002.27827.8314561867273466430.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1093360] Re: files on microsoft iso images
 mounted to qemu VM get stripped from Version info. E.G. Microsoft UAG
 installation fails
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
https://bugs.launchpad.net/bugs/1093360

Title:
  files on microsoft iso images mounted to qemu VM  get stripped  from
  Version info. E.G. Microsoft UAG installation fails

Status in QEMU:
  Expired

Bug description:
  QEMU 0.9.0-0.14.1
  KVM 60-88-0.14.1
  there is a reference for a root cause, why installation of Microsoft UAG =
fails.
  http://blogs.technet.com/b/isablog/archive/2010/07/13/another-tmg-2010-in=
stallation-failure-with-error-0x80070643.aspx

  when checking available information on the mounted UAG ISO in my qemu mac=
hine, I realized simliar reduced information.
  this was found:
  using AQEMU 0.8.2 of 2011.07.27

  using QEMU 0.9.0-0.14.1 and KVM 60-88-0.14.1
  in an KVM managed  machine

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1093360/+subscriptions
