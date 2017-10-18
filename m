Received: from eggs.gnu.org ([2001:4830:134:3::10]:46015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4g0d-0004au-Th
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4g0a-0000CI-Qd
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:31:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4g0a-0000BY-Ia
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:31:08 -0400
Date: Wed, 18 Oct 2017 00:31:06 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171018043106.GD13959@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-26-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-26-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 25/50] tcg: Include CF_COUNT_MASK in
 CF_HASH_MASK
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

On Mon, Oct 16, 2017 at 10:25:44 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Does this patch work with icount for you? On my end, aarch64
stops booting with -icount 1.

		E.
