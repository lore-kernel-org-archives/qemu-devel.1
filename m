Received: from eggs.gnu.org ([2001:4830:134:3::10]:50636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAejU-00018n-Bc
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAejQ-00013h-9k
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:54:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fAejQ-00012Z-3a
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:54:24 -0400
Date: Mon, 23 Apr 2018 12:54:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180423165421.GA3992@flamenco>
References: <1524250517-28032-1-git-send-email-cota@braap.org>
	<1524250517-28032-8-git-send-email-cota@braap.org>
	<95862bc8-ef04-2755-60ca-3ba0e2ac9fd9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95862bc8-ef04-2755-60ca-3ba0e2ac9fd9@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 07/18] target/mips: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On Sun, Apr 22, 2018 at 09:52:02 -1000, Richard Henderson wrote:
(snip)
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I incorporated these changes, plus this and the remaining R-b tags,
to an updated branch available here:
  https://github.com/cota/qemu/tree/trloop-conv-v3b

All patches have R-b's now, so this is finally getting merge-ready.

Note that the above branch contains the next_page_overflow-r-b branch,
since it depends on it.

Thanks,

		Emilio
