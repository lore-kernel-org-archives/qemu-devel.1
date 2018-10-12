Received: from eggs.gnu.org ([2001:4830:134:3::10]:54386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAsoB-0002mu-W7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAsoB-0007DR-50
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAsoA-0007D7-Vc
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:28:31 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1539329710-11600-1-git-send-email-namei.unix@gmail.com>
Date: Fri, 12 Oct 2018 10:28:26 +0200
In-Reply-To: <1539329710-11600-1-git-send-email-namei.unix@gmail.com> (Liu
	Yuan's message of "Fri, 12 Oct 2018 15:35:10 +0800")
Message-ID: <87efcvsh5h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update block/sheepdog
 maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Yuan <namei.unix@gmail.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>

Liu Yuan <namei.unix@gmail.com> writes:

> From: Liu Yuan <liuyuan1@cmiot.chinamobile.com>
>
> E-mail to one of block/sheepdog maintainers Mitake Hitoshi bounces
>
> <mitake.hitoshi@lab.ntt.co.jp>: unknown user: "mitake.hitoshi"

Yup, got that, too.

> and no current address is known. So just remove it.
>
> Signed-off-by: Liu Yuan <liuyuan1@cmiot.chinamobile.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3275cc6..6670c16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2007,7 +2007,6 @@ F: block/rbd.c
>  T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>  
>  Sheepdog
> -M: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
>  M: Liu Yuan <namei.unix@gmail.com>
>  M: Jeff Cody <jcody@redhat.com>
>  L: qemu-block@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
