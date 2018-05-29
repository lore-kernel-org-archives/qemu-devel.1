Received: from eggs.gnu.org ([2001:4830:134:3::10]:37695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olgalevy91@gmail.com>) id 1fNdos-0005DI-S6
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olgalevy91@gmail.com>) id 1fNdos-00077q-2w
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:33:42 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:46399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <olgalevy91@gmail.com>)
	id 1fNdor-000777-UP
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:33:42 -0400
Received: by mail-ot0-x22e.google.com with SMTP id t1-v6so16688940ott.13
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:33:41 -0700 (PDT)
MIME-Version: 1.0
From: Olga Levy <olgalevy91@gmail.com>
Date: Tue, 29 May 2018 15:33:40 +0300
Message-ID: <CA+6CiVCSPCQ-3iBa=ivJtqsbsV2G9MxTndDFXkMBk2AgWHxPOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Live viewing qemu running image
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

Nice to meet you. I'm a new security engineer and working on a prototype
using QEMU.

What I need is to collect running image internal data (like running
processes, netstat, files modification, etc.) but without running any
process inside. I mean, doing it from "outside" (I need Qemu support).

For example,

How can I live view FS of a running image?

Efrat
