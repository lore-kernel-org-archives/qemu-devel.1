Received: from eggs.gnu.org ([2001:4830:134:3::10]:41211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkna4-0004IJ-2b
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkna3-0001W3-FG
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:38:08 -0400
MIME-Version: 1.0
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 1 Aug 2018 11:38:05 +0200
Message-ID: <CABoDooMm7+REK+8dbTA1zj2mV-OiiA0w2ib8B7b-1WwVny82PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ARM: SVE movprfx issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Hello Richard,

there's a typo in sve_movz_d where n[1] is used instead of n[i].

Thanks,

Laurent
