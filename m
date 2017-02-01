Received: from eggs.gnu.org ([2001:4830:134:3::10]:43237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYrKV-0008Jg-1e
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYrKR-0003WD-5L
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:49426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYrKQ-0003Ux-VU
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYrKO-0005UR-5b
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 09:35:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 282AC2E80C7
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 09:35:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Feb 2017 09:19:31 -0000
From: Thomas Huth <1253465@bugs.launchpad.net>
Reply-To: Bug 1253465 <1253465@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131120230014.7464.50074.malonedeb@wampee.canonical.com>
Message-Id: <20170201091932.17147.64617.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1253465] Re: qemu-img: 'image' uses a vmdk
 feature which is not supported by this qemu version: VMDK version 3
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
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1253465

Title:
  qemu-img: 'image' uses a vmdk feature which is not supported by this
  qemu version: VMDK version 3

Status in QEMU:
  Incomplete

Bug description:
  qemu-img convert in.vmdk  -O RAW out.img

  Fails with:
  qemu-img: 'image' uses a vmdk feature which is not supported by this qemu=
 version: VMDK version 3

  qemu-img version 1.6.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1253465/+subscriptions
