Received: from eggs.gnu.org ([2001:4830:134:3::10]:38219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gHBhX-0002rd-8K
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gHBhU-0001Bd-QY
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:51:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56754
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gHBhR-00015K-Bq
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:51:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9THn7kv190118
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 13:51:21 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ne6r7gjcw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 13:51:20 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 29 Oct 2018 13:51:20 -0400
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
	<1540827745-20795-4-git-send-email-borntraeger@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 29 Oct 2018 13:51:16 -0400
MIME-Version: 1.0
In-Reply-To: <1540827745-20795-4-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f8c4f80a-4799-9516-a22d-308e251c0592@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/4] MAINTAINERS: s390/pci:
 add Collin Walling as maintainer for zpci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 10/29/2018 11:42 AM, Christian Borntraeger wrote:
> Collin will take over the maintainership from Yi Min. Let us add a
> separate s390 pci section.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Collin Walling <walling@linux.ibm.com>

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cb23555..e63cfa2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -955,6 +955,12 @@ F: pc-bios/s390-ccw.img
>  T: git git://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
> +S390 PCI
> +M: Collin Walling <walling@linux.ibm.com>
> +S: Supported
> +F: hw/s390x/s390-pci*
> +L: qemu-s390x@nongnu.org
> +
>  UniCore32 Machines
>  -------------
>  PKUnity-3 SoC initramfs-with-busybox
> 


-- 
Respectfully,
- Collin Walling
