Received: from eggs.gnu.org ([2001:4830:134:3::10]:36698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXqFm-0005B3-UP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXqFm-0001YU-5e
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:51:39 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXqFl-0001Y6-V7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:51:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id c2-v6so4801146oic.1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:51:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180624040609.17572-1-f4bug@amsat.org>
References: <20180624040609.17572-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 16:51:16 +0100
Message-ID: <CAFEAcA96og6eWt2EpmfAnYWGDhouGV8MrDVQ4ADzWv9xC2=_Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/16] hw/arm: use qemu_log_mask instead
 of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 24 June 2018 at 05:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi,
>
> This series is another collection of trivial patches from
> different stagnating branches, OMAP and Stellaris. Time to
> share before loosing them.



Applied to target-arm.next, thanks.

-- PMM
