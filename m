Received: from eggs.gnu.org ([209.51.188.92]:60652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voltagex@voltagex.org>) id 1gp3IH-00050M-Ao
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voltagex@voltagex.org>) id 1gp3IF-0003kc-A2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:45:37 -0500
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <voltagex@voltagex.org>)
	id 1gp3I9-0003hq-S5
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:45:30 -0500
Received: by mail-vs1-xe2e.google.com with SMTP id v205so1164190vsc.3
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 19:45:28 -0800 (PST)
MIME-Version: 1.0
From: Adam Baxter <voltagex@voltagex.org>
Date: Thu, 31 Jan 2019 14:45:13 +1100
Message-ID: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] NSIS - including DLL dependencies for Windows
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
How do I gather and include the required DLLs (SDL, zlib etc) in the NSIS
installer? (and also in a standalone build to be zipped up, but that's less
important)

I noticed the wiki doesn't really mention bundling dependencies anywhere.

The official unofficial windows builds are documented at
https://qemu.weilnetz.de/FAQ but this doesn't cover building the actual
installer.

Regards,
Adam
