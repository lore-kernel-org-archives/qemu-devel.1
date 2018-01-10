Received: from eggs.gnu.org ([2001:4830:134:3::10]:53562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZGI2-0003BE-9L
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZGI1-0003Eh-FJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:19:34 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:44363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZGI1-0003EC-9P
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:19:33 -0500
Received: by mail-ot0-x235.google.com with SMTP id g59so14231806otg.11
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 05:19:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <db3a640f-3c96-1250-74fe-b1d9871ac6d9@redhat.com>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
	<CABdb736PM6C4LTxg_-NdcWkcc6v1MxpMkp+2fmnxVBXf77picw@mail.gmail.com>
	<000801d37b27$bd7e7a40$387b6ec0$@ru>
	<9d5385b9-af8d-38ac-a4b6-376092badc17@redhat.com>
	<001501d389ee$9c4c1550$d4e43ff0$@ru>
	<db3a640f-3c96-1250-74fe-b1d9871ac6d9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jan 2018 13:19:11 +0000
Message-ID: <CAFEAcA-+GMmsdz-_hSNqAYV5tL5jvr7LEr1pVBoYWAFNotFPsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 00/46] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Ladi Prosek <lprosek@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Mihail Abakumov <mikhail.abakumov@ispras.ru>

On 10 January 2018 at 13:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 10/01/2018 09:40, Pavel Dovgalyuk wrote:
>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>> On 22/12/2017 14:21, Pavel Dovgalyuk wrote:
>>>> Paolo, Ladi finished the review.
>>>> What about merging these into upstream?
>>> Sure, in the new year though.
>> Now?
>
> Ok, will do.

I notice patchew complained about some source file
permissions -- can you make sure those are fixed up?

thanks
-- PMM
