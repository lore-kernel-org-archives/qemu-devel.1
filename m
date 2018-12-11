Received: from eggs.gnu.org ([2001:4830:134:3::10]:39669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWp2D-0003sS-MV
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWp2C-0001a3-T0
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:53:41 -0500
References: <20181128153423.11916-1-cota@braap.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <83d57b16-336c-5dc3-1d2a-946d1ba34c0a@vivier.eu>
Date: Tue, 11 Dec 2018 21:53:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181128153423.11916-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH trivial]
 docs/devel/build-system: fix 'softmu' typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

On 28/11/2018 16:34, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  docs/devel/build-system.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
> index 52501f2ad9..f9fd27fab0 100644
> --- a/docs/devel/build-system.txt
> +++ b/docs/devel/build-system.txt
> @@ -393,7 +393,7 @@ all use $(obj) as a prefix to the target, e.g.
>  This file provides the entry point used to build each individual system
>  or userspace emulator target. Each enabled target has its own
>  subdirectory. For example if configure is run with the argument
> -'--target-list=x86_64-softmmu', then a sub-directory 'x86_64-softmu'
> +'--target-list=x86_64-softmmu', then a sub-directory 'x86_64-softmmu'
>  will be created, containing a 'Makefile' which symlinks back to
>  Makefile.target
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
