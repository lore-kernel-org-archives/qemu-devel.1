Received: from eggs.gnu.org ([2001:4830:134:3::10]:33606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRblh-0007lj-GG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRblg-0008Hi-S0
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:43:05 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-15-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <cba111e0-53f0-4ffe-d141-c73254688fdb@vivier.eu>
Date: Tue, 27 Nov 2018 12:42:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-15-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 14/25] MAINTAINERS:
 Add missing entries to the vhost section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 21:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e124792557..eab0fb9742 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1359,6 +1359,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported
>  F: hw/*/*vhost*
>  F: docs/interop/vhost-user.txt
> +F: contrib/vhost-user-*/
>  
>  virtio
>  M: Michael S. Tsirkin <mst@redhat.com>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
