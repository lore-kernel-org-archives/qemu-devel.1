Received: from eggs.gnu.org ([2001:4830:134:3::10]:57424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNdJe-00056l-Qt
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNdJV-00021M-C0
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:01:26 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNdJU-00020O-Uu
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:01:17 -0400
Received: by mail-oi0-x243.google.com with SMTP id t27-v6so12774993oij.9
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:01:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522104000.9044-1-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 13:00:55 +0100
Message-ID: <CAFEAcA8k5EuaSTJtMPnjpZLZXKHEcoutJ2nahAVyOuapHxTLNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] Make the next release be 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 22 May 2018 at 11:39, Peter Maydell <peter.maydell@linaro.org> wrote:
> I think that we should number the next release 3.0
> (3.0.0, in long form). We already have a few places that
> have used "2.13", in machine-versions or in "feature
> exists since release X" annotations; update those.
>
> thanks
> -- PMM
>
> Peter Maydell (5):
>   qapi: Change "since 2.13" annotations to "since 3.0"
>   hw/i386: Rename 2.13 machine types to 3.0
>   hw/s390x: Rename 2.13 machines to 3.0
>   ppc: Rename 2.13 machines to 3.0
>   qemu-doc.texi: Rename references to 2.13 to 3.0

Applied to master; thanks.

-- PMM
