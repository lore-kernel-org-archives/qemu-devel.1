Received: from eggs.gnu.org ([2001:4830:134:3::10]:34049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYfSq-00079J-Qx
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYfSo-0004dY-Hj
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:55:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:58484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYfSo-0004dI-B7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:55:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYfSm-0007Mf-TB
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 20:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 178C02E80CD
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 20:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Jan 2017 20:45:04 -0000
From: Thomas Huth <1241569@bugs.launchpad.net>
Reply-To: Bug 1241569 <1241569@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131018130828.2128.60192.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170131204506.8744.84480.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1241569] Re: qemu-system-alpha console
 unresponsive
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
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1241569

Title:
  qemu-system-alpha console unresponsive

Status in QEMU:
  Invalid

Bug description:
  I have created a virtual machine using the QEMU Alpha emulator (very
  basic, 1 scsi disc, 1 scsi CDROM, 1gb memory). The machine starts, but
  entering any system commands at the prompt just echs back the command
  typed. For example

  >>> show device
  got: show device
  >>> =


  Obviously booting any OS from this is not possible.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1241569/+subscriptions
