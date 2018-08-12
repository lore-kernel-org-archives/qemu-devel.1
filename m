Received: from [2001:4830:134:3::10] (port=48253 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fotw5-0001St-US
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fotvk-0003dF-NM
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:13:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1fotvk-0003cw-FI
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:13:28 -0400
Received: by mail-pf1-x443.google.com with SMTP id a26-v6so6638674pfo.4
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 10:13:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e611169-d11d-8597-6646-5dc6915e9ac9@roeck-us.net>
Date: Sun, 12 Aug 2018 10:13:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Booting linux with ppc 40p machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Hi all,

I have been trying to boot linux on the 40p machine with qemu-system-ppc
for quite some time, with no success. I have managed to get into the BIOS,
but not further than that.

Assuming it is in possible to boot Linux on the 40p machine, is there a
qemu command line (and Linux kernel configuration) that is known to work ?

Thanks,
Guenter
