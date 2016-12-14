Received: from eggs.gnu.org ([2001:4830:134:3::10]:55171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1cHB6T-0006RQ-3e
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1cHB6Q-0001bf-2W
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:04:21 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:25549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1cHB6P-0001Z5-O9
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:04:18 -0500
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <1a3a7aef-55f1-11b6-b33f-621979cbb59f@profihost.ag>
Date: Wed, 14 Dec 2016 16:04:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hello,

after upgrading a cluster OS, Qemu, ... i'm experiencing slow and
volatile network speeds inside my VMs.

Currently I've no idea what causes this but it's related to the host
upgrades. Before i was running Qemu 2.6.2.

I'm using virtio for the network cards.

Greets,
Stefan
