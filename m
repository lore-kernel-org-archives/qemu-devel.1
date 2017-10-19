Received: from eggs.gnu.org ([2001:4830:134:3::10]:45565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5D0k-0003DL-CS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5D0j-0004mM-JL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:45:30 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:47400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5D0j-0004m3-CX
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:45:29 -0400
Received: by mail-wr0-x22d.google.com with SMTP id y39so8800126wrd.4
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:45:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019151249.13663-3-clg@kaod.org>
References: <20171019151249.13663-1-clg@kaod.org>
	<20171019151249.13663-3-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 16:45:07 +0100
Message-ID: <CAFEAcA-thMBh7OQH_RwXFv7H-oanqJoObRjuotXDeX9qCOThgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/8] aspeed: remove
 ignore_memory_transaction_failures all boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 October 2017 at 16:12, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Now that we have a dummy ROM device catching the invalid writes, we
> can remove this flag and work on fixing the current firwmares still
> accessing unimplemented addresses.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
