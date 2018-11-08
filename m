Received: from eggs.gnu.org ([2001:4830:134:3::10]:46917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gKgH2-0003Ja-RG
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gKgH2-0000Uc-4i
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:06:48 -0500
Date: Thu, 8 Nov 2018 10:06:16 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181108090616.txip6wi3sfwcigvs@kamzik.brq.redhat.com>
References: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
	<1540663650-106694-4-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1540663650-106694-4-git-send-email-peng.hao2@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V5 3/5] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Peng,

On Sun, Oct 28, 2018 at 02:07:28AM +0800, Peng Hao wrote:

[missing commit message]

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/misc/pvpanic.c         | 81 +++++++++++++++++++++++++++++++++++++--=
--------
>  include/hw/misc/pvpanic.h |  1 +
>  2 files changed, 65 insertions(+), 17 deletions(-)

This patch should also include an update to docs/specs/pvpanic.txt

Thanks,
drew
