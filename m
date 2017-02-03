Received: from eggs.gnu.org ([2001:4830:134:3::10]:39070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZc2F-0007Uj-Ks
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZc2E-0005A3-ES
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:28:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZc2E-00059G-8H
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:28:10 -0500
Date: Fri, 3 Feb 2017 11:28:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170203112805.GE3208@work-vm>
References: <1486120416-11566-1-git-send-email-amit.shah@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486120416-11566-1-git-send-email-amit.shah@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: remove myself as maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit.shah@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, qemu list <qemu-devel@nongnu.org>

* Amit Shah (amit.shah@redhat.com) wrote:
> I'm switching jobs, and I'm not sure I can continue maintaining migration.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00b81f1..4382bcc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1431,7 +1431,6 @@ F: scripts/checkpatch.pl
>  
>  Migration
>  M: Juan Quintela <quintela@redhat.com>
> -M: Amit Shah <amit.shah@redhat.com>
>  M: Dr. David Alan Gilbert <dgilbert@redhat.com>
>  S: Maintained
>  F: include/migration/

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
