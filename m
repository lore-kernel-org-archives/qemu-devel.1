Received: from eggs.gnu.org ([2001:4830:134:3::10]:58607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMDwm-0006DN-0u
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMDwi-0002rQ-2S
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:11:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMDwh-0002rJ-SE
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:11:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13BC881E04
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 14:11:39 +0000 (UTC)
References: <20171205072220.885-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <820fd05a-3034-c15f-878b-9e2d3bb2c0c2@redhat.com>
Date: Tue, 5 Dec 2017 15:11:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171205072220.885-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAITAINERS: List Fam Zheng as reviewer for
 SCSI patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 05/12/2017 08:22, Fam Zheng wrote:
> Just so that I notice those patches more easily.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0255113470..64a138c380 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1000,6 +1000,7 @@ T: git git://github.com/jasowang/qemu.git net
>  
>  SCSI
>  M: Paolo Bonzini <pbonzini@redhat.com>
> +R: Fam Zheng <famz@redhat.com>
>  S: Supported
>  F: include/hw/scsi/*
>  F: hw/scsi/*
> @@ -1260,6 +1261,7 @@ T: git git://github.com/stefanha/qemu.git block
>  
>  Block SCSI subsystem
>  M: Paolo Bonzini <pbonzini@redhat.com>
> +R: Fam Zheng <famz@redhat.com>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: include/scsi/*
> 

Queued, thanks.

Paolo
