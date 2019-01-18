Received: from eggs.gnu.org ([209.51.188.92]:45429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVja-0001Fb-2F
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVjY-0007kL-4O
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:07:01 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:46020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVjW-0007f1-Fq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:07:00 -0500
Received: by mail-ot1-x331.google.com with SMTP id 32so14582323ota.12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 07:06:56 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 15:06:43 +0000
Message-ID: <CAFEAcA__E99yuOGXubFsCe55aOzKHa89xA1uNsjadsJff+ka0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Proposed schedule for QEMU 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Here's my stab at a schedule for the 4.0 release:

2019-03-12: soft freeze
2019-03-19: hard freeze, tag rc0
2019-03-26: tag rc1
2019-04-02: tag rc2
2019-04-09: tag rc3
2019-04-16: release, or rc4 if needed
2019-04-23: tag rc4

Any opinions, objections, suggestions for dates to avoid?
(Easter in the UK is the weekend of the 19th-22nd but I'm
not sure it's worth trying to avoid.)

thanks
-- PMM
