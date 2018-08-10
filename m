Received: from eggs.gnu.org ([2001:4830:134:3::10]:33676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1foBOA-0004Ks-KD
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1foBO6-0001Qk-Mz
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:39:50 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1foBO6-0001PX-2R
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:39:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 10 Aug 2018 13:39:38 -0400
Message-Id: <20180810173941.5301-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 0/3] target/riscv: use
 tcg_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Changes wrt v1: changed patch 3 as suggested by Richard. Also
added his R-b's.

You can fetch this series from:
  https://github.com/cota/qemu/tree/riscv-lookup_ptr-v2

Thanks,

		Emilio
