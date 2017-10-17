Received: from eggs.gnu.org ([2001:4830:134:3::10]:60307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4a4P-0007aK-9r
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4a4M-00047q-3j
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:10:41 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4a4L-00047W-Vu
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:10:38 -0400
Date: Tue, 17 Oct 2017 18:10:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017221034.GM1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-14-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-14-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 13/50] tcg: Export temp_idx
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

On Mon, Oct 16, 2017 at 10:25:32 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> At the same time, drop the TCGContext argument and use tcg_ctx instead.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

As I said earlier I'd combine this with the temp_arg patch.
But even without that change:

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
