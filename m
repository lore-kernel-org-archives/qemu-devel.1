Received: from eggs.gnu.org ([209.51.188.92]:48110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gl2Do-0004Hw-Cz
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gl2Dm-0004lH-Sr
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:48:24 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:45423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gl2Dm-0004k2-JD
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:48:22 -0500
Received: by mail-pl1-x635.google.com with SMTP id a14so8055228plm.12
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 17:48:22 -0800 (PST)
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-29-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1dc9690d-608c-c251-531a-22eb5c5e6538@linaro.org>
Date: Sun, 20 Jan 2019 12:48:14 +1100
MIME-Version: 1.0
In-Reply-To: <20190118131456.32451-29-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 28/35] target/riscv: Rename trans_arith
 to gen_arith
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org

On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
> v3 -> v4:
>     - trans_sltu/slt added to conversion
> 
>  target/riscv/insn_trans/trans_rvi.inc.c | 18 +++++++++---------
>  target/riscv/insn_trans/trans_rvm.inc.c | 14 +++++++-------
>  target/riscv/translate.c                |  4 ++--
>  3 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
