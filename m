Received: from eggs.gnu.org ([2001:4830:134:3::10]:32782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqdbJ-0006jT-6m
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqdbI-0002QZ-KY
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:11:33 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:42321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqdbI-0002Pe-FM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:11:32 -0400
Received: by mail-oi0-x235.google.com with SMTP id b16-v6so13575096oic.9
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 05:11:32 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 13:11:10 +0100
Message-ID: <CAFEAcA8Ge7Gfn==qryFi3=E7xsC1tBgsZXK8-m=aFXDFU7Lh8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] what should we do to make it easier for new
 contributors to get started on QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Julia Suvorova <jusual@mail.ru>, Emanuele Giuseppe Esposito <emanuele.giuseppe.esposito@usi.ch>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>

Hi; this is something of a survey question. I'm particularly
interested in answers from people who've recently had to go through
the process of getting up to speed with working on QEMU, so
I've cc'd our current Outreachy and GSoC students, but input
from anybody is welcome.

* If we did one thing to make it easier for new contributors to get
  started, what should it be?

Very wide focus -- could be anything, better documentation, better
processes, test infrastructure, code changes, whatever.
Some possible things I've thought of:
  * better documentation of top-level qemu internals, like a
    source layout roadmap?
  * specific "missing pieces" that trip people up (eg not having
    a good intro to how to write QOM/qdev devices)?
  * better curation of 'bite sized tasks' list?
But I've been working on QEMU for years, so my impressions could
well be wrong. I'm hoping we can come up with a top 2 or 3 things
to work on improving/fixing, to try to make a difference for future
new contributors...

thanks in advance
-- PMM
