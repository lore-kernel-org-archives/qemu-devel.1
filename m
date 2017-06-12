Received: from eggs.gnu.org ([2001:4830:134:3::10]:49058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKOPw-0001dE-Rh
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKOPt-0003kq-Uf
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dKOPt-0003kc-Cz
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:25:57 -0400
Date: Mon, 12 Jun 2017 13:25:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170612122550.GD2101@work-vm>
References: <20170612121820.31106-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612121820.31106-1-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: seccomp: change email contact
 for Eduardo Otubo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

* Eduardo Otubo (otubo@redhat.com) wrote:
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 120788d..0d065a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1490,7 +1490,7 @@ F: tests/vmstate-static-checker-data/
>  F: docs/migration.txt
>  
>  Seccomp
> -M: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> +M: Eduardo Otubo <otubo@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  S: Supported
>  F: qemu-seccomp.c
>  F: include/sysemu/seccomp.h
> -- 
> 2.9.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
