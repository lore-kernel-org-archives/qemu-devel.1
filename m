Received: from eggs.gnu.org ([2001:4830:134:3::10]:42594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQY2C-00063y-Qs
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQY2C-0005yT-3R
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:54:56 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQY2B-0005xn-Uz
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:54:56 -0400
Received: by mail-it0-x243.google.com with SMTP id 188so785928itx.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 04:54:54 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170629103936.GD1598@perard.uk.xensource.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-4-f4bug@amsat.org>
	<20170629103936.GD1598@perard.uk.xensource.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 29 Jun 2017 08:54:53 -0300
Message-ID: <CAAdtpL786Y2gLKKBmr2_-woYjJmAQfNNJhPPz9-LDoxTJm4S7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/8] MAINTAINERS: update Xen entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Xu <anthony.xu@intel.com>

On Thu, Jun 29, 2017 at 7:39 AM, Anthony PERARD
<anthony.perard@citrix.com> wrote:
> On Wed, Jun 28, 2017 at 10:02:55PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> moved in 56e2cd24..28b99f47 to accel/
>
> That is not accurate, files have been moved to hw/i386/xen/ as written
> in both commits messages.

Oops hopefully you noticed! I copied the commits ranges from patch 1
and forgot to update the paths which are actually hw/xen and
hw/i386/xen.

> Beside that:
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thank you.
