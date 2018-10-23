Received: from eggs.gnu.org ([2001:4830:134:3::10]:34101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEs43-0001O6-Vk
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gErwX-0000RL-VB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:21:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gErwX-0000HW-Lr
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:21:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id w186-v6so789257wmf.0
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 01:21:29 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-14-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b2ad23c1-807d-c2bf-4a52-1eb2208914d6@linaro.org>
Date: Tue, 23 Oct 2018 09:21:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-14-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/29] target/riscv: Convert RV32D insns
 to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v1 -> v2:
>     - Add REQUIRE_FPU to arithm helpers

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
