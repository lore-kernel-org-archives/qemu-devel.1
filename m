Received: from eggs.gnu.org ([2001:4830:134:3::10]:34710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqiPy-0006SJ-DJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqiPu-0005Ro-7z
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:20:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqiPu-0005RM-28
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:20:06 -0400
Date: Fri, 17 Aug 2018 13:20:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180817172003.GE7067@flamenco>
References: <20180816025452.21358-1-richard.henderson@linaro.org>
	<20180816025452.21358-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816025452.21358-6-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 5/5] target/ppc: Convert to HAVE_CMPXCHG128
 and HAVE_ATOMIC128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Wed, Aug 15, 2018 at 19:54:52 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/helper.h     |   2 +-
>  target/ppc/mem_helper.c |  33 ++++++++++--
>  target/ppc/translate.c  | 115 +++++++++++++++++++++-------------------
>  3 files changed, 88 insertions(+), 62 deletions(-)

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
