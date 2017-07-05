Received: from eggs.gnu.org ([2001:4830:134:3::10]:37708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dSfdg-0001fS-FT
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dSfdd-00023q-Al
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:26:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dSfdc-00022Q-W2
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:26:21 -0400
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <84bf1844-8d5c-2a71-c1cc-8f8c74511fca@vivier.eu>
Date: Wed, 5 Jul 2017 10:25:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] trigonometric functions in softfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Cc: Thomas Huth <huth@tuxfamily.org>

Hi,

Thomas has pointed out that WinUAE[1] has an updated softfloat library
implementing missing operations for 680x0.

Do you think these changes can be merged in QEMU?

Thanks,
Laurent

[1] https://github.com/tonioni/WinUAE/tree/master/softfloat
