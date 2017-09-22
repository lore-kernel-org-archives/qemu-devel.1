Received: from eggs.gnu.org ([2001:4830:134:3::10]:51982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abhijit.ray.chaudhury@gmail.com>) id 1dvHaV-0000dv-MU
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abhijit.ray.chaudhury@gmail.com>) id 1dvHaU-0008EK-Vr
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:37:23 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:57150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <abhijit.ray.chaudhury@gmail.com>)
	id 1dvHaU-0008Dh-R7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:37:22 -0400
Received: by mail-io0-x232.google.com with SMTP id m103so907430iod.13
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 23:37:21 -0700 (PDT)
MIME-Version: 1.0
From: Abhijit Ray Chaudhury <abhijit.ray.chaudhury@gmail.com>
Date: Fri, 22 Sep 2017 12:07:19 +0530
Message-ID: <CAACKNgVXcODpG_0Q_dQoCkjhPJt8ym_ngGH7e38682KaKEoo3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qEMU exposing cp15 registers over gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

Can qEmu expose cp15 register set over gdb interface ? Any idea what
changes are required to qemu to support this ?

I can see cp14 registerset is exposed via neon (vfp) xml file but not cp15.

Thanks in advance,

-Abhijit
