Received: from eggs.gnu.org ([2001:4830:134:3::10]:33022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4YyD-0004Ze-Ue
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4Yy9-0001ly-NY
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:00:13 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4Yy9-0001ld-JQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:00:09 -0400
Date: Tue, 17 Oct 2017 17:00:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017210008.GH1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-9-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 08/50] tcg: Introduce temp_arg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Oct 16, 2017 at 10:25:27 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

I'd consider combining this patch with the "Export temp_idx" one.

		E.
