Received: from eggs.gnu.org ([2001:4830:134:3::10]:58753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbdC-000197-G6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbd7-0004EU-Jm
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:34:18 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1d672174-e667-6c68-0b51-5abdfd8b0885@vivier.eu>
Date: Tue, 27 Nov 2018 12:34:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 02/25] MAINTAINERS:
 Add a missing entry to the SPARC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c4f25fb05..ae12323647 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -281,6 +281,7 @@ S: Maintained
>  F: target/sparc/
>  F: hw/sparc/
>  F: hw/sparc64/
> +F: include/hw/sparc/sparc64.h
>  F: disas/sparc.c
>  
>  UniCore32
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
