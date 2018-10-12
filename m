Received: from eggs.gnu.org ([2001:4830:134:3::10]:54131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB26f-0005X2-Lb
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB26c-0006Pn-Fg
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:24:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gB26c-0006PM-8r
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:24:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id 78-v6so4219348pfq.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 11:24:10 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1e2858da-02c6-177b-0340-39d02ef9f75b@linaro.org>
Date: Fri, 12 Oct 2018 11:24:05 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/28] target/riscv: Convert RVXI
 load/store insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
> +}
> +static bool trans_lh(DisasContext *ctx, arg_lh *a, uint32_t insn)

Watch your spacing.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
