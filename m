Received: from eggs.gnu.org ([2001:4830:134:3::10]:45169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRpf-0003OE-Np
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRpf-0006ue-08
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:34:55 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dc7e0220-ee8a-8ab0-05de-572e34d4d78b@redhat.com>
Date: Fri, 22 Jun 2018 21:34:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/14] hw/dma/omap_dma: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/dma/omap_dma.c | 64 +++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 24 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
