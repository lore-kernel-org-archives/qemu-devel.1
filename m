Received: from eggs.gnu.org ([2001:4830:134:3::10]:41781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYfRz-0002z4-6U
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYfRy-0005pu-Bl
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:27:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYfRy-0005po-7G
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:27:06 -0400
Date: Fri, 21 Jul 2017 17:27:05 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721212705.GD10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-7-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-7-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 06/34] target/arm: Delay check for
 magic kernel page
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

On Fri, Jul 14, 2017 at 23:42:15 -1000, Richard Henderson wrote:
> There's nothing magic about the exception that we generate in order
> to execute the magic kernel page.  We can and should allow gdb to
> set a breakpoint at this location.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
