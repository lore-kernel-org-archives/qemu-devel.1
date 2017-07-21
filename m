Received: from eggs.gnu.org ([2001:4830:134:3::10]:55102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYgkJ-00080B-Mg
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYgkG-0003Jh-KV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:50:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYgkG-0003Jd-G2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:50:04 -0400
Date: Fri, 21 Jul 2017 18:50:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721225002.GM10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-30-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170715094243.28371-30-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 29/34] target/arm: [tcg,
 a64] Port to disas_log
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

On Fri, Jul 14, 2017 at 23:42:38 -1000, Richard Henderson wrote:
> From: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Message-Id: <150002606914.22386.15524101311003685068.stgit@frigg.lan>
> [rth: Move tb->size computation and use that result.]
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
