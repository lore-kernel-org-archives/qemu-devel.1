Received: from eggs.gnu.org ([2001:4830:134:3::10]:60719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amonakov@ispras.ru>) id 1edgGP-0003uH-0g
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amonakov@ispras.ru>) id 1edgGL-0000eG-4l
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:52:09 -0500
Received: from bran.ispras.ru ([83.149.199.196]:49247 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amonakov@ispras.ru>) id 1edgGK-0000cz-Ti
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:52:05 -0500
Date: Mon, 22 Jan 2018 20:52:02 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
Message-ID: <alpine.LNX.2.20.13.1801222034370.13989@monopod.intra.ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Qemu-devel] [GSoC?] Board autoconfiguration based on DTB info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>

Hello,

Is it feasible to consume a DTB file in Qemu itself to make the board match the
DeviceTree hardware description? For example on Arm there are quite a few .dts
files in Linux tree for various boards; having a "generic" Arm board in Qemu that
could [to what degree?] emulate any of those sounds attractive in theory.

If that is technically possible, could that be a possible GSoC project idea?
I'm not a GSoC candidate, though. Hope it's not terribly off-topic.

Thanks.
Alexander
