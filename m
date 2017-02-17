Received: from eggs.gnu.org ([2001:4830:134:3::10]:48458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@richardpeters.de>) id 1cehde-0008Gv-Af
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@richardpeters.de>) id 1cehdZ-0008Oy-EJ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:27:50 -0500
Received: from mxf950.netcup.net ([46.38.249.80]:38588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@richardpeters.de>)
	id 1cehdZ-0008Ob-7N
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:27:45 -0500
Received: from [192.168.10.12] (unknown [141.45.120.74])
	by mxf950.netcup.net (Postfix) with ESMTPSA id E72B7202EA
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 13:27:43 +0100 (CET)
From: Richard Peters <mail@richardpeters.de>
Message-ID: <b87f8e22-1346-b1fb-90a9-572c56c36c55@richardpeters.de>
Date: Fri, 17 Feb 2017 13:27:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Interconnect two qemu (Stellaris LM3S6965EVB)
 instances via I2C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Community,

The Qemu target 'LM3S6965EVB' supports I2C.
I have two firmware versions for a LM3S6965EVB chip that i want to test
with qemu. One is the master and the other is slave.
They use I2C drivers for the LM3S6965EVB chip.

How can i connect these two instances?
I didn't found a simple solution for that in the docs or in google.
Is there a simple solution without virtio driver coding, etc?

Hope you can help me with that :-)

Thank you and regards,
Richard
