Received: from eggs.gnu.org ([2001:4830:134:3::10]:42299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzDY-0002pA-E8
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzDR-0005sn-AM
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:44:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHzDN-0005qC-4q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:43:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id a8-v6so15898857wmf.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:43:51 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-33-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07ac484f-9455-fa1e-b86a-ee127d6a1d11@linaro.org>
Date: Wed, 31 Oct 2018 22:43:47 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-33-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 32/35] target/riscv: Convert @cl_d, @cl_w,
 @cs_d, @cs_w insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/insn16.decode              | 20 ++++++++++----------
>  target/riscv/insn32.decode              |  3 ++-
>  target/riscv/insn_trans/trans_rvc.inc.c | 24 ------------------------
>  3 files changed, 12 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
