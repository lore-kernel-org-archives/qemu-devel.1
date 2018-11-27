Received: from eggs.gnu.org ([2001:4830:134:3::10]:60417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbiE-0005Gc-48
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbi9-0006IO-73
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:39:30 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-9-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <25603abe-b60c-f431-9592-b40f491e6fb8@vivier.eu>
Date: Tue, 27 Nov 2018 12:39:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 08/25] MAINTAINERS:
 Add a missing entry for the Old World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81a22b2ccf..aa51ae813b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -936,6 +936,7 @@ F: hw/ppc/mac_oldworld.c
>  F: hw/pci-host/grackle.c
>  F: hw/misc/macio/
>  F: hw/intc/heathrow_pic.c
> +F: include/hw/intc/heathrow_pic.h
>  
>  PReP
>  M: Hervé Poussineau <hpoussin@reactos.org>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
