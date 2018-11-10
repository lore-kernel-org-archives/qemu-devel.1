Received: from eggs.gnu.org ([2001:4830:134:3::10]:58133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLaZI-0005lB-NQ
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLaZD-00028G-KP
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:13:24 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLaZD-000277-Cu
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:13:19 -0500
Received: by mail-wr1-x42e.google.com with SMTP id z13-v6so5398326wrs.3
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 13:13:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 10 Nov 2018 22:13:11 +0100
Message-Id: <20181110211313.6922-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4 0/2] decodetree: Support multiple
 inclusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi Richard, I noticed this issue when using decodetree with multiple ISAs.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  MAINTAINERS: Add scripts/decodetree.py to the TCG section
  decodetree: Add multiple include guard

 MAINTAINERS           | 1 +
 scripts/decodetree.py | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.19.1
