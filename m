Received: from eggs.gnu.org ([2001:4830:134:3::10]:43710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fToeQ-0006HV-2T
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fToeM-0005Q3-SM
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:20:26 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fToeM-0005Pc-Eb
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:20:22 -0400
Date: Fri, 15 Jun 2018 09:20:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180615132018.GA9752@flamenco>
References: <20180614233935.26585-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180614233935.26585-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] hw/isa/smc37c669: Change the parallel I/O
 base to 378H
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org

On Thu, Jun 14, 2018 at 20:39:35 -0300, Philippe Mathieu-Daudé wrote:
> As there is no particular reason to use this base address
> (introduced in 7bea0dd434e), change to 378H which is the
> default on PC machines.

Tested-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio
