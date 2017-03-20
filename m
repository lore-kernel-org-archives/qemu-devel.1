Received: from eggs.gnu.org ([2001:4830:134:3::10]:38328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cq6H9-0007te-5J
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cq6H5-0002GM-6Q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:59:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:54074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cq6H5-0002GE-0i
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:59:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cq6H3-0005wE-K6
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 22:59:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8CA7B2E80C8
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 22:59:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Mar 2017 22:49:56 -0000
From: Thomas Huth <686613@bugs.launchpad.net>
Reply-To: Bug 686613 <686613@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101207152739.2998.55046.malonedeb@soybean.canonical.com>
Message-Id: <20170320224957.19253.91233.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 686613] Re: USB MSD are not marked as removable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Setting status to "Fix released" according to comment #5 (if there is
something left to do for libvirt, please consult their bugtracker
instead)

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/686613

Title:
  USB MSD are not marked as removable

Status in QEMU:
  Fix Released

Bug description:
   Filed from Fedora bug:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D589130

  Guests can access USB Mass Storage Device, but fail to mark them as
  removable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/686613/+subscriptions
