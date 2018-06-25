Received: from eggs.gnu.org ([2001:4830:134:3::10]:56790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXSYT-0005Kf-GM
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXSYS-0004J4-QF
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:33:21 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:46837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXSYS-0004Iy-Kl
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:33:20 -0400
Received: by mail-ot0-x244.google.com with SMTP id v24-v6so15256822otk.13
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 07:33:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625140055.32223-1-joel@jms.id.au>
References: <20180625140055.32223-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 15:32:59 +0100
Message-ID: <CAFEAcA8yOj6bDE0Lb6F_jmTfk_JaCZojCHTdHD8HqLAGZkh2Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] MAINTAINERS: Add ASPEED BMCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 25 June 2018 at 15:00, Joel Stanley <joel@jms.id.au> wrote:
> This adds Cedric as the maintainer, with Andrew and I as reviewers, for
> the ASPEED boards and the peripherals we have developed.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> --
> v2: fix includes path

Applied to target-arm.next, thanks.

PS: that should be '---' above, to avoid the notes below
it going into the commit message.

thanks
-- PMM
