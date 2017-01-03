Received: from eggs.gnu.org ([2001:4830:134:3::10]:48407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bkaladagi@cs.stonybrook.edu>) id 1cOLU4-00054X-UQ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bkaladagi@cs.stonybrook.edu>) id 1cOLU3-00006x-Ti
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:34:20 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:36473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bkaladagi@cs.stonybrook.edu>)
	id 1cOLU3-0008WI-Nn
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:34:19 -0500
Received: by mail-ua0-x233.google.com with SMTP id 88so312601113uaq.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 01:34:17 -0800 (PST)
MIME-Version: 1.0
From: Basavaraj Kaladagi <bkaladagi@cs.stonybrook.edu>
Date: Tue, 3 Jan 2017 04:34:16 -0500
Message-ID: <CAFUPq8EPqTZ4VoFbX0-TJ+0i4y5ZME1htcetxyP986eY3G2Fxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Need help - new PCIe device file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi All,

As part of my research work, I have developed a new PCIe device that can be
used in experiments on PCIe connected hardware accelerators.

Currently I have kept the device file in hw/misc.The device interacts with
a host program,
and I have written a sample program which will give an example as to how to
interact with the device.

I was not sure where to keep this sample code file, in case I want to
submit a patch to QEMU.

I have seen that ivshmem has some example code in contrib directory
(ivshmem-client/ivshmem-server), please let me know if it is the correct
place to keep sample code.

Thank you,
Basu
