Received: from eggs.gnu.org ([2001:4830:134:3::10]:54453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEscA-00025M-3g
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsc3-0002vO-IB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:04:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEsc3-0002sq-9G
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:04:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id q6-v6so761863wrw.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 02:04:29 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-30-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d61efbd9-e182-aa85-0287-f2c7f3b7e8bb@linaro.org>
Date: Tue, 23 Oct 2018 10:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-30-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 29/29] target/riscv: Rename trans_arith
 to gen_arith
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
> ---
>  target/riscv/insn_trans/trans_rvi.inc.c | 14 +++++++-------
>  target/riscv/insn_trans/trans_rvm.inc.c | 14 +++++++-------
>  target/riscv/translate.c                |  4 ++--
>  3 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
