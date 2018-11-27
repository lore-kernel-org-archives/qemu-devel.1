Received: from eggs.gnu.org ([2001:4830:134:3::10]:36989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbun-0005yF-Tk
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbun-0008TN-8u
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:52:29 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-22-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <769172b4-499c-c227-c36d-9394bd2df3bd@vivier.eu>
Date: Tue, 27 Nov 2018 12:52:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-22-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 21/25] MAINTAINERS:
 Add a missing entry for the NVDIMM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26727c1561..92691589b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1475,6 +1475,7 @@ S: Maintained
>  F: hw/acpi/nvdimm.c
>  F: hw/mem/nvdimm.c
>  F: include/hw/mem/nvdimm.h
> +F: docs/nvdimm.txt
>  
>  e1000x
>  M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
