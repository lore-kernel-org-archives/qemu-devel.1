Received: from eggs.gnu.org ([2001:4830:134:3::10]:39162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dyw83-0001TH-NB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dyw7y-0001Ww-7p
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:54162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dyw7y-0001WC-1f
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dyw7w-0000TF-MZ
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 08:31:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A9C092E8059
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 08:31:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Oct 2017 08:18:59 -0000
From: Jinank Jain <601946@bugs.launchpad.net>
Reply-To: Bug 601946 <601946@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100705154408.6052.2473.malonedeb@potassium.ubuntu.com>
Message-Id: <150693233984.2038.5441030143009080275.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 601946] Re: [Feature request] qemu-img
 multi-threaded compressed image conversion
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

@~quentin.casasnovas Are you still working on this? If not then I would
like to give this a shot?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/601946

Title:
  [Feature request] qemu-img multi-threaded compressed image conversion

Status in QEMU:
  New

Bug description:
  Feature request:
  qemu-img multi-threaded compressed image conversion

  Suppose I want to convert raw image to compressed qcow2. Multi-
  threaded conversion will be much faster, because bottleneck is
  compressing data.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/601946/+subscriptions
