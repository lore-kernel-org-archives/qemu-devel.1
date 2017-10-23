Received: from eggs.gnu.org ([2001:4830:134:3::10]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gEj-0005Q7-4s
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gEe-0008Re-8t
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:10:01 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e6gEd-0008Pv-VW
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:09:56 -0400
Date: Mon, 23 Oct 2017 13:09:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171023170954.GA6901@flamenco>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020232023.15010-9-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v7 08/52] tcg: Introduce temp_arg,
 export temp_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On Fri, Oct 20, 2017 at 16:19:39 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> At the same time, adrop the TCGContext argument and use tcg_ctx instead.

s/adrop/drop/ :P

		Emilio
