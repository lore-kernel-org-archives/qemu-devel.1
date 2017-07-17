Received: from eggs.gnu.org ([2001:4830:134:3::10]:48751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXEwp-0004U7-CU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXEwm-0004ob-AG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:57:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXEwm-0004mm-2z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:57:00 -0400
Date: Mon, 17 Jul 2017 18:56:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170717225657.GA30851@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170715094243.28371-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 01/34] Pass generic CPUState to
 gen_intermediate_code()
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

On Fri, Jul 14, 2017 at 23:42:10 -1000, Richard Henderson wrote:
> From: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> Needed to implement a target-agnostic gen_intermediate_code() in the
> future.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Reviewed-by: Alex Benneé <alex.benee@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
