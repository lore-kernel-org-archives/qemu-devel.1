Received: from eggs.gnu.org ([2001:4830:134:3::10]:34246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cajum.bugs@yandex.com>) id 1cu1AP-0002pV-92
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cajum.bugs@yandex.com>) id 1cu1AJ-0003R5-VQ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:20:57 -0400
Received: from forward22h.cmail.yandex.net ([87.250.230.53]:48635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cajum.bugs@yandex.com>)
	id 1cu1AJ-0003PY-KO
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:20:51 -0400
Message-ID: <1490984431.18559.2.camel@yandex.com>
From: Mihai-Drosi Caju <cajum.bugs@yandex.com>
Date: Fri, 31 Mar 2017 21:20:31 +0300
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Project idea
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com

Good day,
I'd be interested in submitting the following ideas:
I'd like to enchance qemu's debugging capabilities.
I was thinking to add an option to qemu to disable cpu reset on
tripple-fault.
Or adding support for breakpoints in the GDB stub while using kvm or
another accelerator.
Or emulating a JTAG port on a pty that would interface with the virtual
CPU.
