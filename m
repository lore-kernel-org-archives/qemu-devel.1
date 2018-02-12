Received: from eggs.gnu.org ([2001:4830:134:3::10]:35506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1elMoV-0004md-7F
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1elMoR-0005Q5-9o
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:43:07 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1elMoR-0005Os-5S
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:43:03 -0500
Date: Mon, 12 Feb 2018 17:43:00 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180212224229.GA17948@flamenco>
References: <20180211203934.15546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211203934.15546-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tcg: Improve tcg_gen_muli_i32/i64
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

On Sun, Feb 11, 2018 at 12:39:34 -0800, Richard Henderson wrote:
> Convert multiplication by power of two to left shift.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio
