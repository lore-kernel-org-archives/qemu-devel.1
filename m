Received: from eggs.gnu.org ([2001:4830:134:3::10]:54374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDUFq-0001mK-7t
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDUFp-0007gE-ER
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:19:34 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:34916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDUFp-0007g1-9x
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:19:33 -0400
Received: by mail-ot0-x22b.google.com with SMTP id h8-v6so12739944otb.2
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 05:19:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525176522-200354-5-git-send-email-imammedo@redhat.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
	<1525176522-200354-5-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 May 2018 13:19:12 +0100
Message-ID: <CAFEAcA8iq9gJuC=ODK7wY_3m4B66o0LqJi9aK2PEfHha4q68nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] arm: boot: set boot_info starting
 from first_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 1 May 2018 at 13:08, Igor Mammedov <imammedo@redhat.com> wrote:
> even though nothing is currently broken, make sure that boot_info
> is set on all CPUs.
>
> Ref:
> "Message-ID: <CAFEAcA_NMWuA8WSs3cNeY6xX1kerO_uAcN_3=fK02BEhHJW86g@mail.gmail.com>"

Can you include the rationale in the commit message rather
than just pointing to a message-id, please?

>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> --

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
