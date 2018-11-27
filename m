Received: from eggs.gnu.org ([2001:4830:134:3::10]:36841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbtv-0005KZ-1V
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbtt-0008AO-VS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:51:35 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-20-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0c4192f0-36b0-0870-3f33-502d5418bef1@vivier.eu>
Date: Tue, 27 Nov 2018 12:51:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-20-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 19/25] MAINTAINERS:
 Add a missing entry to the QMP section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac5d25491f..c73dde10a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1887,6 +1887,7 @@ S: Supported
>  F: qmp.c
>  F: monitor.c
>  F: docs/devel/*qmp-*
> +F: docs/interop/*qmp-*
>  F: scripts/qmp/
>  F: tests/qmp-test.c
>  F: tests/qmp-cmd-test.c
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
