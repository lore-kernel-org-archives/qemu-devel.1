Received: from eggs.gnu.org ([2001:4830:134:3::10]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjTr-0000TK-0k
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjTm-0005Z9-7i
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:08:14 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQjTm-0005Yz-3h
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:08:10 -0400
Date: Thu, 29 Jun 2017 20:08:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170630000809.GH13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865413649.17063.7416035795116708956.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865413649.17063.7416035795116708956.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 08/29] target/i386: [tcg] Refactor
 insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Jun 28, 2017 at 15:48:56 +0300, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
