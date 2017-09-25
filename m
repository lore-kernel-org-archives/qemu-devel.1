Received: from eggs.gnu.org ([2001:4830:134:3::10]:44551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwM4j-0006sn-I4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwM4i-0005MQ-Sq
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:37:01 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-9-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <caa7c8e1-586d-9d78-a69e-7e32ed2ab9fb@redhat.com>
Date: Mon, 25 Sep 2017 07:36:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 31/34] hw/net/rtl8139: use TYPE_PCI_RTL8139
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Magnus Damm <magnus.damm@gmail.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org

On 22.09.2017 18:01, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/net/pci.h    | 1 +
>  hw/arm/realview.c       | 3 ++-
>  hw/arm/versatilepb.c    | 3 ++-
>  hw/mips/mips_fulong2e.c | 3 ++-
>  hw/net/rtl8139.c        | 7 +++----
>  hw/sh4/r2d.c            | 5 +++--
>  6 files changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
