Received: from eggs.gnu.org ([2001:4830:134:3::10]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eCwg2-00055c-Uf
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 18:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eCwg1-00060d-Vk
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 18:56:07 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:47631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eCwg1-0005zg-OF
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 18:56:05 -0500
Received: by mail-wm0-x22e.google.com with SMTP id b14so5244416wme.2
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 15:56:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4beb4e47-0ff9-8251-6502-23824779edbd@amsat.org>
References: <1510228971-6005-1-git-send-email-sundeep.lkml@gmail.com>
	<4beb4e47-0ff9-8251-6502-23824779edbd@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2017 23:55:44 +0000
Message-ID: <CAFEAcA-ATtAougvALVo=48p+jVx5B+Ejq60TD9dGYEQU2ReWCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel PATCH] MAINTAINERS: Add entries for
 Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 9 November 2017 at 21:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Hi Subbaraya,
>
> On 11/09/2017 09:02 AM, Subbaraya Sundeep wrote:
>> add voluntarily myself as maintainer for Smartfusion2
>
> You need to share your GnuPG key signed, I couldn't find it using
> http://pgp.mit.edu/pks/lookup?search=3DSubbaraya+Sundeep
>
> from https://wiki.qemu.org/Contribute/SubmitAPullRequest :

I don't in general expect to take pull requests from
everybody listed as a maintainer in the MAINTAINERS file.
That just means "I'm going to be reviewing and should
be cc'd on patches". Pull requests are sent by people
who are maintainers for a subsystem. Rule of thumb:
unless somebody asks you to send a pull request, you
don't need to do it.

thanks
-- PMM
