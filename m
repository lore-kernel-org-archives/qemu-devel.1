Received: from eggs.gnu.org ([2001:4830:134:3::10]:46663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aneesh.kumar@linux.vnet.ibm.com>) id 1eYStB-00037d-PO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aneesh.kumar@linux.vnet.ibm.com>) id 1eYSt6-0001uf-St
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:34:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44376
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aneesh.kumar@linux.vnet.ibm.com>)
	id 1eYSt6-0001tU-NS
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:34:32 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w088Y8wI009274
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 03:34:31 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fc1ex17p1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 03:34:30 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Mon, 8 Jan 2018 08:34:29 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <151386885405.30639.8211398922585070373.stgit@bahia.lan>
References: <151386885405.30639.8211398922585070373.stgit@bahia.lan>
Date: Mon, 08 Jan 2018 14:04:25 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87po6kzr3i.fsf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Drop Aneesh as 9pfs maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

Greg Kurz <groug@kaod.org> writes:

> Aneesh has been working on other topics for some time now. Let's reflect
> that in the MAINTAINERS file, so that people stop Cc'ing him.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Acked-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  MAINTAINERS |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8859a50c365b..a61f3acb84ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1082,13 +1082,11 @@ F: include/hw/virtio/
>  F: tests/virtio-balloon-test.c
>
>  virtio-9p
> -M: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>  M: Greg Kurz <groug@kaod.org>
>  S: Supported
>  F: hw/9pfs/
>  F: fsdev/
>  F: tests/virtio-9p-test.c
> -T: git git://github.com/kvaneesh/QEMU.git
>  T: git git://github.com/gkurz/qemu.git 9p-next
>
>  virtio-blk
