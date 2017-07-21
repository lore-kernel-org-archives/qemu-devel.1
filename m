Received: from eggs.gnu.org ([2001:4830:134:3::10]:41495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYfQX-00027H-E6
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYfQU-0005EF-9p
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:25:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYfQU-0005E5-0X
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:25:34 -0400
Date: Fri, 21 Jul 2017 17:25:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721212532.GA10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-3-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-3-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 02/34] tcg: Add generic DISAS_NORETURN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:11 -1000, Richard Henderson wrote:
> This will allow some amount of cleanup to happen before
> switching the backends over to enum DisasJumpType.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
