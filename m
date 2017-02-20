Received: from eggs.gnu.org ([2001:4830:134:3::10]:56347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfpIb-000786-93
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfpIY-0006GQ-Jq
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:50:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cfpIY-0006GL-6G
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:50:42 -0500
Date: Mon, 20 Feb 2017 15:50:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170220155038.35b08edf@nial.brq.redhat.com>
In-Reply-To: <e35ffaa91eac609e1caa88b91ad6a930516d5451.1487286467.git.ben@skyportsystems.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<e35ffaa91eac609e1caa88b91ad6a930516d5451.1487286467.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 8/8] MAINTAINERS: Add VM Generation ID
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com

On Thu, 16 Feb 2017 15:15:40 -0800
ben@skyportsystems.com wrote:

> From: Ben Warren <ben@skyportsystems.com>
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81d4baf..8f5dd35 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1125,6 +1125,15 @@ F: hw/nvram/chrp_nvram.c
>  F: include/hw/nvram/chrp_nvram.h
>  F: tests/prom-env-test.c
>  
> +VM Generation ID
> +M: Ben Warren <ben@skyportsystems.com>
> +S: Maintained
> +F: hw/acpi/vmgenid.c
> +F: include/hw/acpi/vmgenid.h
> +F: docs/specs/vmgenid.txt
> +F: tests/vmgenid-test.c
> +F: stubs/vmgenid.c
> +
>  Subsystems
>  ----------
>  Audio
