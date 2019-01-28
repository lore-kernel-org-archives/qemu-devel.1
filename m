Received: from eggs.gnu.org ([209.51.188.92]:33358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go7Ke-0007GS-T3
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go7Kd-0000eM-O8
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:52:12 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go7Kd-0000c0-Gc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:52:11 -0500
Received: by mail-ot1-x343.google.com with SMTP id g16so10626329otg.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 05:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20190122145132.12571-1-paul.durrant@citrix.com>
	<57cd3429-41a3-48c5-4d06-5d203cf70f97@redhat.com>
In-Reply-To: <57cd3429-41a3-48c5-4d06-5d203cf70f97@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 13:51:57 +0000
Message-ID: <CAFEAcA9Ne8=buW5FGr8AbuTdovrdAdFcZJG01N_zkQGrXJ85FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/block: clean up stake xen_disk trace
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Paul Durrant <paul.durrant@citrix.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Mon, 28 Jan 2019 at 13:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Cc'ing QEMU Trivial.
>
> On 1/22/19 3:51 PM, Paul Durrant wrote:
> > This should have been removed then xen_disk.c was removed but I missed =
them.
>
> ... when xen_disk.c was removed (19f87870baa) ...

also s/stake/stale/ in the subject line I guess ?

thanks
-- PMM
