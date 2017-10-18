Received: from eggs.gnu.org ([2001:4830:134:3::10]:39310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4fjl-0007ku-EL
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4fji-0003k3-0k
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:13:45 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4fjh-0003jk-SC
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:13:41 -0400
Date: Wed, 18 Oct 2017 00:13:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171018041340.GB13959@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-22-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-22-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 21/50] tcg: Use pointers in TCGOp->args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Oct 16, 2017 at 10:25:40 -0700, Richard Henderson wrote:
> This limits the indexing into tcg_ctx.temps to initial
> opcode generation time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
