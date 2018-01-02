Received: from eggs.gnu.org ([2001:4830:134:3::10]:46409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRDU-0004EC-IQ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRDT-0007aJ-Oz
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:23:12 -0500
References: <1514910326-31234-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <684d262d-8966-b399-707a-f0d44cb91167@vivier.eu>
Date: Tue, 2 Jan 2018 19:22:40 +0100
MIME-Version: 1.0
In-Reply-To: <1514910326-31234-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-binfmt-conf.sh script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Le 02/01/2018 à 17:25, Thomas Huth a écrit :
> qemu-binfmt-conf.sh is used for the Linux usermode emulation, so
> let's add this file to that section in the MAINTAINERS file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73a5555..e92618f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1713,6 +1713,7 @@ R: Laurent Vivier <laurent@vivier.eu>
>  S: Maintained
>  F: linux-user/
>  F: default-configs/*-linux-user.mak
> +F: scripts/qemu-binfmt-conf.sh
>  
>  Tiny Code Generator (TCG)
>  -------------------------
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
