Received: from eggs.gnu.org ([2001:4830:134:3::10]:45099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwM8L-0000GM-KM
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwM8H-00073g-MK
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:40:45 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-12-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27718a16-6d55-ed2e-3c65-1dbab106bd11@redhat.com>
Date: Mon, 25 Sep 2017 07:40:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 34/34] misc: drop old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 22.09.2017 18:01, Philippe Mathieu-Daud=C3=A9 wrote:
> while here, add an entry for wdt_ib700 in MAINTAINERS
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/char/debugcon.c      | 1 -
>  hw/intc/lm32_pic.c      | 1 -
>  hw/moxie/moxiesim.c     | 1 -
>  hw/sparc/sun4m.c        | 1 -
>  hw/watchdog/wdt_ib700.c | 1 -
>  MAINTAINERS             | 1 +
>  6 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
