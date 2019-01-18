Received: from eggs.gnu.org ([209.51.188.92]:52215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkW6W-0005BG-TC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkW6T-00087Y-M7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:30:44 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gkW6T-000865-65
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:30:41 -0500
Date: Fri, 18 Jan 2019 10:30:39 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190118153039.GA10734@flamenco>
References: <20190116170114.26802-1-cota@braap.org>
	<20190116170114.26802-4-cota@braap.org> <87y37ixb09.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y37ixb09.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v7 3/3] tcg/i386: enable dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Fri, Jan 18, 2019 at 15:04:38 +0000, Alex Bennée wrote:
(snip)
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

> Do you have access to any aarch64 hardware? It would be nice to see if
> we could support it there as well.

I don't have time to implement this for the aarch64 backend,
but if you (or anyone else) want to do it, I can run benchmarks --
I do have access to an aarch64 host, and also have spec06 compiled
for aarch64.

		E.
