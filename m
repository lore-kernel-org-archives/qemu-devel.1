Received: from eggs.gnu.org ([2001:4830:134:3::10]:55909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQV0-0003pK-69
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQUz-00046N-9L
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:08:18 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:49893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvQUz-00045m-3J
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:08:17 -0400
Received: by mail-wm0-x233.google.com with SMTP id r74so5281328wme.4
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:08:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-3-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 17:07:55 +0100
Message-ID: <CAFEAcA8oovA56LwFtKoY1c-P93zxGoyH+vKAXF+hAK6r9bHxvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/34] hw: remove "qemu/osdep.h" from
 header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Corey Minyard <minyard@acm.org>, Balaton Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 22 September 2017 at 16:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> while here, add entries for ppc4xx_i2c in MAINTAINERS
>
> applied using ./scripts/clean-includes
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

This is doing two things at once and would ideally be
two patches. Still,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
