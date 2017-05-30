Received: from eggs.gnu.org ([2001:4830:134:3::10]:53921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <everplays@gmail.com>) id 1dFaY8-0000Ui-2y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <everplays@gmail.com>) id 1dFaY7-00019P-AN
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:22:36 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <everplays@gmail.com>) id 1dFaY7-00019F-2c
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:22:35 -0400
Received: by mail-wm0-x232.google.com with SMTP id e127so84623145wmg.1
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 23:22:34 -0700 (PDT)
MIME-Version: 1.0
From: Behrooz Shabani <everplays@gmail.com>
Date: Tue, 30 May 2017 08:22:32 +0200
Message-ID: <CAKD7DEGotyMPcyptOkfJjJ9fPKqySWLdt20SZDZ16ZHzzovNYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] sharing directories with Windows guest - virtio pci p9
 on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I was wondering if anyone has information regarding Windows driver of
virtio pci p9.

Our users can have multiple VM instances running and providing some sort of
shared storage between different VMs would be very useful for them.

I know that the alternate is to use SMB but because of networking
constraints, we can't use it.

Any information on how to have a shared storage between different running
VMs that would not require `-net user` is very much appreciated as well.

-- 
regards,
behrooz
