Received: from eggs.gnu.org ([2001:4830:134:3::10]:50705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzKwg-0003l7-PL
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzKwf-0004jr-8n
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:01:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:43926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzKwf-0004j6-3S
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:01:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzKwe-0002SG-4H
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 11:01:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1266A2E80C9
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 11:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 10:42:58 -0000
From: Thomas Huth <1320360@bugs.launchpad.net>
Reply-To: Bug 1320360 <1320360@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140516193455.16097.46510.malonedeb@gac.canonical.com>
Message-Id: <150702737842.28742.13979899847747801747.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1320360] Re: usb passthrough not working anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1320360

Title:
  usb passthrough not working anymore

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  I'm using qemu 2.0.0 with opensuse 13.1 x84_64 bit as host and window7
  as guest. Til qemu version 1.6.2 USB passthrough works perfectly, but
  starting with qemu 2.0.0 passthrough stop working. I can still add the
  usb device but when I start the guest following message appears:

  "unable to execute QEMU command 'device_add': 'usb-host' is not a
  valid device model name"

  Then the guest will not start.

  I try it with different usb devices (iphone, stick, hdd), always the
  same error.

  Are there any news / hints about this ?

  Regards

  Martin

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1320360/+subscriptions
