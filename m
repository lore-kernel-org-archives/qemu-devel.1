Received: from eggs.gnu.org ([2001:4830:134:3::10]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqiH5-0004ow-28
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqiH0-0000qt-At
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:10:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqiH0-0000ql-6l
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:10:54 -0400
Date: Fri, 17 Aug 2018 13:10:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180817171052.GD7067@flamenco>
References: <20180816025452.21358-1-richard.henderson@linaro.org>
	<20180816025452.21358-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816025452.21358-5-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 4/5] target/arm: Convert to HAVE_CMPXCHG128
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

On Wed, Aug 15, 2018 at 19:54:51 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c | 259 +++++++++++++++++++++-------------------
>  1 file changed, 133 insertions(+), 126 deletions(-)

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
