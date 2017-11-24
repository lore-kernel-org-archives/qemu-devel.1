Received: from eggs.gnu.org ([2001:4830:134:3::10]:50879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIAxY-0006JK-5m
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIAxU-0004hd-4b
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:11:48 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:33012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIAxU-0004gn-0o
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:11:44 -0500
Received: by mail-ot0-x231.google.com with SMTP id s12so18387806otc.0
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 02:11:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511516626-21178-1-git-send-email-eric.auger@redhat.com>
References: <1511516626-21178-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 10:11:23 +0000
Message-ID: <CAFEAcA-Fjpg+KC4eUzupLFf7fAco2GDmZG8nWNqSARnn9vypxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.11] hw/arm/virt: Add 2.11 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

On 24 November 2017 at 09:43, Eric Auger <eric.auger@redhat.com> wrote:
> Add virt-2.11 machine type.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---

Argh, did we forget this again? I think we should just
make a rule that we have to bump all the versioned machine
types when the dev tree reopens...I wonder if there's a
way to catch this automatically?

thanks
-- PMM
