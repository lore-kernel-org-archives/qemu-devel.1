Received: from eggs.gnu.org ([208.118.235.92]:57317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gbYAe-00044J-LC
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 16:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gbYAb-0000Tg-HY
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 16:53:56 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gbYAX-0000Qf-QS
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 16:53:51 -0500
Date: Mon, 24 Dec 2018 16:53:44 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181224215344.GA21289@flamenco>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/12] tcg: Improve register allocation for
 calls
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

On Tue, Nov 27, 2018 at 21:38:22 -0800, Richard Henderson wrote:
> The intent here is to remove several move insns putting the
> function arguments into the proper place.  I'm hoping that
> this will solve the skylake regression with spec2006, as
> seen with the ool softmmu patch set.

Reviewed-by: Emilio G. Cota <cota@braap.org>

for the series.

Thanks,

		E.
